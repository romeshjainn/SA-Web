# Phase 12 — Vehicles

**Covers:** S16, S23 (vehicle ↔ documents), S20 (renewal/maintenance reminders hooks), S24, A02
**Depends on:** 11
**Unlocks:** 15

## Objective
Vehicle records with insurance, PUC, registration, maintenance history and document relationships.

## Requirements
- Fields: vehicle name, type (car, motorcycle, scooter, truck, other), registration number, chassis number, engine number, manufacturer, model, purchase information (date, price, seller), insurance (provider, policy number, start/expiry, premium), PUC (certificate number, expiry), registration information (RC details, registration date, validity), expiry dates, notes.
- **Documents** linked through the relation contract (RC, insurance, PUC, invoices) — create/link from the vehicle screen; attachments encrypted via Phase 11.
- **Service history & maintenance records**: date, odometer, type, cost, workshop, notes, attachments; next-service date/odometer; simple cost summary.
- **Reminders**: insurance renewal, PUC renewal, registration validity, service due — registered as reminder sources (consumed by Phase 15; contract-tested).
- Registration/chassis/engine numbers: shown on demand (copy), indexed only as masked/partial tokens unless user opts in.
- Search provider, quick action "Add vehicle", favorites, archive/restore, dashboard widget data (expiries).
- Minimal UI: vehicle cards with status chips ("Insurance in 12 days"), detail tabs (Overview, Documents, Service), mobile-first.

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| A | Data layer + schemas + relations | `features/vehicles/data` | Builder |
| B | UI (list/detail/forms/service log) | `features/vehicles/ui` | UI builder |
| C | Reminder/dashboard hooks | `features/vehicles/integration` | Builder |
| D | Tests | `tests/`, `e2e/` | Test agent |
Parallel with Phase 13 (disjoint paths).

## Acceptance criteria
- CRUD, service log, document linking, expiry statuses all work; reminders registered with correct dates.
- Deleting/archiving a vehicle handles linked documents explicitly (unlink vs trash prompt), never silently orphaning data.

## Testing requirements
Unit (expiry status, next-service calcs), integration (relations, encrypted storage), E2E (add vehicle → link RC document → log service), responsive/a11y, canary scans.

## Independent review
Standard code review (different agent).

## Checkpoint
Standard.
