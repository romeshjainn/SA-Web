# Checkpointing and Interruption Recovery

Covers spec §39 (git and checkpoints) and §40 (interruption and usage-limit recovery).

Assume any session can end at any moment (usage limit, context limit, crash, tool failure). All critical state must live in repository files.

## When to checkpoint

- A work stream finishes or is integrated.
- A phase gate passes.
- Before a risky refactor or dependency change.
- After an important architectural/security decision (write an ADR).
- At least every significant block of work (roughly every 30–60 minutes of activity or ~every few completed tasks).

## Checkpoint procedure

1. `git status`; review the diff.
2. Run the tests relevant to the changes (exact commands recorded).
3. Fix or record failures. **Never commit known-broken work as "verified".** WIP commits are allowed only on `wip/` or agent branches and labelled `wip:`.
4. Update, in this order:
   - `PROGRESS.md`
   - `REMOTE_PROGRESS/STATUS.md` (overwrite snapshot)
   - `REMOTE_PROGRESS/PHASE_LOG.md` (append entry)
   - `ROADMAP.md` status (only if a gate passed)
5. Commit: `git add -A && git commit -m "chore(checkpoint): phase NN – <summary>"` for stable work; feature commits use conventional types.
6. Push if a remote is configured (`git push`); if the push fails, record it as a limitation and continue.

## Required content in each checkpoint (all of it)

Current phase · completed tasks · remaining tasks · important architectural decisions · files changed · tests run · test results · known defects · security concerns · limitations · active blockers · **exact next steps** (specific enough that a fresh session can act without asking).

## Resume procedure (fresh session)

1. Read `CLAUDE.md`, `AGENTS.md`.
2. Read `REMOTE_PROGRESS/STATUS.md`, `PROGRESS.md`, tail of `PHASE_LOG.md`.
3. Inspect Git: `git status`, `git log --oneline -20`, `git branch -a`, `git worktree list`, `git stash list`.
4. Inspect the current phase file and the implementation on disk.
5. Reconcile: if docs and Git disagree, **Git and the code win**; fix the docs.
6. Handle open worktrees: for each, inspect `git -C <path> status/log`; integrate if complete and verified, continue if partial, otherwise record and clean up. Never delete an unmerged worktree with unreviewed work.
7. Re-run the last recorded tests to establish the real baseline.
8. Resume from the last **verified** checkpoint. Do not repeat completed work. Do not blindly overwrite unfinished work: read the partial files first and continue from them.
9. Append a "resumed" entry to `PHASE_LOG.md`.

## Uncommitted/partial work found on resume

- Read it before touching it. Decide: finish, commit as `wip:` on a branch, or (only if clearly garbage and created by an agent) discard with a log entry. Never discard user-authored changes.

## Context-limit hygiene

- Keep decisions in ADRs, not chat.
- Keep `next_steps` in STATUS.md concrete.
- Prefer small, committed increments so a lost context loses little.

## Usage-limit behaviour

When approaching limits: finish the current atomic task, checkpoint immediately (full procedure), and ensure `next_steps` is accurate. Do not start large new tasks that cannot be checkpointed.

## Git safety

- Never `git reset --hard`, `git clean -fd`, force-push, or delete branches containing unmerged work without explicit confirmation and a log entry.
- Never commit secrets, `.env` files, real data, or large binaries. Maintain `.gitignore` from Phase 01.
- Inspect Git state before every modification session.
