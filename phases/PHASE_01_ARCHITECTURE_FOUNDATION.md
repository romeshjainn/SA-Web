# Phase 01 — Architecture and Foundation

**Covers:** S02, S03, S32 (foundations), S33 (tooling)
**Depends on:** 00
**Unlocks:** 02, 03

## Objective
Establish the modular application architecture, project scaffolding, shared core services, data boundaries and test/CI infrastructure.

## Requirements
- Scaffold (or adapt existing) a **single Next.js App Router project** (`create-next-app`, TypeScript strict, Tailwind, ESLint) per `docs/ARCHITECTURE.md`; add Supabase client libraries, **Jest (`next/jest`) + React Testing Library**, Playwright, Prettier. Pin dependencies exactly per `docs/DEPENDENCIES.md`. **No Vite/Vitest, no separate backend server, no monorepo/workspaces.** If network/package installs are unavailable, record it as a limitation and scaffold what is possible.
- npm scripts: `dev`, `build`, `start`, `lint`, `typecheck`, `test` (Jest), `test:e2e` (Playwright), `db:*` (Supabase CLI wrappers), `seed:synthetic`.
- Backend = `app/api/**/route.ts` Route Handlers (Node runtime where crypto/server libs need it) + Server Actions where appropriate, sharing zod schemas/types with the client. Database access goes through a server-only `core/data/server` layer (`import 'server-only'`).
- Decide and record folder structure after inspecting the repo (ADR-0002); **update `docs/OWNERSHIP.md` with real paths.**
- Separate: application shell, core infrastructure, authentication, security/crypto, data access, storage, synchronization, shared UI, design system, feature modules, testing infrastructure, platform/browser integrations.
- Shared service **interfaces and initial implementations** (contracts first): authentication, cryptography, data access, encryption, storage, cache management, synchronization, error handling (typed error model, no sensitive data in messages), validation (zod), notifications, reminders (interface), search (interface), permissions, logging (redaction by design), UI state management, accessibility utilities.
- Feature-module contract: `registerModule({ id, routes, searchProvider, quickActions, reminderSources, relationTypes, dashboardWidgets, ... })` so a future module needs no core rewrite.
- Safe logger with redaction + canary-test hook; central error boundary; env/config validation; no telemetry.
- Web security baseline in `next.config`/middleware: strict CSP with nonces, `Referrer-Policy`, `X-Content-Type-Options`, `frame-ancestors 'none'`, `Permissions-Policy`, HSTS.
- Supabase: local dev setup (CLI/Docker if available, else documented alternative), migration workflow, RLS-by-default convention (every table has RLS + owner policy + tests).
- CI workflow (lint, typecheck, unit, integration, Playwright smoke). `scripts/seed-synthetic` skeleton with canary strings.
- Dependency-boundary lint rules (no cross-feature deep imports).
- Docs: review and finalise the kit baseline `docs/ARCHITECTURE.md` against the real scaffold (add layer/data-flow/module-registration diagrams; record deviations in ADR-0002), and `docs/DEPENDENCIES.md` (record resolved versions). Create the module README template.

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| 0 | Contracts/types for core services | `core/**/types` | Lead (high reasoning) |
| A | Scaffold, config, CI, lint rules | root configs, `.github/` | Builder |
| B | Logging, errors, validation, config | `core/{logging,errors,validation,config}` | Builder |
| C | Supabase local setup + migration/RLS conventions + server-only data layer | `supabase/**`, `core/data/server` | Builder |
| D | Test infrastructure + synthetic seeder skeleton | `tests/`, `e2e/`, `scripts/` | Test agent |
| E | Finalise architecture + dependency docs | `docs/ARCHITECTURE.md`, `docs/DEPENDENCIES.md` | Docs agent |
Stream 0 first; A–E then run in parallel in worktrees.

## Acceptance criteria
- `npm run build`, `lint`, `typecheck`, unit and Playwright smoke succeed (actual results recorded).
- A trivial sample module registers through the module contract with no core edits.
- Logger redaction proven by a test using canary strings.
- OWNERSHIP.md reflects real paths; ADR-0002 recorded.

## Testing requirements
Jest unit tests for logger redaction, error model, validation helpers, module registry; a Route Handler test (invoked directly); Playwright smoke E2E (app loads, security headers present). Confirm `grep -ri vite` over config/deps returns nothing.

## Independent review
Reviewer checks architecture boundaries and security headers/CSP.

## Checkpoint
Standard; tag `phase-01-complete` if gate passes.
