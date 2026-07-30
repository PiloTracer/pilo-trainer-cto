#!/usr/bin/env bash
# framework-verify.sh — Self-verification for CTO Professor OS
set -euo pipefail

if [[ "${1:-}" == "--self-test" ]]; then
  echo "framework-verify self-test: PASS"
  exit 0
fi

CTO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$CTO_ROOT"

errors=0
note() { echo ""; echo "==> $1"; }
ok() { echo "    OK: $1"; }
die() { echo "    FAIL: $1"; errors=$((errors + 1)); }

echo "=== CTO Professor OS Framework Verify ==="

note "Required tools"
for cmd in git rsync bash grep find perl; do
  if command -v "$cmd" &>/dev/null; then ok "$cmd"; else die "missing $cmd"; fi
done

note "Git repo"
git rev-parse --is-inside-work-tree &>/dev/null && ok "inside git work tree" || die "not a git repository"

note "Core files"
for f in README.md START_HERE.md PROCESS_ROUTER.md LICENSE templates/bootstrap.sh \
  scripts/deploy-basic.sh scripts/deploy-files.sh scripts/deploy-repo.sh; do
  [[ -f "$CTO_ROOT/$f" ]] && ok "$f" || die "missing $f"
done

note "Skills registered"
skill_count=0
while IFS= read -r d; do
  id="$(basename "$d")"
  skill_count=$((skill_count + 1))
  [[ -f "$d/skill.md" ]] || die "skills/${id}/skill.md missing"
  grep -qE "^\| ${id} " "$CTO_ROOT/skills/README.md" || die "skills/${id} not in skills/README.md"
  fm_name="$(grep -m1 '^name:' "$d/skill.md" | sed 's/^name:[[:space:]]*//' | tr -d '[:space:]')"
  [[ "$fm_name" == "$id" ]] || die "skills/${id}/skill.md frontmatter name '${fm_name}' != folder"
done < <(find "$CTO_ROOT/skills" -mindepth 1 -maxdepth 1 -type d ! -name '.*' | sort)
ok "${skill_count} skills registered"

readme_row_count="$(awk '/^### Skills at a glance$/{flag=1; next} flag && /^## /{flag=0} flag && /^\| \*\*/{c++} END{print c+0}' "$CTO_ROOT/README.md")"
if [[ "$readme_row_count" -eq "$skill_count" ]]; then
  ok "README.md 'Skills at a glance' row count (${readme_row_count}) matches"
else
  die "README.md 'Skills at a glance' row count (${readme_row_count}) != folder count (${skill_count})"
fi

while IFS= read -r skill_id; do
  [[ -z "$skill_id" ]] && continue
  grep -qE "^\\| \\*\\*${skill_id}\\*\\* " "$CTO_ROOT/README.md" || die "README.md 'Skills at a glance' missing '${skill_id}'"
done < <(find "$CTO_ROOT/skills" -mindepth 1 -maxdepth 1 -type d ! -name '.*' -printf '%f\n' | sort)
ok "README.md 'Skills at a glance' covers every skills/ folder"

while IFS= read -r skill_id; do
  [[ -z "$skill_id" ]] && continue
  grep -qE "^\\| ${skill_id} " "$CTO_ROOT/.cursorrules" || die "skills/README.md lists '${skill_id}' missing from .cursorrules"
done < <(awk '/^## Registered skills$/{flag=1; next} flag && /^## /{flag=0} flag && /^[|]/{print $2}' "$CTO_ROOT/skills/README.md" | grep -E '^[a-z0-9_-]+$' | sort -u)
ok ".cursorrules covers skills/README.md"

note "Standards non-empty"
std_count=0
while IFS= read -r f; do
  std_count=$((std_count + 1))
  lines="$(wc -l < "$f")"
  [[ "$lines" -gt 5 ]] || die "standard $(basename "$f") stub (${lines} lines)"
done < <(find "$CTO_ROOT/standards" -maxdepth 1 -type f -name '*.md' | sort)
[[ "$std_count" -gt 0 ]] && ok "${std_count} standards" || die "no standards"

note "Curricula catalog"
cur_count=0
while IFS= read -r f; do
  cur_count=$((cur_count + 1))
  base="$(basename "$f")"
  lines="$(wc -l < "$f")"
  [[ "$lines" -gt 10 ]] || die "curriculum ${base} too short"
  # program-spec.md required sections
  for sec in "## Audience / level assumptions" "## Outcomes" "## Duration & cadence" \
    "## Modules" "## Exit criteria"; do
    grep -qF "$sec" "$f" || die "curriculum ${base} missing required SPEC section '${sec}'"
  done
  grep -qE '^## Assessment' "$f" || die "curriculum ${base} missing an Assessment section"
  # every catalog file must be registered
  slug="${base%.md}"
  grep -qF "\`${slug}\`" "$CTO_ROOT/curricula/README.md" || die "curriculum ${slug} not in curricula/README.md"
  grep -qF "\`${slug}\`" "$CTO_ROOT/skills/cto-program-standard/skill.md" || die "curriculum ${slug} not in cto-program-standard catalog table"
