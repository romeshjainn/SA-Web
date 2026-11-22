# Generated Artifacts Registry

Files and directories that the **build** creates (they cannot truthfully exist before the work has happened). Every path referenced by the kit either already exists in the kit or is listed here with the phase that creates it. `scripts/validate-kit.sh` enforces this. When a phase creates an artifact, tick it and add the evidence to the phase log.

Kit-seeded files that already exist and are extended/finalised by a phase: `docs/design/BRIEF.md` (02), `docs/finance/NET_WORTH_RULES.md` (09, 14), `docs/finance/INVESTMENT_RULES.md` (13), `docs/ARCHITECTURE.md` and `docs/DEPENDENCIES.md` (01, 21), `docs/OWNERSHIP.md` (01), `docs/reviews/README.md` (template).

## Application directories (created in Phase 01 unless stated)

| Path | Purpose | Phase |
|---|---|---|
| `src/` (`app/`, `core/`, `design-system/`, `shared/`, `features/`, `pwa/`) | Next.js application | 01 |
| `public/` (icons, fonts, WASM/OCR assets, `sw.js` if hand-written) | Static assets, service worker | 01 (assets 02/04/07) |
| `supabase/` (`config.toml`, `migrations/`) | Database project, RLS | 01 (migrations from 03) |
| `tests/` (`fixtures/`, `perf/`, `security/`) | Jest tests and fixtures | 01 |
| `e2e/` | Playwright specs | 01 |
| `scripts/seed-synthetic` | Deterministic synthetic data seeder with canary strings | 01 |
| `.github/` | CI workflows | 01 |
| `.env.example`, `.gitignore` | Environment template, ignores | 00/01 |

## Documents

| Path | Created by phase |
|---|---|
| `docs/AUDIT_PHASE_00.md` | 00 |
| `docs/design/exploration/` (screenshots) | 02 |
| `docs/security/THREAT_MODEL.md` | 03 |
| `docs/security/CRYPTO_ARCHITECTURE.md` | 03 (addendum in 17) |
| `docs/security/KDF_BENCHMARKS.md` | 03 |
| `docs/security/AUTH_DESIGN.md` | 03 |
| `docs/reviews/PHASE_03_crypto_auth.md` | 03 |
| `docs/reviews/PHASE_04_storage_sync.md` | 04 |
| `docs/reviews/PHASE_06_credentials.md` | 06 |
| `docs/reviews/PHASE_07_scanners.md` | 07 |
| `docs/reviews/PHASE_08_debit.md` | 08 |
| `docs/reviews/PHASE_09_credit.md` | 09 |
| `docs/reviews/PHASE_11_documents.md` | 11 |
| `docs/reviews/PHASE_13_investments.md` | 13 |
| `docs/reviews/PHASE_14_networth.md` | 14 |
| `docs/reviews/PHASE_15_reminders.md` | 15 |
| `docs/reviews/PHASE_16_notes_lifecycle.md` | 16 |
| `docs/reviews/PHASE_17_sharing_backup_recovery.md` | 17 |
| `docs/reviews/PHASE_18_perf.md` | 18 |
| `docs/reviews/PHASE_19_integrations.md` | 19 |
| `docs/reviews/PHASE_20_*.md` (audit reports) | 20 |
| `docs/PERFORMANCE_REPORT.md` | 18 (re-run 20) |
| `docs/UI_STATE_MATRIX.md` | 18 |
| `docs/BROWSER_INTEGRATIONS.md` | 19 |
| `docs/TEST_REPORT.md` | 20 |
| `docs/RESIDUAL_RISKS.md` | 20 (final 21) |
| `docs/USER_GUIDE.md` | 21 |
| `docs/RECOVERY_GUIDE.md` | 17 (final 21) |
| `docs/OPERATIONS.md` | 21 |
| `docs/DEPLOYMENT.md` | 21 |
| `docs/CONTRIBUTING.md` | 21 |
| `docs/RELEASE_CHECKLIST.md` | 21 |
| `CHANGELOG.md`, `LICENSE` / third-party notices | 21 |
| `docs/decisions/ADR-0002…` (folder structure), ADR-0003 (design direction), further ADRs | as decided |
