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
  lines="$(wc -l < "$f")"
  [[ "$lines" -gt 10 ]] || die "curriculum $(basename "$f") too short"
done < <(find "$CTO_ROOT/curricula" -maxdepth 1 -type f -name '*.md' ! -name 'README.md' | sort)
[[ "$cur_count" -ge 7 ]] && ok "${cur_count} curricula" || die "expected ≥7 curricula, got ${cur_count}"

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
