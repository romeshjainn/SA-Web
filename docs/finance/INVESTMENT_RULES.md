# Investment Rules

Seeded by the kit; finalised in Phase 13 and enforced by tests in `core/finance/investments`. Related: `docs/finance/NET_WORTH_RULES.md`.

## Principles

1. **No fabricated live prices.** Valuation is **manual** by default, labelled `manual valuation (as of <date>)`. Verified market data (if ever implemented, opt-in) is labelled `verified market data (<source>, <timestamp>)` and shown separately.
2. **Invested amount and valuation are different numbers** and are never mixed or summed.
3. Decimal arithmetic only. Units/quantities keep their own precision (e.g. mutual-fund units to 3–4 decimals, gold in grams).
4. All transactions are user-entered; nothing is imported or inferred.

## Cost basis method

Default **average cost**. (FIFO may be offered as an option per investment; the method is shown on screen and stored with the record.)

- Buy: units += n; cost basis += n × price + fees.
- Sell: average cost per unit = cost basis ÷ units before the sale; realised P/L = n × (sell price − average cost) − fees; units −= n; cost basis −= n × average cost.
- **Invested amount** = remaining cost basis. (Total ever bought is shown separately as "gross bought".)
- **Unrealised P/L** = current valuation − remaining cost basis. **Total P/L** = realised + unrealised. Percentage return = P/L ÷ cost basis (undefined when cost basis is 0 — shown as "—").
- Dividends/interest are income transactions: they add to realised income, not to cost basis.

## Worked example (average cost)

- Buy 10 units @ 100 → units 10, cost basis 1,000.
- Buy 10 units @ 120 → units 20, cost basis 2,200, average 110.
- Sell 5 units @ 130 → realised P/L = 5 × (130 − 110) = **100**; units 15, cost basis 1,650.
- Manual valuation 125 per unit → valuation 15 × 125 = 1,875; unrealised P/L = 1,875 − 1,650 = **225**; total P/L = **325**.

## Asset-type notes

| Type | Notes |
|---|---|
| Stocks / ETFs | units × manual price; broker link optional |
| Mutual funds | units × manual NAV; SIP schedule optional (reminder source) |
| Bonds | face value, coupon, maturity; accrued interest only if the user enters it |
| Fixed deposits | principal, rate, compounding, start, maturity; maturity value computed from stated assumptions (below) |
| Gold | weight × manual rate per gram; purity optional |
| Other / custom | user-defined fields and a calculation mode (value-only, units×price) |

## Fixed-deposit maturity (stated assumptions)

Compound: A = P × (1 + r/n)^(n×t). Example: P = 100,000, r = 7% p.a., n = 4 (quarterly), t = 1 year ⇒ A ≈ **107,186** (1.0175⁴ ≈ 1.07186); the test must compute with decimals and assert to the currency's minor unit. Simple interest: A = P × (1 + r × t). Premature closure, TDS and bank-specific day-count rules are **not** modelled unless the user enters them; the UI states the assumptions.

## Net-worth interface

Each investment exposes `{ valuation, currency, provenance, asOf, includeInNetWorth }` to the engine. Excluded items stay visible on the investments screen.

## Required test cases

Average-cost worked example; selling all units; selling more than held (rejected); fees; dividend income; FD simple and compound; gold by weight; zero cost basis percentage; include/exclude toggle; provenance label present for manual valuation.