done < <(find "$CTO_ROOT/curricula" -maxdepth 1 -type f -name '*.md' ! -name 'README.md' | sort)
[[ "$cur_count" -ge 8 ]] && ok "${cur_count} curricula, all SPEC-compliant and registered" || die "expected ≥8 curricula, got ${cur_count}"

note "References library"
if [[ -f "$CTO_ROOT/references/core-library.md" ]] && [[ -f "$CTO_ROOT/references/README.md" ]]; then
  grep -qF "Verified" "$CTO_ROOT/references/core-library.md" || die "references/core-library.md has no verification markers"
  grep -qF "Gaps worth filling" "$CTO_ROOT/references/core-library.md" || die "references/core-library.md missing the gaps section"
  ok "references/ present with verification status"
else
  die "missing references/ library (agents would invent reading lists)"
fi

note "Drill case library"
if [[ -f "$CTO_ROOT/drills/case-library.md" ]] && [[ -f "$CTO_ROOT/drills/README.md" ]]; then
  grep -qF "Pre-read boundary" "$CTO_ROOT/drills/case-library.md" || die "drills/case-library.md missing pre-read boundaries"
  grep -qF "case-library" "$CTO_ROOT/skills/cto-drill/skill.md" || die "skills/cto-drill does not reference the case library"
  ok "drills/ present and wired into cto-drill"
else
  die "missing drills/ case library"
fi

note "Gate contracts"
# Every skill with a row in the SKILL_DEPENDENCIES requirements table must declare
# Requires:, emit the canonical BLOCKED report, and document a -y waiver if one is granted.
deps="$CTO_ROOT/skills/SKILL_DEPENDENCIES.md"
while IFS='|' read -r _ sid req waiver _; do
  sid="$(echo "$sid" | tr -d '`[:space:]')"
  [[ -z "$sid" || "$sid" == "Skill" || "$sid" =~ ^-+$ ]] && continue
  f="$CTO_ROOT/skills/${sid}/skill.md"
  [[ -f "$f" ]] || { die "SKILL_DEPENDENCIES lists unknown skill '${sid}'"; continue; }
  grep -qF '**Requires:**' "$f" || die "skills/${sid} has a gate row but no '**Requires:**' line"
  grep -qF 'BLOCKED' "$f" || die "skills/${sid} is gated but never emits the canonical BLOCKED report"
  if echo "$waiver" | grep -q '\-y'; then
    grep -qF -- '-y' "$f" || die "skills/${sid} is granted a -y waiver in SKILL_DEPENDENCIES but does not document it"
  fi
done < <(awk '/^## Skill requirements$/{flag=1; next} flag && /^## /{flag=0} flag && /^\|/{print}' "$deps")
ok "gated skills declare Requires, BLOCKED, and their waivers"

# Drill types referenced by curricula must exist in the cto-drill type table.
while IFS= read -r dtype; do
  grep -qF "\`${dtype}\`" "$CTO_ROOT/skills/cto-drill/skill.md" \
    || die "drill type '${dtype}' used by a curriculum but absent from cto-drill's type table"
done < <(grep -rhoE '\*\*Drill:\*\* `[a-z-]+`' "$CTO_ROOT/curricula" | sed 's/.*`\([a-z-]*\)`.*/\1/' | sort -u)
ok "every drill type referenced by a curriculum is defined"

note "Program folder templates"
for t in progress.md.template notes.md.template README.md.template; do
  [[ -f "$CTO_ROOT/templates/training/programs/$t" ]] || die "missing templates/training/programs/${t}"
done
grep -qF "Retrieval queue" "$CTO_ROOT/templates/training/programs/notes.md.template" \
  || die "notes.md.template has no retrieval queue — standards/mentoring.md depends on it"
for s in cto-program-standard cto-program-custom; do
  grep -qF "notes.md.template" "$CTO_ROOT/skills/$s/skill.md" \
    || die "skills/${s} does not seed notes.md from its template (retrieval queue would be missing)"
done
ok "program folder templates present and seeded"

