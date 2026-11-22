# Phase Gates

Covers spec §36. Gates ensure quality; they must not create artificial blockers.

## A phase is COMPLETE only when

1. **Implemented** — every requirement listed in the phase file is implemented as real, working functionality (or explicitly deferred with an ADR and a later phase assigned).
2. **Tested** — the phase's testing requirements were actually run; results recorded in `PHASE_LOG.md`. All new tests pass; no regressions in earlier suites.
3. **Reviewed** — the independent review required by the phase was done by a different agent; Critical/High findings fixed; Medium/Low logged.
4. **Responsive & accessible** (UI phases) — verified at 360 / 390 / 768 / 1024 / 1440 px, light and dark, keyboard-only, no horizontal overflow, touch targets ≥ 44px, axe checks clean.
5. **Documented** — module READMEs, ADRs, security notes, limitations updated.
6. **Checkpointed** — progress files updated, stable work committed.
7. **Traceable** — `docs/REQUIREMENTS_TRACEABILITY.md` rows for this phase marked with evidence (file/test references).

Statuses: `COMPLETE` or `COMPLETE_WITH_LIMITATIONS` (limitations documented and scheduled for revisit).

## Environmental-limitation policy

- Do not demand evidence that is impossible to obtain in the current environment when reasonable alternative evidence exists.
- Do not make physical device availability a prerequisite for web development. Do not launch Android emulators or install Android tooling.
- Do not block the whole project on an unavailable tool, device, or integration.
- Document the limitation, use alternative validation (e.g. Playwright device emulation and viewport tests, browser benchmarks, CPU throttling), continue, and revisit in Phase 20.
- Clearly distinguish **measured** from **simulated** results. Never invent mobile hardware benchmarks.

## What IS a genuine blocker

- A real security flaw whose fix requires a decision the agent cannot reasonably make (e.g. irreversible data-loss risk).
- Missing credentials/secrets the user must supply (Supabase project URL/keys) **and** no local alternative (use the Supabase local stack or a documented mock-free dev setup first; only block if impossible).
- Instructions that contradict each other in a way that cannot be reconciled by an ADR.

For a genuine blocker: record it in STATUS.md, complete everything not dependent on it, and clearly report what is needed.

## Security gate additions

Phases touching crypto, auth, storage, sharing, backup, recovery, RLS must also have: threat-model delta, reviewer report in `docs/reviews/`, no secrets/plaintext in logs (checked by test), residual risks documented.

## Gate checklist (copy into PHASE_LOG entry)

```
[ ] All phase requirements implemented
[ ] Tests written and run (commands + results recorded)
[ ] Independent review done (report path)
[ ] Responsive validation (5 viewports, light+dark) — UI phases
[ ] Accessibility checks — UI phases
[ ] UI states handled (loading/empty/error/offline/etc.)
[ ] No sensitive data in logs/URLs/storage (test or review evidence)
[ ] Docs/ADRs updated
[ ] Traceability updated
[ ] Progress files updated; checkpoint committed
[ ] Limitations/risks documented honestly
```
