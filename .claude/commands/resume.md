---
description: Resume the autonomous build from the last verified checkpoint
---
Resume the Personal Vault build.

1. Read CLAUDE.md and AGENTS.md.
2. Follow "Resume procedure" in docs/CHECKPOINTING_AND_RECOVERY.md exactly (STATUS.md, PROGRESS.md, PHASE_LOG.md tail, git status/log/worktrees/stash).
3. Reconcile docs with Git (Git and code win). Re-run the last recorded tests for a real baseline.
4. Append a "resumed" entry to REMOTE_PROGRESS/PHASE_LOG.md.
5. Continue the first incomplete phase in ROADMAP.md autonomously. Do not repeat completed work or overwrite unfinished work without reading it first.
