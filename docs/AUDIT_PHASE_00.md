# Phase 00 — Discovery and Repository Audit

Date: 2026-11-26 · Author: Lead (Claude Code, Opus 5.5) · Branch: `phase/00-discovery`

## 1. Repository state (measured)

| Item | Finding |
|---|---|
| Git | Initialised; remote `origin` = GitHub `romeshjainn/SA-Web`; branch `main` clean at `2694523`; no other branches, no worktrees, no stashes |
| Application code | **None.** No `package.json`, lockfile, `src/`, tests or CI. Repository contains only the execution kit (CLAUDE.md, AGENTS.md, SKILLS.md, ROADMAP.md, `phases/`, `docs/`, `scripts/validate-kit.sh`, `.claude/commands/`) |
| `.env*` | None present |
| Existing work mapped to roadmap | Nothing to map: no phase is already satisfied. All phases 00–21 start from zero |
| Kit consistency | `AGENTS.md` and `CLAUDE.md` both present and consistent on stack (ADR-0001), continuous execution and security rules (SFD) |
| Spec coverage | `bash scripts/validate-kit.sh` → `phase files found: 22/22`, `OK: kit validation passed` (every requirement ID appears in a phase file) |

## 2. Environment capabilities (measured on this machine)

| Capability | Result | Consequence |
|---|---|---|
| OS | Windows 11 Home 10.0.26200; shells: Git Bash + PowerShell 5.1 | Scripts must be cross-platform (npm scripts, Node) |
| Node / npm | `v24.11.1` / `11.6.2` | Meets Node ≥ 20; Web Crypto available as `globalThis.crypto` |
| Git | 2.52.0 | — |
| Python | 3.10.11 | Only used by the optional `webapp-testing` skill helper |
| Network / npm registry | Available (`npm view next version` → `16.4.6`) | Packages installed from the registry at install time |
| Playwright | `playwright@1.65.1` via npx; browsers cached: `chromium-1255`, `chromium_headless_shell-1255`, `ffmpeg-1013` | Chromium E2E available; Firefox/WebKit not cached (install on demand or record as limitation) |
| Installed browsers | Chrome and Edge present | Secondary manual check only |
| Docker | **Not installed** | **Supabase local stack cannot run** |
| Supabase CLI | Not installed globally; `npx supabase --version` → `3.4.0` | CLI usable for migration tooling, but `supabase start` needs Docker |
| Supabase project credentials | **None supplied** (no `.env`) | Hosted Supabase cannot be used for development or tests |
| Android/iOS tooling | Android SDK paths exist on the system `PATH` | **Not used, not invoked** (AGENTS.md rule 2) |
| Disk | 58 GB free on C: | Sufficient |
| Working tree location | Inside a OneDrive-synced folder | File-sync can slow `node_modules` I/O; worktrees would multiply this. See §5 |

## 3. Decisions taken in this phase

- **ADR-0001 confirmed** (unified Next.js, no Vite/Vitest, no separate backend). Spec §2 also allows "Supabase Auth or an appropriately designed authentication architecture".
- **Data backend without Docker/credentials** — this is an environmental limitation, not a blocker (`docs/PHASE_GATES.md`). Phase 01 records the resolution in ADR-0002: the server data layer is written against plain PostgreSQL (Supabase Postgres in production via `DATABASE_URL`), and local development/tests use **PGlite** (real Postgres compiled to WASM, in-process, mock-free) running the same SQL migrations and RLS policies.
- **Agent execution model:** git worktrees on a OneDrive path would each need their own `node_modules`. Parallel agents therefore work in the main tree on strictly disjoint owned paths (per `docs/OWNERSHIP.md`) and the Lead integrates and commits; worktrees are used only when two streams must touch overlapping files. Recorded in ADR-0002.

## 4. Skills status (SKILLS.md §2/§3)

