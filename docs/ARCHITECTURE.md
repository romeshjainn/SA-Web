# Architecture — Unified Next.js (kit baseline)

Decision record: `docs/decisions/ADR-0001-stack-reconciliation.md`. This document is the **baseline** that Phase 01 finalises (ADR-0002 records any deviation after inspecting the real repository) and that Phase 21 publishes as final.

## Principles

1. **One project, one codebase, one deployable.** Next.js (App Router) + TypeScript. One `package.json`, one lockfile. No monorepo/workspaces, no separate backend service.
2. **Frontend and backend together.** UI = React Server/Client Components. Backend = **Route Handlers** (`app/api/**/route.ts`) and **Server Actions**. Both import shared types and zod schemas.
3. **Zero-knowledge by design.** Colocating the backend does not change the security model: the server never receives the master password, vault keys or plaintext vault content. Cryptography runs in the browser (Web Crypto + Argon2id WASM, in Web Workers). Route Handlers handle authentication-adjacent work, ciphertext persistence, authorization, rate limiting and share-link enforcement.
4. **Single toolchain.** Bundling, dev server, workers and WASM are handled by Next.js. **No Vite/Vitest.** Tests: Jest (`next/jest`) + React Testing Library; Playwright for E2E.
5. **Modular and feature-oriented.** Features are folders with public APIs registered through a module registry; adding a module requires no core rewrite.

## Runtime boundaries

| Zone | Where it runs | May touch | Must never touch |
|---|---|---|---|
| Client crypto & vault logic | Browser (main thread + Web Workers) | master password (in memory only), keys, plaintext | server logging, URLs, plaintext storage |
| Client UI | Browser | decrypted view-models in memory | secrets in localStorage/sessionStorage |
| Route Handlers / Server Actions | Next.js server (Node runtime unless verified for Edge) | ciphertext, ids, owner, timestamps, auth session, rate-limit state | plaintext vault data, master password, vault keys |
| Supabase (Postgres/Auth/Storage) | Managed service | ciphertext + minimal metadata, RLS-enforced | plaintext secrets |
| Service worker | Browser | static assets, app shell | plaintext sensitive API responses |

`server-only` / `client-only` imports enforce zones at build time. ESLint boundary rules block `core/crypto`-plaintext modules from server imports and block feature-to-feature deep imports.

## Proposed layout (finalise in Phase 01; update `docs/OWNERSHIP.md`)

```
src/
  app/                        Next.js App Router
    (auth)/                   signup, login, unlock, recovery
    (shell)/                  authenticated app shell: dashboard, modules, settings
    s/[token]/                public share viewer (Phase 17)
    api/                      Route Handlers (backend)
      auth/  records/  blobs/  share/  health/ ...
    layout.tsx  manifest.ts  not-found.tsx  error.tsx
  core/                       framework-agnostic infrastructure (no UI)
    crypto/                   KDF, AEAD, HKDF, envelopes, key hierarchy        (client-only)
    auth/                     account auth, vault unlock, sessions, WebAuthn
    data/                     data-access interfaces; data/server (server-only, Supabase)
    storage/                  encrypted IndexedDB, blob encryption
    sync/                     mutation queue, sync engine, conflicts
    search/  favorites/  recents/  actions/  relations/  lifecycle/  activity/
    reminders/  notifications/  finance/
    logging/  errors/  validation/  config/  permissions/  workers/
  design-system/              tokens, themes, primitives, overlays, states, a11y
  shared/ui/                  composite UI (shell, camera, payment-card, relations, sync)
  features/                   one folder per module, each with data/ ui/ types/ index.ts + README
    credentials/ contacts/ debit-cards/ credit-cards/ bank-accounts/ documents/
    vehicles/ investments/ networth/ dashboard/ reminders/ subscriptions/
    notes/ backup/ sharing/ scan-card/ scan-document/ scan-qr/ settings/
  pwa/                        service-worker source/helpers, install UX
public/                       icons, self-hosted fonts, WASM/OCR assets, sw.js (if hand-written)
supabase/                     config.toml, migrations/, seed (synthetic only), policy tests
tests/                        Jest tests (unit/integration/component/route-handler), fixtures
e2e/                          Playwright specs, fixtures, virtual-authenticator helpers
scripts/                      seed-synthetic, validate-kit.sh, tooling
docs/                         kit + architecture + security + reviews
```

Path aliases (`@/core/*`, `@/features/*`, …) are configured in `tsconfig.json`; Jest maps them via `next/jest` + `moduleNameMapper`.

## Backend inside Next.js

- **Route Handlers** are thin: parse/validate (zod) → authorise (session + RLS) → call a server-only service → return typed JSON. Each sets `export const runtime = 'nodejs'` unless verified otherwise and `dynamic = 'force-dynamic'` where responses must not be cached.
- **Server Actions** may be used for form-style mutations (e.g. settings); same validation/authorisation/CSRF rules apply.
- **Middleware** (`middleware.ts`): CSP nonces, security headers, session refresh, coarse rate limiting hooks. Heavy logic stays in handlers.
- **Database integration**: `core/data/server` wraps Supabase (service-role key only in server-only code and only where unavoidable; user-scoped clients preferred so **RLS is the enforcement**). Migrations in `supabase/migrations/`; every table has RLS, owner policies and tests.
- **Rate limiting / abuse prevention**: implemented in-project (e.g. database-backed counters in Supabase or a documented in-memory fallback for dev); no external service unless an ADR approves it.
- **Share links (Phase 17)**: `app/s/[token]` page + `app/api/share/*` handlers; expiry checked server-side on every read.

## Key flows

**Create record (online):** UI form → client builds plaintext view-model → worker encrypts (AES-GCM envelope, AAD binds id/type/version) → `POST /api/records` with ciphertext + minimal metadata → handler validates + authorises → Supabase insert (RLS) → response; local encrypted store updated.

**Create record (offline):** same encryption → durable mutation queue in encrypted IndexedDB → sync engine replays on reconnect with idempotent client ids → conflicts surfaced, never silently dropped.

**Unlock:** master password → Argon2id (worker) → master key → unwrap DEKs fetched via `GET /api/vault/keys` (wrapped material only) → keys held in memory, non-extractable where possible → auto-lock wipes.

## Testing map (see `docs/TESTING_STRATEGY.md`)

| Layer | Tooling |
|---|---|
| Unit/integration (crypto, finance, sync, server services) | Jest (`next/jest`, `node` env) |
| Route Handlers | Jest calling `GET/POST` exports with `Request`; Playwright request API against running server |
| Components | Jest + jsdom + React Testing Library |
| E2E, responsive, a11y, PWA, WebAuthn (virtual authenticator), offline | Playwright (+ axe) |
| Database/RLS | SQL/pgTAP or Jest against local Supabase |

## Build and deployment

`next build` produces one artefact (Node server or platform-hosted). Environment variables validated at startup (`core/config`). Source-map and header policies set in `next.config`. Deployment guidance is finalised in Phase 21 (`docs/DEPLOYMENT.md`); Supabase is the only external service.

## Constraints that remain from the spec

Web-only (no Android/iOS tooling), installable PWA, offline-first encrypted storage, mobile-first responsive, light/dark themes, minimal UI, no telemetry.
