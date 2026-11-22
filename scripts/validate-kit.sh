#!/usr/bin/env bash
# Validates the execution kit: required files, phase files, roadmap links,
# spec-section coverage and requirement-ID mapping. Exit 1 on any failure.
set -u
cd "$(dirname "$0")/.."
fail=0
err() { echo "FAIL: $*"; fail=1; }

# 1. Required files
for f in CLAUDE.md AGENTS.md SKILLS.md README.md ROADMAP.md PROGRESS.md \
  REMOTE_PROGRESS/STATUS.md REMOTE_PROGRESS/PHASE_LOG.md \
  docs/MULTI_AGENT_COORDINATION.md docs/OWNERSHIP.md docs/CHECKPOINTING_AND_RECOVERY.md \
  docs/PHASE_GATES.md docs/DEFINITION_OF_DONE.md docs/TESTING_STRATEGY.md \
  docs/SECURITY_PRINCIPLES.md docs/DESIGN_PRINCIPLES.md docs/REQUIREMENTS_TRACEABILITY.md \
  docs/spec/MASTER_SPEC.md docs/ARCHITECTURE.md docs/DEPENDENCIES.md docs/GENERATED_ARTIFACTS.md docs/design/BRIEF.md docs/finance/NET_WORTH_RULES.md docs/finance/INVESTMENT_RULES.md docs/reviews/README.md .gitignore docs/decisions/ADR-0000-template.md docs/decisions/ADR-0001-stack-reconciliation.md \
  phases/_TEMPLATE.md .claude/commands/resume.md .claude/commands/checkpoint.md .claude/commands/phase-gate.md; do
  [ -f "$f" ] || err "missing $f"
done

# 1b. CLAUDE.md must reference SKILLS.md; SKILLS.md must cover every phase 00-21
grep -q "SKILLS.md" CLAUDE.md || err "CLAUDE.md does not reference SKILLS.md"
for n in $(seq -w 0 21); do
  grep -qE "^\| $n \|" SKILLS.md || err "SKILLS.md matrix lacks phase $n"
done

# 2. 22 phase files exist and are referenced by ROADMAP.md
count=0
for n in $(seq -w 0 21); do
  p=$(ls phases/PHASE_${n}_*.md 2>/dev/null | head -1)
  if [ -z "$p" ]; then err "missing phase file for $n"; else
    count=$((count+1))
    grep -q "$p" ROADMAP.md || err "ROADMAP.md does not reference $p"
    for h in "Acceptance criteria" "Testing requirements" "Work streams"; do
      grep -qi "$h" "$p" || err "$p lacks section: $h"
    done
  fi
done
echo "phase files found: $count/22"

# 3. Every spec section 1..41 is present in the spec copy and mapped S01..S41
for i in $(seq 1 41); do
  id=$(printf "S%02d" "$i")
  grep -qE "^# $i\. " docs/spec/MASTER_SPEC.md || err "spec section $i not found in MASTER_SPEC.md"
  grep -q "^| $id " docs/REQUIREMENTS_TRACEABILITY.md || err "$id missing from traceability table"
  grep -rqE "\b$id\b" phases/ || err "$id not referenced by any phase file"
done

# 4. Final directive and addendum IDs
for id in SFD A01 A02 A03 A04 A05 A06 A07; do
  grep -q "^| $id " docs/REQUIREMENTS_TRACEABILITY.md || err "$id missing from traceability table"
  grep -rqE "\b$id\b" phases/ || err "$id not referenced by any phase file"
done

# 5. Spec addendum keywords still present in phase files
chk() { grep -rqi "$1" phases/ || err "keyword not covered in phases: $1"; }
chk "saved emails"; chk "suggest"; chk "installable\|manifest"; chk "light and dark"; chk "ideas"
chk "Android"; chk "worktree\|PROGRESS.md"; chk "Argon2id"; chk "Credential Management"

# 6. Every phase 00-21 numbered in traceability "Primary" column is a valid phase
if grep -E "^\| (S|A)[0-9F]" docs/REQUIREMENTS_TRACEABILITY.md | awk -F'|' '{gsub(/ /,"",$5); print $5}' | grep -vE '^[0-9]{2}$' | grep -q .; then
  err "traceability Primary column contains non-phase values"
fi

# 7. Next.js-only policy: no Vite/Vitest/separate-backend references except explicit prohibitions
bad=$(grep -rniE "vite|vitest" --include="*.md" --include="*.sh" --include="*.json" . \
  --exclude-dir=.cache --exclude-dir=.npm --exclude-dir=.npm-global --exclude-dir=.config --exclude-dir=remote --exclude-dir=skills \
  --exclude=MASTER_SPEC.md --exclude=validate-kit.sh \
  | grep -viE "(no |not |never|forbidden|without|replac|reject|depends on vite|empty|returns nothing)" || true)
[ -z "$bad" ] || { echo "$bad"; err "Vite/Vitest referenced without an explicit prohibition"; }
grep -q "Jest" docs/TESTING_STRATEGY.md || err "TESTING_STRATEGY.md must specify Jest (next/jest)"
grep -qi "Route Handlers" docs/ARCHITECTURE.md || err "ARCHITECTURE.md must describe Route Handlers backend"
grep -qi "forbidden" docs/DEPENDENCIES.md || err "DEPENDENCIES.md must list forbidden items"
grep -qi "Accepted" docs/decisions/ADR-0001-stack-reconciliation.md || err "ADR-0001 must be Accepted"

# 8. Every referenced docs/ path exists in the kit or is registered in GENERATED_ARTIFACTS.md
while read -r tok; do
  base="${tok%%\**}"; base="${base%/}"
  [ -e "$tok" ] && continue
  [ -n "$base" ] && [ -e "$base" ] && case "$tok" in *\**) continue;; esac
  grep -qF "$tok" docs/GENERATED_ARTIFACTS.md || err "unregistered missing path referenced: $tok"
done < <(grep -rhoE '`docs/[A-Za-z0-9_./*-]+`' CLAUDE.md AGENTS.md README.md ROADMAP.md PROGRESS.md docs phases \
  --include="*.md" --exclude=MASTER_SPEC.md --exclude=GENERATED_ARTIFACTS.md | tr -d '`' | sort -u)

if [ "$fail" -eq 0 ]; then echo "OK: kit validation passed"; else echo "Kit validation FAILED"; exit 1; fi
