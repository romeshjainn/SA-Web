# REMOTE_PROGRESS / STATUS

Snapshot for fast recovery. Overwrite this file at every checkpoint (history lives in `PHASE_LOG.md`).

```yaml
current_phase: "01"
phase_status: NOT_STARTED
last_verified_checkpoint: "chore(checkpoint): phase 00"   # see git log
last_checkpoint_time: "2026-11-26"
branch: main
open_worktrees: []
active_agents: []
completed_phases: ["00"]
in_progress_streams: []
blocked: false
blockers: []
limitations:
  - "No Docker / no Supabase credentials: PGlite used for local Postgres (ADR-0002 in Phase 01)"
  - "Playwright: Chromium only"
  - "No physical devices: mobile = Playwright emulation (simulated)"
known_defects: []
security_concerns: []
last_tests_run:
  command: "bash scripts/validate-kit.sh"
  result: pass
  timestamp: "2026-11-26"
next_steps:
  - "git checkout -b phase/01-foundation main"
  - "Execute phases/PHASE_01_ARCHITECTURE_FOUNDATION.md"
```

## Resume instructions

1. `git status` / `git log --oneline -20` / `git worktree list`.
2. Compare this file with `PROGRESS.md` and the tail of `PHASE_LOG.md`.
3. If they disagree, trust Git and the code; reconcile the docs, then continue.
4. Follow `docs/CHECKPOINTING_AND_RECOVERY.md`.
