#!/usr/bin/env bash
# deploy-basic.sh — Thin-client bootstrap of CTO Professor OS into a target project.
#
# Copies ONLY:
#   - .cursorrules (TRAINER_CTO_SOURCE → absolute path of THIS source)
#   - .training.cto/ skeleton
#
# Skills/curricula/standards stay in the source.
#
# Usage:
#   bash scripts/deploy-basic.sh <target-path>
#   bash scripts/deploy-basic.sh --status [target-path]
#   bash scripts/deploy-basic.sh <target-path> --update
#   bash scripts/deploy-basic.sh <target-path> --force
#   TRAINER_CTO_SOURCE=/path bash scripts/deploy-basic.sh <target-path>
#
set -euo pipefail

if [[ "${1:-}" == "--status" ]]; then
  shift
  RAW_TARGET="${1:-.}"
  if [[ "$RAW_TARGET" == "." || "$RAW_TARGET" == "$PWD" ]]; then
    DEST_ROOT="$(pwd)"
  else
    DEST_ROOT="$(cd "$RAW_TARGET" && pwd)"
  fi
  CURS_DEST="${DEST_ROOT}/.cursorrules"
  echo "=== deploy-basic status → $DEST_ROOT ==="
  if [[ -f "$CURS_DEST" ]]; then
    echo "  .cursorrules: present"
    src="$(grep -oE 'TRAINER_CTO_SOURCE=[^ ]*' "$CURS_DEST" 2>/dev/null | head -1 | cut -d= -f2- || true)"
    if [[ -n "$src" && "$src" != "REPLACE_BASICSOURCE" ]]; then
      if [[ -d "$src" ]]; then echo "  TRAINER_CTO_SOURCE: $src (reachable)"; else echo "  TRAINER_CTO_SOURCE: $src (UNREACHABLE)"; fi
    elif grep -q 'TRAINER_CTO_SOURCE=' "$CURS_DEST"; then
      echo "  TRAINER_CTO_SOURCE: <unset token>"
    else
      echo "  TRAINER_CTO_SOURCE: missing"
    fi
  else
    echo "  .cursorrules: MISSING"
  fi
  [[ -d "${DEST_ROOT}/.training.cto/context" ]] && echo "  .training.cto/: present" || echo "  .training.cto/: missing"
  [[ -d "${DEST_ROOT}/.ai.cto/skills" ]] && echo "  local .ai.cto/skills/: present (WARN — fat-client leak)" || echo "  local .ai.cto/skills/: absent (thin-client ok)"
  exit 0
fi

RAW_TARGET="${1:?Usage: $0 [--status] <target-path> [--force|--update]}"
shift || true
MODE="skip"
while [[ $# -gt 0 ]]; do
  case "$1" in
    --force)  MODE="force" ;;
    --update) MODE="update" ;;
    *) echo "ERROR: unknown flag: $1" >&2; exit 1 ;;
  esac
  shift
done

if [[ -n "${TRAINER_CTO_SOURCE:-}" ]]; then
  CTO_ROOT="$(cd "$TRAINER_CTO_SOURCE" && pwd)"
else
  CTO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fi

if [[ "$RAW_TARGET" == "." || "$RAW_TARGET" == "$PWD" ]]; then
  DEST_ROOT="$(pwd)"
else
  DEST_ROOT="$(cd "$RAW_TARGET" && pwd)"
fi

if [[ ! -d "$DEST_ROOT" ]]; then
  echo "ERROR: target directory does not exist: $DEST_ROOT" >&2
  exit 1
fi

TPL_CURS="${CTO_ROOT}/templates/cursorrules.template"
if [[ ! -f "$TPL_CURS" ]]; then
  echo "ERROR: source missing templates/cursorrules.template at $CTO_ROOT" >&2
  exit 1
fi
if [[ ! -d "${CTO_ROOT}/skills" ]]; then
  echo "ERROR: source missing skills/ at $CTO_ROOT" >&2
  exit 1
fi

CURS_DEST="${DEST_ROOT}/.cursorrules"
WORK_FILES=(
  "README.md" "context/PROFILE.md" "context/HANDOFF.md"
  "plans/NEXT.md" "plans/UNKNOWNS.md" "plans/ASSUMPTIONS.md"
  "programs/README.md" "sessions/README.md" "consultancy/README.md"
  "sources/README.md" "assessments/README.md" "progress/COMPETENCY.md"
  "reports/README.md" "standards/README.md"
)

echo "=== deploy-basic (CTO Professor OS) → $DEST_ROOT (thin-client) ==="
echo "  source: $CTO_ROOT"
echo "  mode:   $MODE"

