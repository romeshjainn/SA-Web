# Phase 15 — Reminders, Calendar and Subscriptions

**Covers:** S20, S21, S13 (payment reminders), S15/S16 (expiry reminders), S19 (widgets), S24
**Depends on:** 09, 11, 12
**Unlocks:** 18

## Objective
A unified reminder system with calendar and a subscription/recurring-expense module.

## Requirements

### Reminders
- Unified reminder service consuming **reminder sources** registered by modules: document expiry, insurance renewal, PUC renewal, credit-card statement/payment due, subscriptions, vehicle maintenance, investment-related (e.g. FD maturity), and **custom reminders**.
- Features: reminder dates, **recurrence** (RRULE-style subset: daily/weekly/monthly/yearly, custom intervals, end conditions, month-end handling), **notification preferences** (lead times, quiet hours, per-source), **calendar view** (month/agenda; mobile-friendly agenda default), **upcoming** list, **completed** reminders, **snooze**, **rescheduling**, **reminder history**.
- Notifications: Notification API / Push where supported and permitted; **never assume availability** (graceful in-app banners/badges when unavailable or denied). Local scheduling via service worker where supported (e.g. Notification Triggers/periodic sync are not universal — design fallbacks: check-on-open, in-app inbox). No third-party push services unless justified by ADR; privacy-preserving (notification text avoids sensitive details by default, e.g. "Document expiring" without number).
- Generated reminders are derived from source records (single source of truth); editing the source updates the reminder; dismissing is separate from deleting.
- Search provider and quick action ("Add reminder").

### Subscriptions & recurring expenses
- Fields: service name, amount, currency, billing frequency (weekly/monthly/quarterly/yearly/custom), billing date, renewal date, payment method (relation to card/bank), category, status (active/paused/cancelled/trial), notes, reminder, history (price changes, renewals), **monthly and annual summaries** (normalised costs), upcoming payments view, recurring expenses (non-subscription) support.
- Accurate normalisation of costs across frequencies and currencies (explicit rates), next-renewal computation with month-end/leap-year handling.
- Dashboard widgets: upcoming reminders, subscriptions summary (register with Phase 14 framework).
- Quick action "Add subscription"; favorites; archive/restore.
- Minimal UI: upcoming-first lists; calendar only on demand.

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| 0 | Reminder-source + recurrence contracts | `core/reminders/types` | Lead |
| A | Reminder engine + recurrence + scheduler | `core/reminders` | Builder (date-logic precision) |
| B | Notification layer + fallbacks + SW integration | `core/notifications`, `pwa/` | Builder |
| C | Reminders/calendar UI | `features/reminders/ui` | UI builder |
| D | Subscriptions data + calc + UI | `features/subscriptions` | Builder + UI builder |
| E | Tests | `tests/`, `e2e/` | Test agent |

## Acceptance criteria
- Reminders from documents, vehicles, credit cards, subscriptions and custom entries appear in one list/calendar with correct dates and recurrence.
- Snooze/reschedule/complete/history work; denied notification permission degrades gracefully.
- Subscription summaries are numerically correct; upcoming payments clear.

## Testing requirements
Unit (recurrence incl. month-end, DST/time-zone, leap years; cost normalisation), integration (source registration → reminder generation), E2E (permission granted/denied, snooze, complete, calendar navigation), responsive/a11y (calendar grid keyboard nav, announcements), time-travel tests using a controllable clock.

## Independent review
Reviewer inspects date/recurrence logic and notification privacy → `docs/reviews/PHASE_15_reminders.md`.

## Checkpoint
Standard.
