# Phase 05 — Global Search, Favorites, Recent Items and Quick Actions

**Covers:** S07, S08, S06 (favorites foundation), S32
**Depends on:** 02, 04
**Unlocks:** 06 and every module (each registers a search provider and quick actions)

## Objective
Build the search and quick-action foundation as a registry-driven system so modules plug in without core changes.

## Requirements

### Global search
- Search across relevant vault data: credentials, groups, cards, bank accounts, documents, notes (incl. ideas), vehicles, investments, subscriptions, saved contacts, other supported modules — via **module-registered search providers**.
- **Designed around encryption**: search runs client-side on decrypted-in-memory fields after unlock, with an index that is encrypted at rest (Phase 04). Never send plaintext queries or searchable plaintext to the server. Never weaken security for convenience; sensitive fields (passwords, CVV, full card numbers, document numbers) are **not indexed** unless explicitly justified in an ADR (prefer masked/last-4 tokens). Document what is indexed.
- Fast search, debounced input, ranking (exact/prefix/fuzzy, recency, favorites boost), categories/filters (module, tags, favorites, archived), keyboard navigation (↑/↓/Enter/Esc, `Ctrl/Cmd+K`), match highlighting, recent searches (stored encrypted/locally, clearable, can be disabled), search-result shortcuts (open, copy, reveal where applicable), works offline over locally available data.
- Performance target: documented latency on a synthetic 5k-item vault (measured).

### Favorites and recents
- Shared favorites service (item-level; group-level hooks for Phase 06) and recent-items service (encrypted, bounded, clearable). Surface in search, command palette and later the dashboard.

### Quick actions
- Quick-action registry + UI: floating action on mobile, palette/section on desktop. Actions: Add password, Add card, Add bank account, Add document, Add note (and idea), Add investment, Add vehicle, Add subscription, Scan document, Scan card, Scan QR code. Actions whose modules do not exist yet are **registered by their module phase**; until then they are absent or clearly disabled (no fake placeholders in the shipped UI).
- Avoid unnecessary navigation (open creation form in sheet/dialog). Keep the UI minimal: show the few most-used, rest under "More".

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| 0 | Provider/action/favorite contracts | `core/search/types`, `core/actions/types` | Lead |
| A | Index + ranking + providers API | `core/search` | Builder |
| B | Search UI (palette, results, filters, highlighting) | `features/search` | UI builder |
| C | Favorites + recents services | `core/favorites`, `core/recents` | Builder |
| D | Quick-action registry + UI | `core/actions`, `features/quick-actions` | UI builder |
| E | Tests + perf benchmark | `tests/`, `e2e/` | Test agent |

## Acceptance criteria
- Two sample synthetic providers return ranked, highlighted results with keyboard navigation.
- No plaintext index at rest; no search terms leave the device (network inspection).
- Offline search works.
- Quick actions reachable in ≤ 2 taps on mobile.

## Testing requirements
Unit (ranking, tokenizer, highlight), integration (provider registration, encrypted index persistence), E2E (keyboard flows, offline search), perf (5k items, measured), responsive/a11y (palette/dialog focus trap, live-region result counts), canary scans.

## Independent review
Security reviewer checks index contents and storage; UI reviewer checks minimalism.

## Checkpoint
Standard.
