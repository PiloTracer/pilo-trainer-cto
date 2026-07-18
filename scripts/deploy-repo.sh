#!/usr/bin/env bash
# deploy-repo.sh — Full deploy of CTO Professor OS (clone or archive).
#
# Usage:
#   bash scripts/deploy-repo.sh clone <git-url> <target-path>
#   bash scripts/deploy-repo.sh archive <target-path>
#
set -euo pipefail

MODE="${1:?Usage: $0 clone <url> <target> | archive <target>}"
shift

if [[ -n "${TRAINER_CTO_SOURCE:-}" ]]; then
  CTO_ROOT="$(cd "$TRAINER_CTO_SOURCE" && pwd)"
else
  CTO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fi

case "$MODE" in
  clone)
    URL="${1:?clone requires <git-url>}"
    DEST="${2:?clone requires <target-path>}"
    git clone "$URL" "$DEST"
    echo "Cloned to $DEST"
    echo "Next: cd $DEST && bash templates/bootstrap.sh"
    ;;
  archive)
    DEST="${1:?archive requires <target-path>}"
    mkdir -p "$DEST"
    ARCHIVE="${DEST}/cto-professor-os-$(date +%Y%m%d).tar.gz"
    tar -C "$CTO_ROOT" \
      --exclude '.git' \
      --exclude '.training.cto' \
      --exclude 'tmp' \
      --exclude '.tmp' \
      -czf "$ARCHIVE" .
    echo "Wrote $ARCHIVE"
    ;;
  *)
    echo "ERROR: unknown mode: $MODE (use clone|archive)" >&2
    exit 1
    ;;
esac
