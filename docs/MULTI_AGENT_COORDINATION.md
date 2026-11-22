# Multi-Agent Coordination Rules

Covers spec §37 (autonomous execution), §38 (model/resource strategy), §39 (git).

## Roles

| Role | Responsibility | Reasoning level |
|---|---|---|
| **Lead** (main session) | Reads phase, decomposes streams, assigns ownership, integrates, runs gates, updates progress files, commits checkpoints | High |
| **Builder** agent | Implements one stream inside its owned paths | Medium (High for crypto/security/data integrity) |
| **Test** agent | Writes/runs tests for a stream or phase | Medium |
| **Reviewer** agent | Independent review; must NOT be the author of the code reviewed | High for security/crypto, medium otherwise |
| **Docs** agent | Module READMEs, ADR drafts, user/ops docs | Low–medium |

Use the strongest reasoning for: architecture, cryptography, security, data integrity, recovery, difficult debugging, independent audits. Use bounded agents for routine implementation, docs, tests, UI, repetitive work. Do not spend maximum reasoning on trivial tasks. Do not redo completed work because the session/model changed.

## Decomposition rules

1. Each phase file lists **work streams**. A stream is parallelizable only if its owned paths are disjoint from every other concurrent stream.
2. Shared/core files (`core/**`, design-system tokens, DB schema/migrations, `package.json`, lockfile, config, routing registry) are **lead-owned**. Builders request changes via the lead or via a small "interface PR" merged first.
3. Define interfaces (TypeScript types/contracts) **before** parallel work starts. Commit them as a stream-0 "contracts" commit.
4. Never let two agents edit the same file. If unavoidable, serialize them.
5. Database migrations: one migration per stream, timestamp-prefixed, owned by the stream; the lead resolves ordering at integration.

## Worktrees

```bash
git worktree add ../pv-wt-<phase>-<stream> -b agent/<phase>-<stream> phase/<NN>-<name>
```

- One worktree per concurrent stream. Branch from the current phase branch.
- Agents work only inside their worktree and owned paths.
- Record each worktree in `REMOTE_PROGRESS/STATUS.md` (`open_worktrees`) at creation; remove it at merge (`git worktree remove`).
- Run `npm install`/lockfile changes only in the lead worktree; builders rebase afterwards.

## Agent brief (required content for every delegation)

```
Phase / stream:
Skills to load first (tags from SKILLS.md §4/§8):
Goal (one paragraph):
Owned paths (may edit):
Read-only paths:
Contracts/interfaces to honour:
Requirement IDs covered:
Acceptance criteria:
Tests to write/run (exact commands):
Security/design/responsive rules that apply:
Do NOT: edit outside owned paths, touch lockfile/schema/core, commit secrets, use real data
Deliverables: commits on branch agent/<phase>-<stream>, short report (what changed, tests run + results, risks)
```

## Integration protocol

1. Agent finishes; reports tests run **with actual results**.
2. Lead reviews the diff (not just the report). Reports are claims, not evidence.
3. Rebase/merge into `phase/<NN>-<name>`; resolve conflicts; run the full relevant test suite on the integrated branch.
4. Independent reviewer examines integrated security-sensitive code.
5. Remove worktree/branch. Log in `PHASE_LOG.md`.
6. Never claim agent work or verification that did not occur.

## Conflict and failure handling

- Merge conflict: the lead resolves; if semantic, re-brief the owning agent.
- Agent exceeds ownership: revert the out-of-scope changes, re-brief.
- Agent fails twice on the same task: lead takes over or splits the task smaller.
- Flaky test: quarantine only with an issue note in `PROGRESS.md`; fix before the phase gate.

## Review independence

- Security/crypto/auth/RLS/storage/sharing/recovery code needs a reviewer different from the author, with the explicit instruction to find flaws, not confirm.
- Reviewer output is stored in `docs/reviews/PHASE_NN_<topic>.md` (findings, severity, resolution).

## Merge order within a phase

contracts → core/shared → data/schema → features → UI → tests → docs.

## Parallel-safe stream examples

- Phase 02: tokens/themes, primitives, navigation shell, PWA manifest/icons (disjoint dirs).
- Phase 07: card-OCR, document-scanner, QR scanner (separate feature dirs; shared camera util is lead-owned and built first).
- Phases 08 and 10 concurrently after 06; 12 concurrently with 13.
