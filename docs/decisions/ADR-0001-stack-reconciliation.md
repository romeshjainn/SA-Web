# ADR-0001: Unified Next.js architecture (no Vite, no separate backend)

- Date: 2026-11-22 (kit update); confirm in Phase 00/01
- Status: **Accepted (owner directive)**
- Phase: 00/01
- Requirement IDs: S02, S03

## Context
The original specification listed both "Next JS (use NextJS api also for backend)" and "Vite" (now explicitly not used). The project owner has resolved this: **Next.js is used exclusively.** Frontend, backend APIs, database integration and related services live in one Next.js codebase.

## Decision
1. **Framework:** Next.js (App Router) with **TypeScript (strict)** for the UI.
2. **Backend:** Next.js **Route Handlers** (`app/api/**/route.ts`) and, where appropriate, Server Actions. **No separate backend server** (no Express/Fastify/Nest/standalone Node service, no second repository or workspace for an API).
3. **Bundler/dev server:** the one built into Next.js (Turbopack/webpack as Next.js provides). **Vite is not used anywhere**: not as an app bundler, not as a dev server, and **not through Vitest**.
4. **Unit/integration/component tests:** **Jest via `next/jest` (SWC transform) + React Testing Library**, with `jest-environment-jsdom` for components and `node` environment for server/crypto code. Web Crypto is available in Node ≥ 20 (`globalThis.crypto`) for crypto tests. **Playwright** for E2E, responsive, accessibility (axe) and virtual-authenticator tests.
5. **Database/services:** Supabase (PostgreSQL, Auth, Storage) accessed from Route Handlers/Server Actions (server) and from the browser only for what RLS and the encryption model allow. Supabase is a managed service, not a custom backend we run. Migrations live in `supabase/migrations/` inside this repository.
6. **Workers and WASM:** Web Workers and WASM (Argon2id, OCR, OpenCV) are bundled by Next.js (`new Worker(new URL('./x.worker.ts', import.meta.url))`; WASM assets self-hosted from `public/` or imported as supported by the Next.js bundler). No second bundler for workers.
7. **Service worker/PWA:** implemented inside the Next.js project (`public/sw.js` or a Next.js-integrated library chosen by ADR in Phase 02/04). No separate PWA build toolchain.
8. **Single project:** one `package.json`, one lockfile, one deployable. Shared types/validators (zod schemas) are imported by both client and Route Handlers. Optional internal module boundaries are folders, not separate packages (a monorepo is not used).

## Alternatives rejected
- Next.js + Vite app: two bundlers, duplicated config, no benefit.
- Vitest: depends on Vite; replaced by Jest (officially supported by Next.js via `next/jest`).
- Separate Node API server: contradicts "NextJS api for backend" and adds deployment/CSRF/CORS surface.

## Consequences
- One toolchain, one deployment target, end-to-end type sharing.
- Route Handlers must run in the **Node.js runtime** where crypto/server libraries require it (`export const runtime = 'nodejs'`); Edge runtime only where verified compatible.
- Server code must never receive plaintext vault data or the master password (see `docs/SECURITY_PRINCIPLES.md`); keeping the API in the same codebase does not change the zero-knowledge design.
- If Phase 00 finds an existing non-Next.js codebase, the owner directive still applies: migrate **by adapting, not destroying**; record the migration plan in a new ADR before changing anything.
- Revisit only with the owner's explicit approval.
