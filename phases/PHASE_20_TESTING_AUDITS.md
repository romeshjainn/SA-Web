# Phase 20 — Comprehensive Testing and Independent Audits

**Covers:** S33, S04 (security verification), S29, S30, S31, S34, S36 (revisit limitations)
**Depends on:** 00–19
**Unlocks:** 21

## Objective
Prove (to the extent possible) and independently challenge quality: complete test coverage by category, security review, accessibility review, responsive validation, performance evaluation and code audits. Fix defects; document residual risks.

## Requirements

### Comprehensive test run (see `docs/TESTING_STRATEGY.md`)
Unit, integration, component, E2E, browser automation, responsive, accessibility, security, performance and data-integrity suites, covering: authentication, encryption, decryption, key derivation, storage, synchronization, recovery, authorization, CRUD for every module, relationships, calculations (net worth, credit, investments, subscriptions), search, scanners, documents, reminders, offline workflows, responsive layouts, UI states, theme switching, PWA checks. **Synthetic data only.** Record exact commands and results; never claim unrun tests.

### Independent audits (each by a fresh agent with an adversarial brief; reports in `docs/reviews/PHASE_20_*.md`)
1. **Cryptography and key management** (envelope format, nonce handling, KDF params, rotation, recovery, WebAuthn/PRF).
2. **Authentication, authorization, sessions, RLS/database policies** (two-user attack tests, direct PostgREST access, storage policies).
3. **Storage, offline cache, sync, backup, sharing, recovery**.
4. **Web security**: XSS (including note/markdown rendering and user-supplied URLs), CSRF, CSP effectiveness, clickjacking, open redirects, dependency vulnerabilities (`npm audit`, lockfile review, supply-chain review of crypto/OCR/WASM deps), secrets scanning of the repo and build output, source-map exposure, header review.
5. **Privacy/leak audit**: canary scan across logs, URLs, localStorage/sessionStorage/IndexedDB, Service Worker caches, network payloads, DB rows, storage objects, activity log, error reports, clipboard behaviour, screenshot/task-switcher blur.
6. **Accessibility audit**: axe on every route/state in both themes, keyboard-only walkthroughs, screen-reader semantics review, 200% text zoom, reduced motion, contrast.
7. **Responsive validation**: all key flows at 360, 390, 768, 1024, 1440 (+320, 1920), no overflow/clipping, touch targets, camera views, dialogs, charts, tables; orientation changes.
8. **Performance evaluation**: re-run Phase 18 benchmarks; label measured vs simulated.
9. **Design review**: minimalism, consistency, distinctiveness vs generic AI look, theme polish.
10. **Requirements traceability audit**: every row in `docs/REQUIREMENTS_TRACEABILITY.md` has evidence or a documented, justified limitation.

### Defects and risks
Triage (Critical/High/Medium/Low), **fix Critical and High**, schedule or accept Medium/Low explicitly. Create `docs/RESIDUAL_RISKS.md` and update `docs/security/THREAT_MODEL.md` (can/cannot protect). **Revisit environmental limitations** recorded earlier; use newly available tools if any (still no native mobile tooling).

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| A | Full test-suite execution/triage | `tests/`, `e2e/` | Test agents (sharded) |
| B | Security audits 1–5 | `docs/reviews/` | Independent security reviewers (strongest) |
| C | Accessibility + responsive + design audits 6, 7, 9 | `docs/reviews/` | Independent UI reviewers |
| D | Perf audit 8 + traceability audit 10 | `docs/` | Reviewer |
| E | Defect fixing | owning module paths (one fixer per module) | Builders |
Audit agents report; fixers fix; auditors re-verify fixes.

## Acceptance criteria
- All suites green or failures explicitly accepted with rationale; no Critical/High open.
- Audit reports present; residual-risk register honest; traceability complete.
- No claim of "secure/perfect" anywhere; statements reflect what was actually done.

## Testing requirements
This phase *is* the testing phase; record full command logs and results in `docs/TEST_REPORT.md`.

## Checkpoint
Standard; tag `phase-20-complete`.