if [[ -d "${DEST_ROOT}/.ai.cto/skills" ]]; then
  echo "  WARN: target has local .ai.cto/skills/ (fat-client leak)"
  if [[ "$MODE" != "force" ]]; then
    echo "  BLOCKED: use --force to confirm, or remove local .ai.cto/"
    exit 1
  fi
fi

subst_cursorules() {
  CTO_ROOT_ESC="${CTO_ROOT//\//\\/}"
  perl -pe "s/TRAINER_CTO_SOURCE=REPLACE_BASICSOURCE/TRAINER_CTO_SOURCE=${CTO_ROOT_ESC}/" "$TPL_CURS"
}

existing_source=""
if [[ -f "$CURS_DEST" ]]; then
  existing_source="$(grep -oE 'TRAINER_CTO_SOURCE=[^ ]*' "$CURS_DEST" | head -1 | cut -d= -f2- || true)"
fi

if [[ "$MODE" == "force" ]]; then
  subst_cursorules > "$CURS_DEST"
  echo "  cursorules: wrote (TRAINER_CTO_SOURCE=$CTO_ROOT)"
elif [[ -f "$CURS_DEST" ]]; then
  echo "  cursorules: skip (exists) — keeping existing"
  if grep -q 'TRAINER_CTO_SOURCE=' "$CURS_DEST"; then
    :
  else
    echo "  cursorules: NOTE — existing .cursorrules has no TRAINER_CTO_SOURCE;"
    echo "    agent should merge Source-resolution section from template (do not clobber Agent OS rules)."
  fi
else
  subst_cursorules > "$CURS_DEST"
  echo "  cursorules: wrote (TRAINER_CTO_SOURCE=$CTO_ROOT)"
fi

if [[ "$MODE" == "update" ]] && [[ -f "$CURS_DEST" ]] && grep -q 'TRAINER_CTO_SOURCE=' "$CURS_DEST"; then
  if [[ "$existing_source" != "$CTO_ROOT" ]]; then
    CTO_ROOT_ESC="${CTO_ROOT//\//\\/}"
    perl -i -pe "s/TRAINER_CTO_SOURCE=[^\n]*/TRAINER_CTO_SOURCE=${CTO_ROOT_ESC}/" "$CURS_DEST"
    echo "  cursorules: re-synced TRAINER_CTO_SOURCE → $CTO_ROOT"
  fi
fi

BOOTSTRAP_SKIP_CURSERRULES=1 REPO_ROOT="$DEST_ROOT" TRAINER_CTO_SOURCE="$CTO_ROOT" \
  bash "$CTO_ROOT/templates/bootstrap.sh" \
  > /tmp/deploy-basic-cto-bootstrap.$$.log 2>&1 || { cat /tmp/deploy-basic-cto-bootstrap.$$.log; rm -f /tmp/deploy-basic-cto-bootstrap.$$.log; exit 1; }
grep -E '(created:|skip )' /tmp/deploy-basic-cto-bootstrap.$$.log | sed 's/^/  training: /' || true
rm -f /tmp/deploy-basic-cto-bootstrap.$$.log

if [[ "$MODE" == "update" ]]; then
  echo ""
  echo "=== update merge candidates ==="
  if [[ -f "$CURS_DEST" ]]; then
    tmp_cur="$(mktemp)"
    subst_cursorules > "$tmp_cur"
    if ! cmp -s "$tmp_cur" "$CURS_DEST"; then
      echo "  merge: .cursorrules"
    fi
    rm -f "$tmp_cur"
  fi
  TPL_WORK="${CTO_ROOT}/templates/training"
  for f in "${WORK_FILES[@]}"; do
    src="${TPL_WORK}/${f}.template"
    dest="${DEST_ROOT}/.training.cto/${f}"
    [[ -f "$src" && -f "$dest" ]] || continue
    if ! cmp -s "$src" "$dest"; then
      echo "  merge: .training.cto/${f}"
    fi
  done
fi

echo ""
echo "=== Done: thin-client bootstrap → $DEST_ROOT ==="
echo "  .cursorrules: $([ -f "$CURS_DEST" ] && echo present || echo MISSING)"
echo "  TRAINER_CTO_SOURCE: $(grep -oE 'TRAINER_CTO_SOURCE=[^ ]*' "$CURS_DEST" 2>/dev/null | head -1 | cut -d= -f2- || echo '<unset>')"
echo "  .training.cto/: $([ -d "${DEST_ROOT}/.training.cto" ] && echo present || echo MISSING)"
echo ""
echo "Next:"
echo "  1. Fill REPLACE: tokens in .cursorrules (except TRAINER_CTO_SOURCE)"
echo "  2. @session-cto start → @cto-bootstrap init → @cto-assess run"