Installed 2026-11-26. Plugins are enabled at project scope in `.claude/settings.json` (kept local via `.git/info/exclude`, not committed). Skills under `~/.claude/skills` are global. **Plugins installed mid-session only load in the next session**; in this session their §3 fallbacks are used where the skill is not listed as available.

| Tag | Skill | Status | Version / source | Notes (security check per §1.5) |
|---|---|---|---|---|
| DESIGN | `frontend-design` | Installed (plugin, loads next session) → **fallback in this session** | claude-plugins-official, plugin cache | SKILL.md only; no scripts/hooks |
| UXAUDIT | `web-design-guidelines` | **Installed, available** | vercel-labs/agent-skills v1.1.0; guidelines pinned to upstream commit `434b7f9` (SHA-256 `d246b026…`) | Rules bundled; skill says "do not fetch rules from the network" |
| A11Y / CRIT / DSYS / COPY | `design` plugin (`accessibility-review`, `design-critique`, `design-system`, `ux-copy`) | Installed (plugin, loads next session) → **fallback in this session** | anthropic-plugin-directory | Markdown skills |
| REACT | `vercel-react-best-practices` | **Installed, available** | vercel-labs/agent-skills | Markdown rules only |
| COMPOSE | `vercel-composition-patterns` | **Installed, available** | vercel-labs/agent-skills (published name differs from SKILLS.md `composition-patterns`) | Markdown only |
| SEC | `security-guidance` | Installed then **disabled** | claude-plugins-official | Rejected under §1.5: installs SessionStart/PostToolUse/Stop hooks, auto-installs a Python SDK and sends git diffs to an LLM review API. Fallback: built-in `/security-review` + `docs/SECURITY_PRINCIPLES.md` checklist + fresh adversarial reviewer agents |
| SAST | Trail of Bits (`semgrep`, `codeql`, `sharp-edges`, `differential-review`, `wycheproof`) | **Installed, available** (subset only, not the whole bundle) | trailofbits/skills | Semgrep/CodeQL binaries are not installed; scans fall back to `npm audit`, lint rules and manual audit unless the binaries are installed later |
| WEBTEST | `webapp-testing` | **Installed, available** | anthropics/skills | Local Python helper `with_server.py`; no network calls |
| PW | `playwright` plugin | Installed (MCP plugin, loads next session) → **fallback in this session**: `@playwright/test` directly | claude-plugins-official | Local browser automation |
| TDD / DEBUG / REVIEW | `superpowers` | Installed (loads next session) → **fallback in this session** | superpowers-marketplace v-latest | Has a local SessionStart hook that injects text (no network). Its "ask the user/brainstorm first" guidance is overridden by the kit's continuous-execution rule (SKILLS.md §6) |
| VERIFY | built-in `/verify` | Not listed in this session → fallback `npm run build` + Playwright smoke | — | — |
| DATAVIZ | `dataviz` | **Available** (session-listed) | Anthropic | — |

## 5. Risks and assumptions

1. **No real Supabase in the loop.** RLS policies are exercised on PGlite (same SQL), but Supabase-specific behaviour (pooler, hosted Storage) is unverified until a project is provisioned. Documented as a limitation; revisit in Phase 20/21.
2. **OneDrive-synced working tree.** Large `node_modules` may slow tooling or cause file locks. Mitigation: no worktrees by default; if locks appear, record and retry.
3. **Chromium only** for automated browser tests unless Firefox/WebKit downloads succeed later.
4. **No physical phones.** Mobile is validated by Playwright device emulation and viewport tests (labelled simulated).
5. **Skills-in-session.** Several approved skills only load in a new session; their fallbacks are used now (recorded above).

## 6. Initial execution plan

Phases run in roadmap order with the parallelism in `ROADMAP.md`. Each phase: contracts (Lead) → parallel builder agents on disjoint paths → tests → fresh reviewers → fixes → gate → checkpoint commit on `phase/NN-*`, fast-forward to `main`, push.
