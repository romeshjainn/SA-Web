# Phase 06 — Credential Management, Password Intelligence and Saved Contacts

**Covers:** S06, S07/S08 (provider + actions), S11 (QR → credential hooks), A01, A02, S24 (credential archive/restore/history)
**Depends on:** 04, 05
**Unlocks:** 08, 10, 19

## Objective
Fully functional password manager with service groups, generator, strength analysis and secure clipboard handling — plus the saved email/phone store and field suggestions reused across the app.

## Requirements

### Credentials
Create, edit, delete, archive, restore; favorites; search; filtering; categories; tags; notes; website URL; username; email; phone; password; custom fields; copy; reveal/hide; password strength analysis; password generator; password history where appropriate; creation and modification history; security-aware auto-hide; secure clipboard handling (auto-clear where the browser permits, never log; clear messaging when it cannot).

### Multiple accounts per service
Service **groups** containing multiple credential entries (e.g. several Instagram/Google accounts). Group-level organisation, favorites (where appropriate) and metadata; account-level favorites and metadata; independent edit/delete; move accounts between groups; no forced separate unrelated entries.

### Password generator (inside credential forms)
Adjustable length; uppercase, lowercase, numbers, symbols; exclude ambiguous characters; presets; strength feedback; regenerate; copy; **insert immediately into the selected field**. CSPRNG with unbiased selection (rejection sampling). Passphrase mode optional.

### Password intelligence
Offline strength estimation; reuse detection and weak-password flags computed locally; optional breach checks **only** via k-anonymity if the user opts in (default off; no telemetry); otherwise omitted. Keep insights minimal and uncluttered (a single "Health" view).

### Saved emails and mobile numbers (A01, A02)
- A **Contacts details store** (`saved-contact-details`): add/edit/delete/label (e.g. Personal, Work), mark default, optional verification note. Stored encrypted like any record; included in search and backup.
- **Suggestions**: shared `EmailField` / `PhoneField` components (from Phase 02 inputs) show saved values as suggestions (combobox, keyboard accessible, never auto-fill without user choice) in **every relevant email/phone field across modules** (credentials now; bank, vehicles, documents, subscriptions, notes later consume the same component). Suggestions are derived locally; nothing leaves the device. Provide validation/normalisation (E.164-friendly phone, India-aware defaults configurable).
- Option "Save for suggestions" when entering a new email/phone in a form.

### Module integration
Register search provider (no password indexing), quick action "Add password", relation types, reminder hooks (password age optional), dashboard widget data, archive/trash hooks.

### UX
Find → Reveal → Use: list → open → reveal (re-auth setting for sensitive) → copy/launch URL. Minimal list rows; details in a sheet/split view; mobile-first forms.

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| 0 | Credential + group + contact schemas/contracts | `features/credentials/types`, `features/contacts/types` | Lead |
| A | Credential CRUD/archive/history/data layer | `features/credentials/data` | Builder |
| B | Credential UI (list, detail, forms, groups) | `features/credentials/ui` | UI builder |
| C | Generator + strength + health | `features/credentials/password-tools` | Builder (security-aware) |
| D | Clipboard/auto-hide utilities | `core/security/clipboard`, `core/security/autohide` | Builder |
| E | Saved contacts store + suggestion components | `features/contacts`, `design-system/primitives/{email,phone}` | UI builder |
| F | Tests | `tests/`, `e2e/` | Test agent |

## Acceptance criteria
- Full CRUD + archive/restore + favorites + history for credentials and groups, offline and online.
- Generator output verified statistically sane; options all functional; inserts into field.
- Revealed secrets auto-hide; clipboard cleared after timeout where supported.
- Saving a contact detail makes it appear as a suggestion in credential email/phone fields; suggestions work by keyboard and touch.
- No plaintext secrets in storage/logs/network (canary scans).

## Testing requirements
Unit (generator, strength, reuse detection, phone/email normalisation), integration (encrypted round trips, groups), E2E (create → group → reveal → copy → archive → restore), responsive 360–1440, a11y (combobox semantics, reveal button labels), security (canaries, clipboard behaviour, auto-hide timers).

## Independent review
Reviewer checks generator randomness, clipboard/auto-hide handling and index exclusions → `docs/reviews/PHASE_06_credentials.md`.

## Checkpoint
Standard.
