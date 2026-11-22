# Personal Vault — Autonomous Development Kit

This repository is an **execution kit** for building Personal Vault (a premium, secure, offline-capable personal web app / PWA) autonomously with Claude Code or Codex. The application code is built by the agents following this kit; the kit itself contains no application code.

## How to use

1. Open this repository in Claude Code (or Codex).
2. Tell it: "Follow CLAUDE.md." (`CLAUDE.md` / `AGENTS.md` are auto-loaded.)
3. The agent reads the roadmap, executes phases 00 → 21, checkpoints progress, and resumes safely after interruptions.

To resume after a usage limit or crash, just start a new session and say the same thing; or run `/resume` (see `.claude/commands/`).

## Layout

```
CLAUDE.md                     Entry point for Claude Code
AGENTS.md                     Shared rules for all agents (Codex-native)
SKILLS.md                     Approved skills, agent roster, per-phase skill matrix (mandatory)
ROADMAP.md                    Master roadmap, dependency graph, phase status
PROGRESS.md                   Human-readable progress log (update every checkpoint)
REMOTE_PROGRESS/              Machine/recovery-oriented status
  STATUS.md                   Current state snapshot
  PHASE_LOG.md                Append-only phase/checkpoint log
phases/                       One instruction file per phase (00–21) + template
docs/                         Rules, strategy and reference docs
  decisions/                  ADRs (architecture decision records)
  spec/MASTER_SPEC.md         Verbatim original specification (source of truth)
  REQUIREMENTS_TRACEABILITY.md  Every requirement → phase mapping
  ARCHITECTURE.md             Unified Next.js architecture baseline
  GENERATED_ARTIFACTS.md      Files the build creates, and which phase creates each
  design/BRIEF.md             Design brief (seeded; finalised in Phase 02)
  finance/                    Net-worth and investment rules (seeded)
  reviews/                    Independent review reports (template inside)
  DEPENDENCIES.md             Approved/forbidden dependencies
scripts/validate-kit.sh       Verifies kit completeness and requirement coverage
.claude/commands/             Slash commands: resume, checkpoint, phase-gate
```

## Validate the kit

```bash
bash scripts/validate-kit.sh
```
