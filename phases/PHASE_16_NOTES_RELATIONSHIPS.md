# Phase 16 — Notes (including Ideas), Relationships, Archive, Trash and Activity

**Covers:** S22, S23, S24, A07, A02, S07 (notes search)
**Depends on:** 04, 05 (feature modules from 08–13 for relationship UI polish; contracts exist from earlier phases)
**Unlocks:** 17

## Objective
Secure notes with an Ideas workspace, a flexible relationship system across all modules, and unified archive/trash/activity with retention policies.

## Requirements

### Secure notes (S22)
Notes with titles, body (plain/markdown-lite editor, sanitised rendering, no raw HTML), categories, tags, search, favorites, archive, custom fields where appropriate, relationships, secure editing (autosave encrypted drafts, conflict-safe), secure storage (note contents sensitive; never logged; excluded from analytics—there is none), lock-on-idle.

### Ideas (A07)
Within Notes, an **Ideas** space to capture and organise ideas: quick capture (one field, instant save — also a quick action), status (spark / exploring / in progress / parked / done), idea categories/collections, tags, priority/starred, optional linking to notes or records, sort/filter by status, convert an idea into a full note or a reminder, lightweight board/list toggle. Keep it minimal: capture is the hero, organisation is optional and unobtrusive.

### Relationships (S23)
- Core relation service (typed, directional, with inverse labels): documents ↔ bank accounts, documents ↔ vehicles, cards ↔ accounts, notes ↔ records, investments ↔ brokers, reminders ↔ records, subscriptions ↔ payment methods, ideas ↔ notes, plus any module via registry. Relations are encrypted records; integrity rules on delete (unlink / cascade-prompt / block), orphan detection, no cycles where invalid.
- UI: "Linked items" panel reusable in every module's detail view; "Link to…" picker using global search; keep complexity low.

### Archive, Trash and Activity (S24)
- Archive and restore for all modules (shared service + UI); **Trash** with recovery window, restore, **permanent deletion** with confirmation (typed/hold confirmation for irreversible actions), secure erase of local encrypted copies and blob deletion (including Storage objects).
- **Activity history**: who/what/when events (created, edited, archived, restored, deleted, revealed/copied sensitive fields as *events only*), **never storing decrypted data or secrets** in activity entries; stored encrypted; filter by module/date; export optional.
- **Retention policies**: configurable retention for trash (default 30 days) and activity (default 180 days), automated purge with logging of the purge action.

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| 0 | Relation, trash, activity contracts | `core/relations`, `core/lifecycle/types` | Lead |
| A | Relation service + integrity + tests | `core/relations` | Builder |
| B | Lifecycle (archive/trash/purge/retention) | `core/lifecycle` | Builder (data-integrity strong) |
| C | Activity log service + UI | `core/activity`, `features/activity` | Builder |
| D | Notes + editor + ideas UI | `features/notes` | UI builder |
| E | Linked-items panel + picker | `shared/ui/relations` | UI builder |
| F | Tests | `tests/`, `e2e/` | Test agent |

## Acceptance criteria
- Notes and Ideas work offline/online; ideas convertible; capture in ≤ 2 interactions.
- Relations work across all existing modules; deletion rules prevent silent orphaning.
- Trash/restore/permanent delete verified including blobs; retention purge works with a controllable clock.
- Activity log contains no secrets (canary scan).

## Testing requirements
Unit (relation rules, retention), integration (cross-module links, cascade rules, purge), E2E (capture idea → convert to note → link to account → archive → trash → restore → permanently delete), responsive/a11y (editor, board keyboard alternative), XSS tests for note rendering, canary scans.

## Independent review
Reviewer examines deletion/purge integrity, activity data minimisation, and sanitised rendering → `docs/reviews/PHASE_16_notes_lifecycle.md`.

## Checkpoint
Standard.
