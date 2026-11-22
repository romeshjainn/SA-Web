# Net-Worth Rules

Seeded by the kit; extended in Phase 09 (credit-card liabilities) and finalised in Phase 14 (engine). Every rule below must be enforced by tests in `core/finance/networth`.

## Definitions

- **Asset:** something owned with a value: bank balances, cash, investment *valuations*, other manually valued assets.
- **Liability:** something owed: credit-card **outstanding**, loans/EMIs/other debts.
- **Net worth = Σ included assets − Σ included liabilities**, in one reporting currency.
- Every line item carries: source, amount, currency, **provenance** (`manual` | `verified`), as-of date, inclusion flag, explanation.

## Rules

1. **Credit limits are never assets.** Only *outstanding* credit-card debt is counted, as a liability. Available limit never appears in net worth.
2. **No double counting.** One real-world value is represented once. A payment recorded on a credit card and the same payment reducing a bank balance affect two different line items correctly (bank asset down, card liability down); the engine never subtracts a payment a second time.
3. **Invested amount ≠ valuation.** Net worth uses the current **valuation** (manual unless verified market data exists), never the invested amount. Invested amount and P/L are display-only on the investments screen.
4. **Linked records are not summed twice.** A bank-linked debit card contributes nothing to net worth. An investment linked to a broker account counts once as an investment.
5. **Inclusion is explicit.** Every item can be excluded; excluded items are listed with the reason, not silently dropped.
6. **Liabilities are positive amounts subtracted by the engine.** Entry forms never ask users for negative numbers.
7. **Manual adjustments** are separate, labelled line items with a reason and date. They are never merged into source items.
8. **Currency:** each item keeps its own currency. Conversion uses only user-supplied rates with a date; rates are shown in the explanation. No silent network rate fetching. Missing rate ⇒ item shown as "needs conversion" and excluded from the total until resolved (never guessed).
9. **Money maths** uses a decimal library or integer minor units. No floating-point money. Rounding mode and scale are fixed and documented (round half away from zero at the currency's minor unit, applied only at presentation or at explicit conversion).
10. **Stale data is flagged**, not hidden: each balance shows its as-of date; items older than a configurable threshold show a staleness hint.
11. **Snapshots are immutable.** Historical trend points are appended; corrections are new entries.
12. **Explainability:** any total drills down to line items; a "How this is calculated" view lists these rules and the user's current inclusion/currency settings.

## Worked example 1 (all values in one currency)

| Item | Type | Amount |
|---|---|---|
| Savings account (manual) | Asset | 100,000 |
| Cash | Asset | 5,000 |
| Investments (valuation; invested 200,000) | Asset | 250,000 |
| Vehicle (manual value) | Asset | 300,000 |
| Credit card outstanding (limit 200,000 ignored) | Liability | 30,000 |
| Loan outstanding | Liability | 120,000 |

Assets = 100,000 + 5,000 + 250,000 + 300,000 = **655,000**. Liabilities = 30,000 + 120,000 = **150,000**. Net worth = **505,000**.

## Worked example 2 (card payment from the bank)

User pays 10,000 of the card from the savings account and updates both records: bank 100,000 → 90,000; card outstanding 30,000 → 20,000. Assets = 645,000; liabilities = 140,000; net worth = **505,000** (unchanged). If the engine also subtracted the payment as a separate transaction, net worth would wrongly drop to 495,000 — this is the double-count the tests must prevent.

## Required test cases

Limit excluded; payment scenario above; exclusion toggles; manual adjustment; missing exchange rate; mixed currencies with supplied rates; stale-balance flag; rounding at currency minor units; snapshot immutability; example 1 totals.
