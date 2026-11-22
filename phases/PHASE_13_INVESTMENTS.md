# Phase 13 — Investments

**Covers:** S17, S18 (valuation inputs), S23 (investment ↔ broker), S24, S20 (investment reminders hooks)
**Depends on:** 10 (broker/account links)
**Unlocks:** 14

## Objective
Investment records with transparent calculations and honest valuation provenance.

## Requirements
- Types: **Stocks, Mutual funds, ETFs, Bonds, Fixed deposits, Gold, Other assets, Custom investment types** (user-defined fields and calculation mode).
- Fields: investment name, asset type, units, quantity, purchase date, purchase price, cost basis, invested amount, current valuation, profit/loss, broker, notes, **transaction history** (buy/sell/dividend/interest/fee/adjustment, user-entered), include/exclude from net worth.
- **Calculations** (pure, tested, documented in `docs/finance/INVESTMENT_RULES.md`): cost basis (document method: average cost; optionally FIFO), invested amount vs current valuation kept **distinct** (never mixed), realised vs unrealised P/L, absolute and percentage returns, XIRR optional, FD maturity value (simple/compound with stated assumptions), gold by weight × manual rate. Decimal arithmetic; no floats for money.
- **No fabricated live prices.** Valuation is **manual** by default and labelled `manual valuation (as of <date>)`. If market data integration is ever added it must be opt-in, clearly labelled `verified market data (source, timestamp)`, and shown separately — not implemented unless verified. Phase default: manual only.
- Relations: broker (link to bank account/credential/document), reminders (FD maturity, SIP dates, optional).
- Include/exclude toggle feeds the net-worth engine through a typed asset contract.
- Search provider, quick action "Add investment", favorites, archive/restore, dashboard widget data (allocation by type).
- Minimal UI: list grouped by type with value and P/L; detail with transaction history and valuation history chart (accessible table fallback).

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| A | Finance calc module + tests | `core/finance/investments` | Builder (precision) |
| B | Data layer + transactions + valuation history | `features/investments/data` | Builder |
| C | UI (list/detail/forms/charts) | `features/investments/ui` | UI builder |
| D | Tests | `tests/`, `e2e/` | Test agent |

## Acceptance criteria
- Worked examples for each type match hand-computed values; invested ≠ valuation distinctions visible.
- Manual valuation labelled everywhere; no live-price claims.
- Include/exclude toggles flow to the asset contract.

## Testing requirements
Property/unit tests (cost basis, P/L across buys/sells, FD maturity, rounding), integration (transaction ledger), E2E (add stock → buy more → update valuation), responsive/a11y charts.

## Independent review
Finance-logic reviewer recomputes scenarios → `docs/reviews/PHASE_13_investments.md`.

## Checkpoint
Standard.
