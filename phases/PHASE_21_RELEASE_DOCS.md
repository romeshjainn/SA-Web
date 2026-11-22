# Phase 21 — Release and Documentation

**Covers:** S41, S01, S02, S35 (completion), S40 (final recovery docs)
**Depends on:** 20

## Objective
Finalise the application for release: documentation, deployment readiness, operational guidance, security documentation and release procedures. Verify the Definition of Done honestly.

## Requirements
- **Documentation set**: `docs/ARCHITECTURE.md` (final; unified Next.js), `docs/security/` (threat model, crypto architecture, auth design, residual risks — final, truthful), `docs/USER_GUIDE.md` (setup, master password and recovery key guidance, backups, scanners, offline, PWA install on phones — including iOS/Android browser steps), `docs/RECOVERY_GUIDE.md`, `docs/OPERATIONS.md` (environments, secrets handling, Supabase setup/migrations, backups of the server DB, monitoring **without telemetry/PII**, incident response, key/dependency rotation), `docs/DEPLOYMENT.md`, `docs/CONTRIBUTING.md`, module READMEs complete, `CHANGELOG.md`, `LICENSE`/third-party notices (fonts, OCR/WASM libs).
- **Deployment readiness**: production build, environment validation, security headers/CSP verified in a production-like run, HTTPS/HSTS guidance, Supabase production configuration checklist (RLS verified, auth settings, rate limits, storage policies), migration plan, rollback plan, seed/synthetic data excluded from production, source maps policy, dependency pinning, CI/CD pipeline.
- **Release procedure**: version tagging, release checklist (`docs/RELEASE_CHECKLIST.md`), smoke-test script for post-deploy, backup-before-migrate procedure.
- **Definition of Done verification** against `docs/DEFINITION_OF_DONE.md` with evidence per line; mark unmet items as limitations.
- Final traceability check: every requirement ID has evidence; `bash scripts/validate-kit.sh` still passes; update `ROADMAP.md` statuses; final `PROGRESS.md` and `REMOTE_PROGRESS/*` entries.
- Final honest summary: what was verified, what was simulated, what couldn't be verified (e.g. physical-device camera/PWA install UX), residual risks, known defects.

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| A | User/ops/deployment docs | `docs/` | Docs agent |
| B | Release pipeline + checklists + smoke tests | `.github/`, `scripts/`, `docs/RELEASE_CHECKLIST.md` | Builder |
| C | Production-like verification (headers, build, PWA) | `e2e/` | Test agent |
| D | Final DoD verification + review | `docs/` | Independent reviewer |

## Acceptance criteria
- A new engineer can deploy and operate from the docs; recovery guide matches product behaviour.
- Production build passes smoke tests; DoD checklist complete with evidence or documented limitations.
- No false claims of perfection, complete security or unperformed tests.

## Testing requirements
Production-build E2E smoke, header/CSP checks, PWA audit, backup/restore drill from docs, final full-suite run.

## Checkpoint
Final commit, tag `v1.0.0` (or appropriate), final progress entry: project COMPLETE or COMPLETE_WITH_LIMITATIONS.
