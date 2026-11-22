# Path Ownership (template — finalize in Phase 01 after repo inspection)

Spec §3: do not force a folder structure before inspecting the repository. Phase 01 decides the real structure, records it in ADR-0002, and **replaces the "proposed" column below with actual paths**.

| Area | Proposed path | Owner | Notes |
|---|---|---|---|
| App shell / routing | `src/app/**` | Lead | Next.js App Router (single project; see `docs/ARCHITECTURE.md`) |
| Core infrastructure | `src/core/**` | Lead | errors, logging, validation, config, events |
| Crypto & security | `src/core/crypto/**`, `src/core/security/**` | Lead + Security reviewer | Strongest reasoning |
| Auth | `src/core/auth/**` | Lead | Separate from vault crypto |
| Data access / sync / storage | `src/core/data/**`, `src/core/sync/**`, `src/core/storage/**` | Lead | |
| Design system | `src/design-system/**` | Design stream | Tokens, themes, primitives |
| Shared UI | `src/shared/ui/**` | Design stream | Composite components |
| Feature modules | `src/features/<module>/**` | One builder per module | No cross-feature deep imports |
| API route handlers | `src/app/api/**` | Lead / module builder for own module | |
| Server-only data layer | `src/core/data/server/**` | Lead | `import 'server-only'`; Supabase access |
| DB schema & policies | `supabase/migrations/**` | Lead | One migration per stream |
| Tests (Jest unit/integration/component/route-handler) | `tests/**` | Stream owner | Jest via `next/jest` |
| E2E tests | `e2e/**` | Test agent | |
| Docs | `docs/**` | Docs agent (lead for decisions) | |
| Progress files | `PROGRESS.md`, `REMOTE_PROGRESS/**` | **Lead only** | |

Rules:

- Feature modules: `src/features/<name>` expose a public `index.ts`; everything else is private.
- Features talk through core services, the relationships service, or the event bus — never direct imports of another feature's internals.
- Lead-owned files are changed by builders only through a requested "interface change".
