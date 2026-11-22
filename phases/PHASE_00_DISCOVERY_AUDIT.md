# Phase 00 — Discovery and Repository Audit

**Covers:** S01, S35, S36, S37, S38, S39, S40, SFD (and confirms S02, S34)
**Depends on:** —
**Unlocks:** 01

## Objective
Understand what exists, reconcile this kit with it, and establish the execution baseline. Do not destroy existing work.

## Inputs to read first
`CLAUDE.md`, `AGENTS.md`, `docs/spec/MASTER_SPEC.md` (verbatim original), `ROADMAP.md`, `docs/REQUIREMENTS_TRACEABILITY.md`, `docs/GENERATED_ARTIFACTS.md`.

## Requirements
- Inspect repository: file tree, `package.json`, lockfiles, configs, existing code, tests, CI, `.env*` (never print secrets), Git history, branches, worktrees, stashes.
- Inspect the project kit (this repo's docs/phases) and reconcile it with any existing code. If code already exists, mark phases/streams already satisfied **only with evidence**.
- Check the environment: Node/npm versions, available browsers for Playwright, network access for installs, Supabase CLI/Docker availability, git remote. Record limitations (e.g. no network → document and use available tools). **Do not install Android/iOS tooling.**
- Confirm ADR-0001 (**owner directive: Next.js exclusively; no Vite/Vitest; no separate backend server**). If an existing codebase is not Next.js, write a migration ADR that adapts rather than destroys existing work; the owner directive still applies.
- Read `docs/ARCHITECTURE.md` and `docs/DEPENDENCIES.md`; record installed vs required tool versions (Node ≥ 20 LTS).
- Verify the kit's `.gitignore` and extend it as needed (env files, build output, secrets, local DBs), initialise Git if absent, create branch `phase/00-discovery`.
- Verify Codex-native `AGENTS.md` and `CLAUDE.md` are present and consistent (SFD).
- Create `docs/AUDIT_PHASE_00.md`: repo state, environment capabilities, risks, assumptions, which roadmap items are already done, initial execution plan.
- **Skills bootstrap (`SKILLS.md` §2):** install/verify the approved skills, pin versions, and add a "Skills status" table (installed vs fallback-only) to `docs/AUDIT_PHASE_00.md`. An unavailable skill is a limitation, not a blocker.
- Confirm progress files exist and the checkpoint workflow works (make the first real checkpoint commit).
- Confirm every spec section maps to a phase (traceability); run `bash scripts/validate-kit.sh`.

## Work streams
| Stream | Goal | Owned paths | Agent |
|---|---|---|---|
| A | Repo + Git + environment audit | `docs/AUDIT_PHASE_00.md` | Explore/Builder |
| B | Kit/spec reconciliation, ADR-0001 | `docs/decisions/` | Lead |
| C | Skills bootstrap and status table | `docs/AUDIT_PHASE_00.md` | Builder |
Sequential is fine; this phase is small.

## Acceptance criteria
- Audit document exists with environment capabilities and limitations stated honestly.
- Git initialised, `.gitignore` in place, first checkpoint committed.
- Existing work (if any) preserved and mapped to roadmap phases with evidence.
- ADR-0001 accepted. Phase 01 inputs ready.

## Testing requirements
- `bash scripts/validate-kit.sh` passes.
- Record versions of Node, npm, Playwright browsers available (measured, not assumed).

## Independent review
Not required; lead sanity-check of audit against the repository.

## Checkpoint
Update progress files; commit `chore(checkpoint): phase 00`.
