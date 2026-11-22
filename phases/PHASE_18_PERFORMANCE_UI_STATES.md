# Phase 18 — Performance, API Efficiency and UI States

**Covers:** S31, S32, S05 (offline behaviour polish), S29/S30 (regression)
**Depends on:** all feature phases (05–17)
**Unlocks:** 19, 20

## Objective
Optimise the whole application and make every UI operation reliable and explicit about its state. **Do not sacrifice security for performance.**

## Requirements

### Performance (S31)
- **Bundle size**: budgets per route, analysis with the Next.js analyzer, remove/replace heavy dependencies; **lazy loading and code splitting** (scanners/OCR/PDF/charts loaded on demand; WASM assets cached by the service worker).
- **Rendering**: eliminate unnecessary rerenders (profiling), list virtualisation for large vaults, memoisation where measured, avoid layout thrash, image optimisation (client-side thumbnails, responsive images), skeletons to improve perceived speed.
- **Data fetching**: request deduplication, batching, version/ETag conditional requests, pagination/delta sync, caching and sync strategy review, no repeated fetching of the same data, no unnecessary API calls (measure requests per screen).
- **Search**: index build time and query latency measured on synthetic 5k and 25k-item vaults.
- **Crypto**: KDF/unlock time revalidated in-browser; workers for heavy crypto/OCR/PDF to keep the main thread responsive; memory usage profiling (large documents).
- **Document processing**: streaming/chunked encryption, memory ceilings, cancellation.
- **Offline behaviour**: cold-start offline, cache sizes, eviction policy.
- Record all results in `docs/PERFORMANCE_REPORT.md` labelled **measured on <hardware>** vs **simulated (CPU throttle/network throttle)**; no invented numbers; Lighthouse where available.

### UI reliability (S32)
Audit every major operation for explicit handling of: loading, empty, error, success, saving, saved, offline, pending sync, sync failure, partial failure, conflict, validation error, unauthorized, expired session. **No silent failures**; clear, actionable messages; retry affordances; error boundaries per route/module; global session-expiry handling (re-unlock without losing in-progress form data, encrypted draft preservation).
- Create `docs/UI_STATE_MATRIX.md` (module × state, with test references).

### Regression
Re-run responsive and accessibility suites at all five viewports in both themes; fix regressions.

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| A | Bundle/lazy-load/code-splitting | build config, route modules | Builder |
| B | Render/virtualisation profiling fixes | feature UIs (coordinate per module) | UI builders (one per module, disjoint) |
| C | Data fetching/dedup/batching/sync efficiency | `core/data`, `core/sync` | Lead/Builder |
| D | Workers + memory for crypto/OCR/PDF | `core/workers` | Builder |
| E | UI-state audit + fixes + matrix | `docs/UI_STATE_MATRIX.md`, features | UI builders |
| F | Perf/e2e/a11y regression tests | `tests/perf`, `e2e/` | Test agent |

## Acceptance criteria
- Budgets met or exceptions justified in ADR; measurable improvements documented with before/after.
- No duplicate requests for the same data in a screen load; search latency within documented targets.
- UI state matrix complete; E2E covers offline/pending/failure/conflict/expired-session across modules.

## Testing requirements
Performance tests (bundle budget check in CI, request counting, search latency, memory snapshots, Lighthouse), E2E state tests (network failure injection, session expiry, conflicts), responsive/a11y regression.

## Independent review
Reviewer verifies that no optimisation weakened security (e.g. no plaintext caches) → `docs/reviews/PHASE_18_perf.md`.

## Checkpoint
Standard.
