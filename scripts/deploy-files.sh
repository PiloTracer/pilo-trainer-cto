#!/usr/bin/env bash
# deploy-files.sh — Fat-client: vendor CTO Professor OS as .ai.cto/ into a target.
#
# Usage:
#   bash scripts/deploy-files.sh <target-path>
#   bash scripts/deploy-files.sh <target-path> --force
#
set -euo pipefail

RAW_TARGET="${1:?Usage: $0 <target-path> [--force]}"
shift || true
FORCE=0
[[ "${1:-}" == "--force" ]] && FORCE=1

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

DEST_AI="${DEST_ROOT}/.ai.cto"

echo "=== deploy-files (CTO Professor OS fat-client) → $DEST_AI ==="
echo "  source: $CTO_ROOT"

if [[ -d "$DEST_AI" ]] && [[ "$FORCE" -ne 1 ]]; then
  echo "ERROR: $DEST_AI exists. Pass --force to rsync update, or remove it." >&2
  exit 1
fi

mkdir -p "$DEST_AI"
rsync -a --delete \
  --exclude '.git/' \
  --exclude '.training.cto/' \
  --exclude 'tmp/' \
  --exclude '.tmp/' \
  --exclude '.credentials/' \
  --exclude '.private/' \
  --exclude '.cursor/' \
  --exclude '*.zip' \
  "${CTO_ROOT}/" "${DEST_AI}/"

# Remove nested self-reference noise if any
rm -rf "${DEST_AI}/.ai.cto" 2>/dev/null || true

BOOTSTRAP_SKIP_CURSERRULES=1 REPO_ROOT="$DEST_ROOT" TRAINER_CTO_SOURCE="$DEST_AI" \
  bash "$DEST_AI/templates/bootstrap.sh"

if [[ ! -f "${DEST_ROOT}/.cursorrules" ]]; then
  cp "${DEST_AI}/templates/cursorrules.template" "${DEST_ROOT}/.cursorrules"
  echo "created: ${DEST_ROOT}/.cursorrules (fill REPLACE tokens; leave TRAINER_CTO_SOURCE as REPLACE_BASICSOURCE for fat-client)"
else
  echo "skip: ${DEST_ROOT}/.cursorrules exists"
fi

echo ""
echo "=== Done: fat-client → $DEST_AI ==="
echo "Next: fill REPLACE: tokens · @session-cto start · @cto-bootstrap init"
