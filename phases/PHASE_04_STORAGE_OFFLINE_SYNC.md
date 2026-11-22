# Phase 04 — Encrypted Storage, Cache, Offline and Synchronization

**Covers:** S05, S04 (storage), S31 (caching foundation), S32 (offline states), A03 (offline service worker)
**Depends on:** 03
**Unlocks:** 05, 06, 07, 11, 16

## Objective
Provide the encrypted data layer every module builds on: encrypted records in Supabase, an encrypted local store, an offline mutation queue, sync with conflict handling, and integrity checks.

## Requirements
- **Generic encrypted record store**: records are encrypted client-side (envelope from Phase 03, AAD binds id/type/version) before leaving the client; server holds ciphertext + minimal necessary plaintext metadata (id, type, owner, timestamps, version, tombstone flag). Document exactly what metadata is plaintext and why.
- **Encrypted local persistence** (IndexedDB) encrypted with a key derived from the vault key hierarchy; no plaintext secrets in localStorage/sessionStorage/IndexedDB; decrypted data kept in memory only as long as needed.
- **Encrypted cache** with explicit lifecycle: populate, invalidate, expire, wipe on logout/lock policy (configurable; document tradeoff of offline vs wipe).
- **Offline read access** to cached encrypted data when unlocked (and per configuration).
- **Offline-safe writes** via a durable mutation queue (create/update/delete/archive/restore), idempotent with client-generated ids, ordered, retried with backoff.
- **Synchronization**: pull/push with per-record versions/vector or revision numbers, tombstones, partial sync, resumable. Conflict handling: detect, preserve both versions, surface a conflict UI; **never silently lose data**.
- **Sync status model**: Online, Offline, Pending synchronization, Synchronization failure, Conflict, Partial synchronization — exposed via core state and a Phase 02 status component.
- **Data integrity checks**: authenticated encryption, per-record integrity, periodic verification, detection of corrupt local records with recovery path.
- **Encrypted file/blob storage** (Supabase Storage): client-side chunked/whole-file encryption, unique key/nonce per file, encrypted filenames/metadata, size limits, upload resume where practical; foundation for documents (Phase 11) and scans (Phase 07).
- **Encrypted search index foundation**: local, in-memory/encrypted-at-rest index built after unlock from decrypted fields; server never sees plaintext search terms. (Phase 05 builds the UI.)
- **Service worker offline** (inside the Next.js project; hand-written `public/sw.js` or a Next.js-integrated library chosen by ADR — no separate build toolchain) for the app shell and static assets (precache, versioned, update flow with user prompt). No caching of sensitive API responses in plaintext.
- Request deduplication, batching, and ETag/version-based fetches to avoid redundant calls.
- Module registration hooks so each feature provides its schema, serializer, validators and migration steps.

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| 0 | Record/envelope/sync contracts | `core/data/types` | Lead (strong) |
| A | Server schema, RLS, **Next.js Route Handlers** for records | `supabase/`, `app/api/records` | Builder |
| B | Local encrypted store + cache lifecycle | `core/storage` | Builder (strong) |
| C | Mutation queue + sync engine + conflicts | `core/sync` | Lead/Builder (strong) |
| D | Encrypted blob storage | `core/storage/blobs` | Builder |
| E | Service worker + offline shell | `pwa/` | Builder |
| F | Sync status UI + conflict UI | `shared/ui/sync` | UI builder |
| G | Integrity/offline/crash tests | `tests/`, `e2e/` | Test agent |

## Acceptance criteria
- Create/edit/delete a synthetic record offline → reconnect → synchronised without loss.
- Concurrent edits from two sessions produce a conflict that preserves both versions.
- Inspecting DB rows, Storage objects, IndexedDB and logs shows no plaintext canary.
- Logout wipes local decrypted data and keys per policy.
- Crash-during-write simulation leaves the store consistent.
- All six sync states visible and accurate in the UI.

## Testing requirements
Unit (queue ordering, retry/backoff, conflict resolver), integration (sync round trips, RLS on records/blobs), data-integrity (tamper, corruption, crash), E2E offline/online via Playwright `context.setOffline`, plaintext canary scans, responsive/a11y for sync UI.

## Independent review (mandatory)
Different agent reviews local storage encryption, cache lifecycle, sync/conflict logic and blob encryption → `docs/reviews/PHASE_04_storage_sync.md`.

## Checkpoint
Standard.
