#!/usr/bin/env bash
# verify-target.sh — Verify a CTO Professor OS deploy target's .cursorrules wiring.
#
# Usage:
#   bash scripts/verify-target.sh <target-path>
#
# Checks (FAIL → exit 1; WARN/INFO → exit 0):
#   1. .cursorrules present
#   2. TRAINER_CTO_SOURCE → mode detection (thin / fat / self-hosted)
#   3. Thin: pointer reachable, has skills/ + templates/cursorrules.template,
#      and matches the source this script belongs to (stale-pointer warning)
#   4. Fat: local .ai.cto/skills/ present; self-hosted: repo root is the framework
#   5. Remaining REPLACE: tokens (operator-filled vs auto-discovered *_PATH)
#   6. Frameworks registry: the six sister frameworks (.ai.<fw>, legacy + family
#      naming) + Agent OS anchor (.ai / pilo.ai.logicbison) resolvable via
#      filled path cell or sibling auto-discovery
#   7. .work.cto/ learner-memory skeleton
#   8. Thin target with a local .ai.cto/skills/ → fat-client leak warning
#
set -euo pipefail

CTO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

RAW_TARGET="${1:-.}"
if [[ "$RAW_TARGET" == "." || "$RAW_TARGET" == "$PWD" ]]; then
  DEST_ROOT="$(pwd)"
else
  if [[ ! -d "$RAW_TARGET" ]]; then
    echo "ERROR: target directory does not exist: $RAW_TARGET" >&2
    exit 1
  fi
  DEST_ROOT="$(cd "$RAW_TARGET" && pwd)"
fi

CURS="${DEST_ROOT}/.cursorrules"
fails=0
warns=0
ok()   { echo "  OK:   $1"; }
info() { echo "  INFO: $1"; }
warn() { echo "  WARN: $1"; warns=$((warns + 1)); }
fail() { echo "  FAIL: $1"; fails=$((fails + 1)); }

echo "=== cto verify-target → $DEST_ROOT ==="
echo "  verifier source: $CTO_ROOT"

# --- 1. .cursorrules present -------------------------------------------------
if [[ ! -f "$CURS" ]]; then
  fail ".cursorrules missing — run @cto-deploy-basic (thin) or @cto-deploy-files (fat)"
  echo ""
  echo "=== FAIL ($fails failed, $warns warnings) ==="
  exit 1
fi
ok ".cursorrules present"

# --- 2-4. Source pointer / mode detection ------------------------------------
src=""
if grep -qE '^TRAINER_CTO_SOURCE=' "$CURS"; then
  src="$(grep -oE 'TRAINER_CTO_SOURCE=[^ ]*' "$CURS" | head -1 | cut -d= -f2-)"
fi

DISCOVERY_BASE=""
if [[ -z "$src" ]]; then
  fail "no TRAINER_CTO_SOURCE line — not a CTO Professor OS rules file"
  fail "  if this target has Agent OS / sibling rules, merge the Source-resolution section (do not clobber)"
elif [[ "$src" == "REPLACE_BASICSOURCE" ]]; then
  if [[ -d "${DEST_ROOT}/.ai.cto/skills" ]]; then
    ok "mode: fat-client (local .ai.cto/skills/)"
    DISCOVERY_BASE="$(cd "${DEST_ROOT}/.." && pwd)"
  elif [[ -d "${DEST_ROOT}/skills" && -f "${DEST_ROOT}/templates/cursorrules.template" ]]; then
    ok "mode: self-hosted source (repo root is the framework)"
    DISCOVERY_BASE="$(cd "${DEST_ROOT}/.." && pwd)"
  else
    fail "TRAINER_CTO_SOURCE placeholder unfilled and no local .ai.cto/skills/ — incomplete deploy"
  fi
