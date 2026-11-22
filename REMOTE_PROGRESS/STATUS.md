# REMOTE_PROGRESS / STATUS

Snapshot for fast recovery. Overwrite this file at every checkpoint (history lives in `PHASE_LOG.md`).

```yaml
current_phase: "00"
phase_status: NOT_STARTED
last_verified_checkpoint: null        # git commit hash
last_checkpoint_time: null
branch: null
open_worktrees: []                    # list of {path, branch, stream, owner}
active_agents: []                     # list of {name, phase, stream, owned_paths}
completed_phases: []
in_progress_streams: []
blocked: false
blockers: []
limitations: []
known_defects: []
security_concerns: []
last_tests_run:
  command: null
  result: null                        # pass | fail | partial | not_run
  timestamp: null
next_steps:
  - "Execute Phase 00 per phases/PHASE_00_DISCOVERY_AUDIT.md"
```

## Resume instructions

1. `git status` / `git log --oneline -20` / `git worktree list`.
2. Compare this file with `PROGRESS.md` and the tail of `PHASE_LOG.md`.
3. If they disagree, trust Git and the code; reconcile the docs, then continue.
4. Follow `docs/CHECKPOINTING_AND_RECOVERY.md`.
