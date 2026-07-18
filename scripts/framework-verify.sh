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

readme_count="$(grep -oE '[0-9]+ skills in total' "$CTO_ROOT/README.md" | grep -oE '[0-9]+' | head -1 || true)"
if [[ -n "$readme_count" ]] && [[ "$readme_count" -eq "$skill_count" ]]; then
  ok "README.md skill count (${readme_count}) matches"
else
  die "README.md skill count (${readme_count:-missing}) != folder count (${skill_count})"
fi

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

note "Thin deploy smoke"
SMOKE="$(mktemp -d)"
bash "$CTO_ROOT/scripts/deploy-basic.sh" "$SMOKE" || die "deploy-basic failed"
[[ -f "$SMOKE/.cursorrules" ]] || die "smoke missing .cursorrules"
[[ -d "$SMOKE/.training.cto/context" ]] || die "smoke missing .training.cto"
grep -q "TRAINER_CTO_SOURCE=$CTO_ROOT" "$SMOKE/.cursorrules" || die "smoke pointer wrong"
ok "deploy-basic smoke → $SMOKE"
rm -rf "$SMOKE"

echo ""
if [[ "$errors" -eq 0 ]]; then
  echo "=== PASS ==="
  exit 0
else
  echo "=== FAIL ($errors errors) ==="
  exit 1
fi
