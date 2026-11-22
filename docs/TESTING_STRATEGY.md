# Testing Strategy

Covers spec §33, §29, §30, §34. **Use synthetic data only. Never claim a test ran or passed unless it did.**

## Tooling

| Layer | Tool |
|---|---|
| Unit / integration | Jest via `next/jest` (SWC); `node` environment for crypto/server code; **no Vite/Vitest** |
| Route Handler tests | Jest invoking `route.ts` handlers directly with `Request`/`Response` objects (plus Playwright API tests against the running Next.js server) |
| Component | Jest (`jest-environment-jsdom`) + React Testing Library + `@testing-library/user-event` |
| E2E / browser / responsive | Playwright (Chromium; add Firefox/WebKit where available) |
| Accessibility | axe (via `@axe-core/playwright` / `jest-axe`) + manual keyboard checks |
| Performance | Lighthouse (where available), Playwright tracing, `performance.measure`, CPU throttling via CDP |
| Security | Dedicated tests (see below), dependency audit (`npm audit`), static checks, manual review |

If a tool cannot be installed (e.g. network restrictions), record it as a limitation and use the closest available alternative. Do not install Android/iOS tooling.

## Test categories and minimum coverage

1. **Unit**: crypto primitives wrappers (known-answer vectors), KDF parameter handling, password generator/strength, net-worth engine, credit utilization, investment P/L, recurrence rules, validators, search ranking.
2. **Integration**: auth flow, vault unlock, encrypted CRUD round trip, sync queue + conflict resolution, RLS/authorization (cross-account access must fail), storage upload/download of encrypted blobs, relationships, backup → restore.
3. **Component**: every design-system component states (default, hover, focus, disabled, error, loading); forms; dialogs focus trap.
4. **E2E (Playwright)**: signup/login/unlock/lock/logout, create/edit/delete/archive/restore for every module, global search, quick actions, scanners (with synthetic fixture images and fake media streams), reminders, offline → online sync, backup/restore, theme switching, PWA install checks.
5. **Responsive**: run key flows at 360, 390, 768, 1024, 1440 (plus 320 and 1920 where useful). Assert: no horizontal overflow (`scrollWidth <= clientWidth`), no clipped/inaccessible controls, touch targets ≥ 44px, dialogs usable, tables adapt.
6. **Accessibility**: axe on every route/state in light and dark; keyboard-only flows; focus management in dialogs; reduced-motion; contrast.
7. **Security**: 
   - Plaintext never present in DB rows/Storage objects (inspect raw rows with synthetic secrets).
   - No secrets in logs (capture console/server logs during flows and grep for synthetic canaries).
   - No secrets in URLs, localStorage, sessionStorage, IndexedDB (plaintext canary scan).
   - AES-GCM nonce uniqueness; tamper detection (modified ciphertext fails).
   - KDF parameters enforced; wrong password fails closed.
   - Session expiry/reauth; CSRF protections; XSS sanitization of rendered user input; CSP headers.
   - Authorization: user A cannot read/write user B's data via API or direct DB access.
   - Share links: expiry enforced server-side, revocation, token unpredictability.
8. **Performance**: bundle size budget, route-level code splitting, search latency on a synthetic 5k-item vault, KDF timing measured in-browser, memory snapshot, request count per screen (dedupe).
9. **Data integrity**: sync never silently drops mutations; crash-during-write simulation; backup integrity verification; migration up/down.

## Synthetic data

- Provide a deterministic seeder (`scripts/seed-synthetic`) with fake credentials, Luhn-valid **test** card numbers (e.g. documented test BINs), fake IFSC/PAN-like values clearly marked synthetic, fake documents/images.
- Include **canary strings** (e.g. `CANARY-SECRET-7f3a`) inside secrets for leak scanning.

## Reporting

- After each run, record in `PHASE_LOG.md`: exact command, pass/fail counts, skipped tests (and why).
- Flaky tests are fixed or explicitly quarantined with a note; they cannot be silently ignored at a gate.
- Measured vs simulated: label benchmark results as `measured on <hardware>` or `simulated (CPU throttle Nx)`.

## Jest setup notes

- `jest.config.ts` via `next/jest` (SWC). Projects: `node` (crypto, finance, sync, server services, Route Handlers) and `jsdom` (components). `moduleNameMapper` mirrors tsconfig path aliases. Use `globalThis.crypto` (Node ≥ 20) for Web Crypto tests; `fake-indexeddb` for IndexedDB tests; controllable clock via Jest fake timers.
- Route Handler tests import `route.ts` and call `POST(new Request(...))` directly; Supabase interactions use the local Supabase stack or an in-test interface fake **at the data-layer boundary only** (never fake the crypto).
- Playwright `webServer` starts `next dev`/`next start`; it never starts any other backend process.
- No Vite/Vitest anywhere (`grep -ri vite` over config/deps must be empty).

## CI

Add a CI workflow (GitHub Actions or equivalent) in Phase 01 that runs lint, typecheck, unit, integration, and a Playwright smoke suite. Expand per phase.
