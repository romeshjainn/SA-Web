# Phase 14 — Financial Dashboard and Net Worth

**Covers:** S18, S19, S13/S14/S17 (consumption), A04
**Depends on:** 09, 10, 13
**Unlocks:** 15 (summary widgets), 18

## Objective
A transparent, explainable net-worth engine and a clean, customisable home dashboard.

## Requirements

### Net-worth engine (`core/finance/networth`)
- Inputs via typed contracts: bank balances, **cash** (manual cash holdings), investments (valuation, include/exclude), other **assets** (manual: property, vehicles' value, etc.), **liabilities**: credit-card outstanding (Phase 09), **other debts** (loans, EMIs — manual entries), manual adjustments.
- Rules documented in `docs/finance/NET_WORTH_RULES.md` and enforced by tests: **no double-counting** (e.g. a card payment from a bank account; an investment linked to a bank account), **credit limits never assets**, correct liability sign handling, **invested amount never mixed with valuation**, explicit assumptions (currency, rates, as-of dates, manual vs synchronized provenance).
- **Explainability**: every figure drills down to line items with source, provenance (manual/verified), as-of date, inclusion status, and a "why is this included/excluded" note. A "How this is calculated" view.
- Configurable inclusion/exclusion per item and per category; manual adjustments with reason; multi-currency with user-supplied conversion rates (clearly labelled, never fetched silently).
- **Historical trends**: periodic snapshots (on change and/or daily when app opened), stored encrypted; trend chart with accessible table; snapshot integrity (immutable entries, corrections as new entries).

### Dashboard
- Configurable widgets: Net worth, Bank accounts, Investments, Credit cards, Upcoming reminders, Documents nearing expiry, Recent items, Favorites, Quick actions, Subscriptions, Vehicles, other module summaries — **provided through the module widget registry**; reminders/subscriptions widgets render once Phase 15 registers them.
- Customisation: show/hide, reorder (drag + keyboard alternative), size where sensible, saved per user (encrypted settings), sensible minimal defaults (few widgets), reset to default.
- Privacy: amounts maskable with a one-tap "hide balances" toggle (default configurable).
- Responsive: single column on mobile, 2–3 columns desktop; charts adapt; not overwhelming.
- All widget states: loading, empty, error, stale, offline.

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| 0 | Asset/liability/adjustment contracts | `core/finance/contracts` | Lead |
| A | Net-worth engine + rules doc + tests | `core/finance/networth` | Builder (precision) |
| B | Snapshots/history storage | `features/networth/data` | Builder |
| C | Net-worth UI (breakdown, explain, trends) | `features/networth/ui` | UI builder |
| D | Dashboard framework + widgets | `features/dashboard` | UI builder |
| E | Tests | `tests/`, `e2e/` | Test agent |

## Acceptance criteria
- Scenario suite (cards + banks + investments + debts + adjustments) matches hand calculations; no double counting; limits excluded.
- Every number explainable down to source items.
- Dashboard customisation persists and syncs; default view is clean and uncluttered.

## Testing requirements
Property + scenario tests for engine; snapshot tests; integration (module contracts → engine); E2E (customise dashboard, toggle inclusion, view explanation); responsive 360–1440; a11y (chart tables, drag alternatives); perf (dashboard load with seeded vault).

## Independent review
Finance reviewer independently recomputes scenarios → `docs/reviews/PHASE_14_networth.md`; UX reviewer checks minimalism.

## Checkpoint
Standard.
