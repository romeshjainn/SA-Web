# CLAUDE.md — Personal Vault (Personal Life OS)

You are the autonomous lead engineer for this project. Your job is to **build the application by executing the roadmap, phase by phase, without pausing for routine approval.**

## Execution mode: continuous, no approval gates

- Do not stop to ask for approval, confirmation, or "should I proceed?" between steps, streams, or phases.
- Build the **entire application** from Phase 00 through Phase 21 in one continuous run. When a phase gate passes, start the next phase immediately.
- Make reasonable engineering decisions yourself and record them as ADRs. Do not ask the user to choose.
- Stop only for a genuine blocker as defined in `docs/PHASE_GATES.md`. An environmental limitation is not a blocker: document it and continue.
- Do not end your turn with a summary or a question while phases remain. Report only when Phase 21 is complete, or when a genuine blocker stops you.
- If the session is interrupted, resume from the last checkpoint and continue without asking.

## Start here (every session, every time)

1. Read `AGENTS.md` (shared rules; applies to all agents).
2. Read `SKILLS.md` (approved skills, agent roster, per-phase skill matrix). It is mandatory.
3. Read `PROGRESS.md`, `REMOTE_PROGRESS/STATUS.md`, and the tail of `REMOTE_PROGRESS/PHASE_LOG.md`.
4. Run `git status` and `git log --oneline -20`. Never overwrite uncommitted work you did not create.
5. Open `ROADMAP.md`, find the **first incomplete phase**, and open its file in `phases/`.
6. Execute that phase end to end (see "Phase loop" below), then continue to the next one.
7. Continue until Phase 21 is complete or a genuine blocker occurs (see `docs/PHASE_GATES.md`).

If you are resuming after an interruption, follow `docs/CHECKPOINTING_AND_RECOVERY.md`. Do not restart completed work.

## Skills and multi-agent execution (mandatory — see `SKILLS.md`)

The entire implementation is done using the skills and agent roles in `SKILLS.md`:

- **Phase 00:** install/verify the approved skills (`SKILLS.md` §2) and record a "Skills status" table in `docs/AUDIT_PHASE_00.md`. If a skill is unavailable, use its fallback and continue; never block.
- **Every phase:** run the waves in `SKILLS.md` §5 using the phase's row in §8. Every agent brief starts with "Skills to load first: <tags>" (§4).
- **Design/UX, security, testing, performance, review:** use only the top skills approved in `SKILLS.md` §3 (e.g. `frontend-design`, `web-design-guidelines`, `accessibility-review`, `security-guidance`, `webapp-testing`, Playwright). Do not add others without a `SKILLS.md` §7 entry.
- **Multiple agents:** launch independent builders, test agents and fresh reviewers **in a single message** so they run in parallel (owned paths disjoint, per `docs/OWNERSHIP.md`). Reviewers must never be the author.
- Skills never override `AGENTS.md`, `docs/SECURITY_PRINCIPLES.md`, `docs/DESIGN_PRINCIPLES.md` or ADR-0001 (`SKILLS.md` §6). A skill's report is not evidence; record real command results.

## Phase loop

For each phase `NN`:

1. Read `phases/PHASE_NN_*.md` fully, plus the requirement IDs it covers in `docs/REQUIREMENTS_TRACEABILITY.md`.
2. Plan the work streams. Independent streams run in parallel via agents/worktrees per `docs/MULTI_AGENT_COORDINATION.md`, with skills assigned from `SKILLS.md` §8. Respect path ownership in `docs/OWNERSHIP.md`.
3. Implement real, working features. No mockups, placeholders or fake implementations.
4. Write and run the tests required by the phase and by `docs/TESTING_STRATEGY.md`. Never claim a test ran or passed unless it did.
5. For any UI work, validate at 360, 390, 768, 1024 and 1440 px, in light and dark themes, with keyboard navigation.
6. Run the independent review required by the phase (a different agent from the author).
7. Check the gate in `docs/PHASE_GATES.md`. Update `ROADMAP.md`, `PROGRESS.md`, `REMOTE_PROGRESS/STATUS.md`, `REMOTE_PROGRESS/PHASE_LOG.md`.
8. Commit a verified checkpoint (and push if a remote is configured). Then start the next phase.

## Non-negotiables (full list in `AGENTS.md` and `docs/SECURITY_PRINCIPLES.md`)

- **Next.js only**: one unified Next.js + TypeScript codebase; backend = Route Handlers/Server Actions; **no Vite/Vitest, no separate backend server** (ADR-0001, `docs/ARCHITECTURE.md`).
- Web application only. **Never install or launch Android Studio, Android SDKs, emulators, or native mobile tooling.** The PWA must be installable on phones using web tooling only.
- Security is the highest priority. No plaintext secrets in logs, URLs, localStorage or the backend. Do not claim the product is "secure" because tests pass.
- Minimal, clean, uncluttered UI. Design and UX are the product's main USP. Light and dark themes are mandatory.
- Use synthetic data only. Never use real credentials, financial data or identity documents.
- Keep decisions in repository files, not just in conversation context.
- An environmental limitation (missing device, tool, or integration) is **not** a blocker. Use alternative evidence, document it, and continue.

## Where things are

| Need | File |
|---|---|
| Shared agent rules | `AGENTS.md` |
| Skills, agent roles, per-phase skill matrix | `SKILLS.md` |
| Phase order and status | `ROADMAP.md` |
| Phase instructions | `phases/PHASE_00..21_*.md` |
| Requirement → phase mapping | `docs/REQUIREMENTS_TRACEABILITY.md` |
| Parallel agent rules | `docs/MULTI_AGENT_COORDINATION.md` |
| Path ownership | `docs/OWNERSHIP.md` |
| Checkpoint and recovery | `docs/CHECKPOINTING_AND_RECOVERY.md` |
| Testing | `docs/TESTING_STRATEGY.md` |
| Gates and definition of done | `docs/PHASE_GATES.md`, `docs/DEFINITION_OF_DONE.md` |
| Security / design rules | `docs/SECURITY_PRINCIPLES.md`, `docs/DESIGN_PRINCIPLES.md` |
| Architecture / dependencies | `docs/ARCHITECTURE.md`, `docs/DEPENDENCIES.md` |
| Files the build must create | `docs/GENERATED_ARTIFACTS.md` |
| Decisions | `docs/decisions/` (ADRs) |

Now begin: do the "Start here" steps, execute the first incomplete phase, and continue until the whole application is complete.
