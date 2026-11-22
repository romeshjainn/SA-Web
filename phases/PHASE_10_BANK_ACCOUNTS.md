# Phase 10 — Bank Accounts

**Covers:** S14, S23 (linked cards/documents), S24, A02
**Depends on:** 06 (04, 08 for card linking)
**Unlocks:** 13, 14

## Objective
Bank-account records with a smooth manual balance-update experience and honest provenance of balances.

## Requirements
- Fields: bank name, account name, account number, IFSC (format validation; no network lookups unless opt-in and documented), branch, account type, currency, current balance, notes, linked cards, linked documents, account history.
- **Manual balance updates**: fast inline/sheet update (one field, Enter to save), optional note, timestamp; keeps **balance history** (append-only entries) with a chart; undo of last update.
- **Provenance**: each balance flagged `manual` vs `synchronized`. Do not imply bank integrations exist; only `manual` is available unless a verified integration is implemented (none planned). Display "Updated manually on <date>" and staleness hint.
- **Do not fabricate transaction data.** No transactions module unless user-entered notes.
- Account number handling: masked by default, reveal/copy gated, never indexed in full (last-4 only), never logged.
- Currency support (ISO 4217, per-account), correct decimal handling; multi-currency totals deferred to Phase 14 with explicit conversion rules (manual rates).
- Relations: link debit cards (Phase 08) and documents (Phase 11, via relation contract) both ways; show linked items on detail.
- Saved email/phone suggestions where contact fields exist (A02).
- Search provider, quick action "Add bank account", favorites, archive/restore, dashboard widget data (balances).
- Minimal UI: account list with balance and staleness; details in sheet; swipe-friendly mobile layout.

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| A | Schema, encrypted data layer, history | `features/bank-accounts/data` | Builder |
| B | UI (list/detail/forms/balance update/chart) | `features/bank-accounts/ui` | UI builder |
| C | Validators (IFSC, account formats), money utils reuse | `core/finance/money` | Builder |
| D | Tests | `tests/`, `e2e/` | Test agent |
Runs in parallel with Phase 08 once Phase 06 is done.

## Acceptance criteria
- CRUD/archive/restore; balance update is ≤ 2 interactions; history chart + table accurate.
- Provenance labels present and truthful; no integration claims.
- Linked cards navigate both directions.

## Testing requirements
Unit (IFSC validation, money), integration (history append-only, relations), E2E (add account → update balance twice → history), responsive/a11y, canary scans.

## Independent review
Light review for data handling and honesty of UI copy.

## Checkpoint
Standard.
