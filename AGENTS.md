# AGENTS.md — Shared Rules for All Agents (Codex, Claude Code, subagents)

This file is the Codex-native and tool-neutral instruction set. `CLAUDE.md` is the entry point; this file holds the rules every agent must follow. Keep both in sync (a change here that affects entry flow must be mirrored in `CLAUDE.md`).

## Project

**Personal Vault — Personal Life OS**: a premium, secure, modular, offline-capable personal web application (installable PWA) for passwords, cards, bank accounts, documents, vehicles, investments, notes, subscriptions, reminders and net worth. Core philosophy: **Find → Reveal → Use**.

It must be a real, functional application. No mockups, placeholders, or fake implementations standing in for working features.

## Stack (decided — ADR-0001: unified Next.js)

**Next.js exclusively** (App Router) with TypeScript for the frontend; Next.js **Route Handlers / API routes (and Server Actions)** are the backend, all in one codebase. Tailwind CSS, Supabase (Postgres, Auth, Storage), **Jest via `next/jest` + React Testing Library** for unit/integration/component tests, **Playwright** for E2E, Web Crypto + Argon2id (WASM) where justified. **Do not use Vite or Vitest, and do not create a separate backend server** (no Express/Fastify/Nest, no second service or workspace). See `docs/ARCHITECTURE.md` and `docs/DEPENDENCIES.md`. Deviations require an ADR in `docs/decisions/` and owner approval.

## Hard rules

### Platform
1. Web app only. Do not convert to Android/iOS native.
2. Never install or launch Android Studio, Android SDK, emulators, iOS simulators, or any native mobile toolchain. Do not make physical devices a prerequisite for anything.
3. Mobile-browser compatibility and responsiveness are mandatory in every UI phase.
4. PWA installability on phones is required using web-only tooling (manifest, service worker, icons, HTTPS). Verify with browser tooling (e.g. Lighthouse/DevTools/Playwright checks).

### Security
5. Never log passwords, master passwords, keys, decrypted vault contents, CVVs, full card details, document contents, financial records, or recovery secrets.
6. Never store secrets or decrypted sensitive data in plaintext localStorage/sessionStorage, URLs, or backend tables.
7. Authentication is separate from vault encryption. A database password or auth token is never the encryption key.
8. Do not invent crypto. Use vetted primitives (Web Crypto AES-GCM, Argon2id, HKDF, CSPRNG). Unique nonce per encryption. No hardcoded secrets. Key separation and a documented key hierarchy.
9. Never auto-extract or save CVV. Never trust scanned content without user verification.
10. No telemetry, tracking, or unnecessary third-party services.
11. Never claim "secure", "audited", or "tested" beyond what was actually performed. Document residual risks honestly.
12. Test with synthetic data only.

### Product and UX
13. Minimal, clean, uncluttered. Few options visible at a time; progressive disclosure for advanced controls.
14. Genuinely modern, distinctive design (not a generic AI look). Design/UX is the main USP. Follow `docs/DESIGN_PRINCIPLES.md`.
15. Light and dark themes everywhere. Respect `prefers-color-scheme` and `prefers-reduced-motion`.
16. Every major operation handles: loading, empty, error, success, saving/saved, offline, pending sync, sync failure, partial failure, conflict, validation error, unauthorized, expired session. No silent failures.
17. Accessibility is built into components, not bolted on at the end.

### Process
18. Inspect repository and Git state before editing. Never destroy existing work. Never blind reset/overwrite.
19. Work sequentially through phases; do not skip gates (but see environmental-limitation policy in `docs/PHASE_GATES.md`).
20. Do not pause for routine approval. Make reasonable decisions and record them as ADRs.
21. Keep `PROGRESS.md`, `REMOTE_PROGRESS/STATUS.md`, `REMOTE_PROGRESS/PHASE_LOG.md` current at every meaningful checkpoint.
22. Do not falsely claim agent work, tests, benchmarks, or verification. Distinguish measured vs. simulated results.
23. Do not restart completed work because the model, reasoning level, or session changed.
24. Execute continuously without waiting for approval; complete all phases through Phase 21 unless a genuine blocker (see `docs/PHASE_GATES.md`) occurs. Do not stop to ask the user routine questions.

25. Load the skills assigned in `SKILLS.md` before each stream; fall back to the listed checklist if a skill is unavailable. Skills never override these rules.

## Conventions

- TypeScript strict mode. No `any` without a justifying comment.
- Feature-oriented modules with explicit public APIs; no cross-module deep imports.
- Shared services live in core; features depend on core, never on each other directly (use relationships/events/interfaces).
- Conventional commits (`feat:`, `fix:`, `test:`, `docs:`, `chore:`, `sec:`). One logical change per commit.
- Branches: `phase/NN-short-name` for phase integration; `agent/<phase>-<stream>` for worktree streams.
- Every module has: README (purpose, public API, data shape, security notes), tests, and entries in the traceability doc if it satisfies a requirement.

## Reasoning/resource strategy

Use strongest reasoning for architecture, cryptography, security, data integrity, recovery, difficult debugging and independent audits. Use bounded agents for routine implementation, docs, tests, UI tasks and repetitive work. See `docs/MULTI_AGENT_COORDINATION.md`.

## Key files

`CLAUDE.md`, `SKILLS.md`, `ROADMAP.md`, `phases/`, `docs/`, `PROGRESS.md`, `REMOTE_PROGRESS/`.