else
  if [[ ! -d "$src" ]]; then
    fail "thin-client pointer UNREACHABLE: $src"
    info "  if the framework moved, re-run: @cto-deploy-basic - $DEST_ROOT update"
  elif [[ ! -d "$src/skills" || ! -f "$src/templates/cursorrules.template" ]]; then
    fail "thin-client pointer is not a CTO Professor OS source: $src (missing skills/ or templates/cursorrules.template)"
  else
    ok "mode: thin-client, source reachable: $src"
    src_real="$(cd "$src" && pwd)"
    if [[ "$src_real" != "$CTO_ROOT" ]]; then
      warn "pointer source ($src_real) differs from this framework ($CTO_ROOT) — re-sync with: @cto-deploy-basic - $DEST_ROOT update"
    fi
    DISCOVERY_BASE="$(cd "${src_real}/.." && pwd)"
  fi
fi

# --- 5. Remaining REPLACE: tokens ---------------------------------------------
tokens="$(grep -oE 'REPLACE:[A-Z_]+' "$CURS" | sort -u || true)"
if [[ -z "$tokens" ]]; then
  ok "no REPLACE: tokens remain"
else
  while IFS= read -r tok; do
    case "$tok" in
      REPLACE:PROJECT_NAME|REPLACE:LEARNER_LEVEL|REPLACE:PRIMARY_GOAL)
        warn "$tok unfilled — operator must set it" ;;
      REPLACE:AI_PATH|REPLACE:AI_UI_PATH|REPLACE:AI_BIZ_PATH|REPLACE:AI_SOC_PATH|REPLACE:AI_FLUTTER_PATH|REPLACE:AI_MLT_PATH)
        info "$tok unset — sibling auto-discovery applies (see registry check below)" ;;
      *) warn "$tok unfilled" ;;
    esac
  done <<< "$tokens"
fi

# --- 6. Frameworks registry (sister discovery) --------------------------------
if [[ -n "$DISCOVERY_BASE" ]]; then
  # Sister frameworks: the six .ai.<fw> slots (legacy + family naming via
  # sister-discovery.sh) + the Agent OS anchor (.ai / pilo.ai.logicbison).
  source "$(dirname "${BASH_SOURCE[0]}")/sister-discovery.sh"
  fw_dir=""
  for fw in $FRAMEWORK_SLOTS; do
    fw_dir="$(find_sister_dir "$CTO_ROOT" "$fw" "$DISCOVERY_BASE" || true)"
    if [[ -n "$fw_dir" ]]; then
      ok ".ai.$fw → $fw_dir (bootstrap artifact present)"
    else
      warn ".ai.$fw not found — do not route to its director until installed"
    fi
  done
  # Agent OS anchor (not a .ai.<fw> slot): .ai or pilo.ai.logicbison.
  ag_found=0
  for ag in .ai pilo.ai.logicbison; do
    if [[ -f "$DISCOVERY_BASE/$ag/skills/README.md" ]]; then
      ok "$ag → $DISCOVERY_BASE/$ag (Agent OS anchor present)"
      ag_found=1
    fi
  done
  [[ "$ag_found" -eq 1 ]] || warn "no Agent OS anchor (.ai / pilo.ai.logicbison) found under $DISCOVERY_BASE — set REPLACE:AI_PATH manually before routing @x-director work"
else
  info "frameworks registry skipped (no discovery base — resolve source pointer first)"
fi

# --- 7. .work.cto/ skeleton ----------------------------------------------------
if [[ -d "${DEST_ROOT}/.work.cto/context" && -d "${DEST_ROOT}/.work.cto/plans" ]]; then
  ok ".work.cto/ learner-memory skeleton present"
else
  warn ".work.cto/ skeleton incomplete — run @cto-bootstrap init (or re-run deploy)"
fi

# --- 8. Fat-client leak in thin target -----------------------------------------
if [[ -n "$src" && "$src" != "REPLACE_BASICSOURCE" && -d "${DEST_ROOT}/.ai.cto/skills" ]]; then
  warn "local .ai.cto/skills/ present in a thin-client target — fat-client leak (modes disagree on where skills live)"
fi

echo ""
if [[ "$fails" -eq 0 ]]; then
  echo "=== PASS ($warns warnings) ==="
  exit 0
else
  echo "=== FAIL ($fails failed, $warns warnings) ==="
  exit 1
fi
