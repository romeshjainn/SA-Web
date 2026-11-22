# ROADMAP

**Stack (ADR-0001):** unified Next.js (App Router) + TypeScript; backend = Route Handlers/Server Actions in the same project; Supabase for Postgres/Auth/Storage; Jest + Playwright for tests. **No Vite/Vitest, no separate backend server.** See `docs/ARCHITECTURE.md`, `docs/DEPENDENCIES.md`.

Status values: `NOT_STARTED` · `IN_PROGRESS` · `COMPLETE` · `COMPLETE_WITH_LIMITATIONS`

Update the status column only when the phase gate in `docs/PHASE_GATES.md` is satisfied.

| # | Phase | File | Depends on | Status |
|---|---|---|---|---|
| 00 | Discovery and Repository Audit | `phases/PHASE_00_DISCOVERY_AUDIT.md` | — | NOT_STARTED |
| 01 | Architecture and Foundation (unified Next.js scaffold) | `phases/PHASE_01_ARCHITECTURE_FOUNDATION.md` | 00 | NOT_STARTED |
| 02 | Design System, Responsive UX, Accessibility, Themes, PWA shell | `phases/PHASE_02_DESIGN_SYSTEM.md` | 01 | NOT_STARTED |
| 03 | Authentication, Threat Model, Cryptography | `phases/PHASE_03_AUTH_CRYPTO.md` | 01 (02 for UI) | NOT_STARTED |
| 04 | Encrypted Storage, Cache, Offline, Sync | `phases/PHASE_04_STORAGE_OFFLINE_SYNC.md` | 03 | NOT_STARTED |
| 05 | Global Search, Favorites, Recents, Quick Actions | `phases/PHASE_05_SEARCH_QUICK_ACTIONS.md` | 02, 04 | NOT_STARTED |
| 06 | Credentials, Password Intelligence, Saved Contacts | `phases/PHASE_06_CREDENTIALS.md` | 04, 05 | NOT_STARTED |
| 07 | Scanners, OCR, QR | `phases/PHASE_07_SCANNERS_OCR_QR.md` | 02, 04 | NOT_STARTED |
| 08 | Debit Cards | `phases/PHASE_08_DEBIT_CARDS.md` | 06, 07 | NOT_STARTED |
| 09 | Credit Cards and Liabilities | `phases/PHASE_09_CREDIT_CARDS.md` | 08 | NOT_STARTED |
| 10 | Bank Accounts | `phases/PHASE_10_BANK_ACCOUNTS.md` | 06 | NOT_STARTED |
| 11 | Document Vault | `phases/PHASE_11_DOCUMENT_VAULT.md` | 07, 04 | NOT_STARTED |
| 12 | Vehicles | `phases/PHASE_12_VEHICLES.md` | 11 | NOT_STARTED |
| 13 | Investments | `phases/PHASE_13_INVESTMENTS.md` | 10 | NOT_STARTED |
| 14 | Financial Dashboard and Net Worth | `phases/PHASE_14_NET_WORTH_DASHBOARD.md` | 09, 10, 13 | NOT_STARTED |
| 15 | Reminders, Calendar, Subscriptions | `phases/PHASE_15_REMINDERS_SUBSCRIPTIONS.md` | 09, 11, 12 | NOT_STARTED |
| 16 | Notes (incl. Ideas), Relationships, Archive, Trash, Activity | `phases/PHASE_16_NOTES_RELATIONSHIPS.md` | 04, 05 | NOT_STARTED |
| 17 | Secure Sharing, Backup, Recovery | `phases/PHASE_17_SHARING_BACKUP_RECOVERY.md` | 03, 04, all data modules | NOT_STARTED |
| 18 | Performance, API Efficiency, UI States | `phases/PHASE_18_PERFORMANCE_UI_STATES.md` | all feature phases | NOT_STARTED |
| 19 | Browser Integrations, Autofill, Biometrics, PWA hardening | `phases/PHASE_19_BROWSER_INTEGRATIONS.md` | 03, 06, 18 | NOT_STARTED |
| 20 | Comprehensive Testing and Independent Audits | `phases/PHASE_20_TESTING_AUDITS.md` | 00–19 | NOT_STARTED |
| 21 | Release and Documentation | `phases/PHASE_21_RELEASE_DOCS.md` | 20 | NOT_STARTED |

## Dependency graph

```
00 → 01 → 02 ─┬────────────→ 05 ─→ 06 ─┬→ 08 → 09 ─┐
              │                         ├→ 10 → 13 ─┼→ 14
         01 → 03 → 04 ─┬→ 05            │           │
                       ├→ 07 ───────────┴→ 11 → 12 ─┼→ 15
                       └→ 16                        │
                       all data modules → 17         │
        all feature phases → 18 → 19 → 20 → 21
```

## Parallelism opportunities (see `docs/MULTI_AGENT_COORDINATION.md`)

- After 01: Phase 02 (design system) and the **design/spec portion** of Phase 03 (threat model, crypto ADRs, benchmarks) can run in parallel.
- After 04: Phases 05 and 07 and 16 (storage-only parts) can run in parallel.
- After 06: Phases 08 and 10 can run in parallel; after 10: 13; after 11: 12.
- Phases 09, 12, 13 and 15 can overlap where their dependencies are met and file ownership is disjoint.
- Phases 17–21 are mostly sequential (integration-heavy).

Cross-cutting requirements that apply in **every** phase: responsive validation, accessibility, light/dark themes, UI states, synthetic-data testing, security logging rules, checkpoint updates.

## Specification coverage

Every requirement is mapped in `docs/REQUIREMENTS_TRACEABILITY.md`.
