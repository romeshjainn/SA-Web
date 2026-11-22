# REMOTE_PROGRESS / PHASE_LOG

Append-only. One entry per checkpoint. Never rewrite earlier entries (add a correction entry instead).

## Entry template

```
### [YYYY-MM-DD HH:MM] Phase NN — <stream or milestone>
- Status: IN_PROGRESS | COMPLETE | COMPLETE_WITH_LIMITATIONS | BLOCKED
- Commit: <hash or "uncommitted">
- Completed: ...
- Remaining: ...
- Decisions (ADR links): ...
- Files changed (key): ...
- Tests run: <exact commands> → <results>
- Known defects: ...
- Security concerns: ...
- Limitations: ...
- Blockers: ...
- Next steps (exact): ...
```

## Log

### [kit created] Execution kit initialised
- Status: NOT_STARTED
- Commit: n/a
- Completed: Kit files created (CLAUDE.md, AGENTS.md, ROADMAP.md, phases/, docs/, scripts/).
- Remaining: All phases 00–21.
- Tests run: `bash scripts/validate-kit.sh` (kit validation only; no application tests exist yet).
- Next steps: Begin Phase 00.

### [2026-11-22] Kit update — Next.js exclusively
- Status: NOT_STARTED (kit only; no application code)
- Decisions: ADR-0001 rewritten and Accepted by owner directive: unified Next.js + TypeScript; Route Handlers/Server Actions as backend; no Vite/Vitest; no separate backend server; Jest (`next/jest`) + React Testing Library + Playwright for tests.
- Files changed: ADR-0001, AGENTS.md, CLAUDE.md, ROADMAP.md, README.md, docs/{ARCHITECTURE,DEPENDENCIES,TESTING_STRATEGY,OWNERSHIP}.md, phases 00/01/03/04/07/21, scripts/validate-kit.sh.
- Tests run: `bash scripts/validate-kit.sh` → passed (kit validation only).
- Next steps: Execute Phase 00.

### [2026-11-22] Kit update — continuous execution, seeded docs, path registry
- Status: NOT_STARTED (kit only)
- Completed: Added "Execution mode: continuous, no approval gates" to CLAUDE.md and AGENTS.md rule 24. Seeded docs/design/BRIEF.md, docs/finance/NET_WORTH_RULES.md, docs/finance/INVESTMENT_RULES.md, docs/reviews/README.md (template), .gitignore. Added docs/GENERATED_ARTIFACTS.md registering every build-created path with its phase; validate-kit.sh now fails on any referenced docs/ path that neither exists nor is registered.
- Tests run: `bash scripts/validate-kit.sh` → passed; negative test (registry entry removed) → failed as expected, then restored.
- Next steps: Execute Phase 00.
