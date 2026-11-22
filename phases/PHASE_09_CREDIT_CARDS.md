# Phase 09 — Credit Cards and Liabilities

**Covers:** S13, S18 (liability inputs), S20 (payment reminders hooks), S24
**Depends on:** 08
**Unlocks:** 14, 15

## Objective
Credit-card management with accurate financial calculations and liability semantics suitable for net-worth use.

## Requirements
- Card information (reuse Phase 08 base type and renderer), plus: **credit limit, available limit, outstanding amount, utilisation, billing cycle, statement date, payment due date, payments, payment history, outstanding balance, reminder integration, charts, usage history.**
- Calculations (pure, unit-tested module `finance/credit`): utilisation = outstanding ÷ limit; available = limit − outstanding (clamped with explicit handling of over-limit/negative); next statement/due date computation across month lengths and cycle changes; minimum-due optional field (user-entered, not invented). Define and document rounding, currency handling (minor units/decimal library, never floats for money).
- **Credit limits are not assets.** Outstanding credit-card debt is a **liability** exposed to the net-worth engine through a typed liability contract; no double counting (rules seeded in `docs/finance/NET_WORTH_RULES.md`; extend them here with credit-card specifics and finalise in Phase 14).
- Payments: record payments (amount, date, source account link optional), update outstanding via transparent ledger entries (charges/adjustments entered manually; **do not fabricate transactions**), full history, edit/undo with audit trail.
- Usage history: manual outstanding snapshots over time → charts (utilisation trend, outstanding trend) with accessible data-table fallback; responsive charts.
- Reminder integration: register reminder sources for statement and due dates (consumed by Phase 15; contract-tested now).
- Search provider (bank, last 4), quick action (shared "Add card" with type choice), favorites, archive.
- Clear manual-data labelling: nothing implies bank sync.

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| A | Finance calc module + tests | `core/finance/credit` | Builder (precision-focused) |
| B | Data layer/ledger | `features/credit-cards/data` | Builder |
| C | UI (list, detail, payments, charts) | `features/credit-cards/ui` | UI builder |
| D | Tests | `tests/`, `e2e/` | Test agent |

## Acceptance criteria
- Calculations match worked examples (edge cases: zero limit, over limit, payments exceeding outstanding, cycle across Feb/leap year).
- Liability contract produces correct values; limits never appear as assets.
- Payment history and charts accurate and accessible.

## Testing requirements
Property/unit tests for money maths and dates; integration for ledger; E2E for add card → payment → history; responsive charts at 360–1440; a11y of charts (table alternative, labels).

## Independent review
Finance-logic reviewer recomputes sample scenarios independently → `docs/reviews/PHASE_09_credit.md`.

## Checkpoint
Standard.