note "Standards are bound by a skill"
for std in "$CTO_ROOT"/standards/*.md; do
  name="$(basename "$std" .md)"
  if ! grep -rqF "standards/${name}.md" "$CTO_ROOT/skills" ; then
    die "standard ${name}.md is orphaned — no skill references it"
  fi
done
ok "every standard is referenced by at least one skill"

note "Task ledger contract"
LEDGER_TPL="templates/training/programs/progress.md.template"
if [[ -f "$CTO_ROOT/$LEDGER_TPL" ]]; then
  ok "$LEDGER_TPL present"
  for hdr in "## Task ledger" "Done/Total" "Deliverables complete"; do
    grep -qF "$hdr" "$CTO_ROOT/$LEDGER_TPL" || die "$LEDGER_TPL missing '${hdr}'"
  done
else
  die "missing $LEDGER_TPL (task ledger schema)"
fi

for s in cto-program-standard cto-program-custom; do
  grep -qF "progress.md.template" "$CTO_ROOT/skills/$s/skill.md" \
    || die "skills/${s} does not seed the ledger from $LEDGER_TPL"
done
for s in cto-mentor cto-drill; do
  grep -qF "task ledger" "$CTO_ROOT/skills/$s/skill.md" \
    || die "skills/${s} does not update the task ledger (status would go stale)"
done
grep -qF "progress.md" "$CTO_ROOT/skills/cto-review/skill.md" \
  || die "skills/cto-review does not read progress.md as its status source"
ok "ledger seeded by program skills, ticked by mentor/drill, read by review"

note ".cursorrules / template sync"
if diff -q "$CTO_ROOT/.cursorrules" "$CTO_ROOT/templates/cursorrules.template" &>/dev/null; then
  ok ".cursorrules matches templates/cursorrules.template"
else
  die ".cursorrules has drifted from templates/cursorrules.template (self-hosted copy must stay identical to the deployable template)"
fi

note "Thin deploy smoke"
SMOKE="$(mktemp -d)"
bash "$CTO_ROOT/scripts/deploy-basic.sh" "$SMOKE" || die "deploy-basic failed"
[[ -f "$SMOKE/.cursorrules" ]] || die "smoke missing .cursorrules"
[[ -d "$SMOKE/.training.cto/context" ]] || die "smoke missing .training.cto"
grep -q "TRAINER_CTO_SOURCE=$CTO_ROOT" "$SMOKE/.cursorrules" || die "smoke pointer wrong"
ok "deploy-basic smoke → $SMOKE"
rm -rf "$SMOKE"

note "Fat deploy smoke (framework assets must travel)"
SMOKEF="$(mktemp -d)"
if bash "$CTO_ROOT/scripts/deploy-files.sh" "$SMOKEF" &>/dev/null; then
  for d in skills curricula standards references drills templates; do
    [[ -d "$SMOKEF/.ai.cto/$d" ]] || die "fat-client smoke missing .ai.cto/${d}"
  done
  ok "deploy-files smoke carries every framework directory → $SMOKEF"
else
  die "deploy-files failed"
fi
rm -rf "$SMOKEF"

note "Standalone cto-bootstrap init smoke (thin-client via explicit source arg)"
SMOKE2="$(mktemp -d)"
TRAINER_CTO_SOURCE="$CTO_ROOT" REPO_ROOT="$SMOKE2" bash "$CTO_ROOT/templates/bootstrap.sh" &>/dev/null \
  || die "standalone bootstrap.sh failed"
grep -q "TRAINER_CTO_SOURCE=$CTO_ROOT" "$SMOKE2/.cursorrules" 2>/dev/null \
  && ok "standalone bootstrap.sh smoke (explicit source) → $SMOKE2" \
  || die "standalone bootstrap.sh did not substitute TRAINER_CTO_SOURCE for an explicit, differing source"
rm -rf "$SMOKE2"

note "Self-hosted bootstrap.sh smoke (no TRAINER_CTO_SOURCE arg → placeholder stays)"
SMOKE3="$(mktemp -d)"
mkdir -p "$SMOKE3/templates"
cp "$CTO_ROOT/templates/bootstrap.sh" "$SMOKE3/templates/bootstrap.sh"
cp -r "$CTO_ROOT/templates/training" "$SMOKE3/templates/training"
cp "$CTO_ROOT/templates/cursorrules.template" "$SMOKE3/templates/cursorrules.template"
(cd "$SMOKE3" && git init -q && bash templates/bootstrap.sh &>/dev/null) || die "self-hosted bootstrap.sh smoke failed"
grep -q "TRAINER_CTO_SOURCE=REPLACE_BASICSOURCE" "$SMOKE3/.cursorrules" 2>/dev/null \
  && ok "self-hosted bootstrap.sh smoke (placeholder preserved) → $SMOKE3" \
  || die "self-hosted bootstrap.sh smoke unexpectedly substituted TRAINER_CTO_SOURCE"
rm -rf "$SMOKE3"

echo ""
if [[ "$errors" -eq 0 ]]; then
  echo "=== PASS ==="
  exit 0
else
  echo "=== FAIL ($errors errors) ==="
  exit 1
fi
