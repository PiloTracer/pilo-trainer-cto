#!/usr/bin/env bash
# bootstrap.sh — CTO Professor OS scaffold for any project
#
# Usage:
#   bash templates/bootstrap.sh
#   REPO_ROOT=/path/to/app bash templates/bootstrap.sh
#   TRAINER_CTO_SOURCE=/path/to/trainer-cto REPO_ROOT=/path bash templates/bootstrap.sh
#
# When TRAINER_CTO_SOURCE is explicitly passed and differs from REPO_ROOT, a freshly
# written .cursorrules gets TRAINER_CTO_SOURCE substituted with the real path (thin-client).
# Otherwise (self-hosted, or fat-client via deploy-files.sh which sets
# BOOTSTRAP_SKIP_CURSERRULES=1 and writes .cursorrules itself) the REPLACE_BASICSOURCE
# placeholder is left untouched.
#
set -euo pipefail

CALLER_TRAINER_CTO_SOURCE="${TRAINER_CTO_SOURCE:-}"
if [[ -n "${TRAINER_CTO_SOURCE:-}" ]]; then
  CTO_ROOT="$(cd "$TRAINER_CTO_SOURCE" && pwd)"
else
  CTO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fi
TPL="${CTO_ROOT}/templates/training"

if [[ -n "${REPO_ROOT:-}" ]]; then
  REPO_ROOT="$(cd "$REPO_ROOT" && pwd)"
elif [[ -d "${CTO_ROOT}/.git" ]]; then
  REPO_ROOT="${CTO_ROOT}"
elif [[ -d "${CTO_ROOT}/../.git" ]] && [[ -d "${CTO_ROOT}/templates" ]]; then
  REPO_ROOT="$(cd "${CTO_ROOT}/.." && pwd)"
else
  REPO_ROOT="${CTO_ROOT}"
fi

WORK="${REPO_ROOT}/.training.cto"

copy_if_missing() {
  local src="$1" dest="$2"
  if [[ -e "${dest}" ]]; then
    echo "skip (exists): ${dest}"
  else
    mkdir -p "$(dirname "${dest}")"
    cp "${src}" "${dest}"
    echo "created: ${dest}"
  fi
}

echo "CTO Professor OS bootstrap"
echo "  CTO_ROOT=${CTO_ROOT}"
echo "  REPO_ROOT=${REPO_ROOT}"
echo ""

mkdir -p "${WORK}"

copy_if_missing "${TPL}/README.md.template" "${WORK}/README.md"
copy_if_missing "${TPL}/context/PROFILE.md.template" "${WORK}/context/PROFILE.md"
copy_if_missing "${TPL}/context/HANDOFF.md.template" "${WORK}/context/HANDOFF.md"
copy_if_missing "${TPL}/plans/NEXT.md.template" "${WORK}/plans/NEXT.md"
copy_if_missing "${TPL}/plans/UNKNOWNS.md.template" "${WORK}/plans/UNKNOWNS.md"
copy_if_missing "${TPL}/plans/ASSUMPTIONS.md.template" "${WORK}/plans/ASSUMPTIONS.md"
copy_if_missing "${TPL}/programs/README.md.template" "${WORK}/programs/README.md"
copy_if_missing "${TPL}/sessions/README.md.template" "${WORK}/sessions/README.md"
copy_if_missing "${TPL}/consultancy/README.md.template" "${WORK}/consultancy/README.md"
copy_if_missing "${TPL}/sources/README.md.template" "${WORK}/sources/README.md"
copy_if_missing "${TPL}/assessments/README.md.template" "${WORK}/assessments/README.md"
copy_if_missing "${TPL}/progress/COMPETENCY.md.template" "${WORK}/progress/COMPETENCY.md"
copy_if_missing "${TPL}/reports/README.md.template" "${WORK}/reports/README.md"
copy_if_missing "${TPL}/standards/README.md.template" "${WORK}/standards/README.md"

for dir in context plans programs sessions consultancy sources assessments progress reports standards; do
  mkdir -p "${WORK}/${dir}"
done

echo ""
echo "--- .cursorrules ---"
if [[ -n "${BOOTSTRAP_SKIP_CURSERRULES:-}" ]]; then
  echo "skip (.cursorrules owned by caller): ${REPO_ROOT}/.cursorrules"
elif [[ -f "${REPO_ROOT}/.cursorrules" ]]; then
  echo "skip (exists): ${REPO_ROOT}/.cursorrules"
elif [[ -n "${CALLER_TRAINER_CTO_SOURCE}" ]] && [[ "${CTO_ROOT}" != "${REPO_ROOT}" ]]; then
  # Caller explicitly named a source that differs from this target: true thin-client —
  # substitute the real pointer instead of leaving the REPLACE_BASICSOURCE placeholder.
  CTO_ROOT_ESC="${CTO_ROOT//\//\\/}"
  perl -pe "s/TRAINER_CTO_SOURCE=REPLACE_BASICSOURCE/TRAINER_CTO_SOURCE=${CTO_ROOT_ESC}/" \
    "${CTO_ROOT}/templates/cursorrules.template" > "${REPO_ROOT}/.cursorrules"
  echo "created (thin-client, TRAINER_CTO_SOURCE=${CTO_ROOT}): ${REPO_ROOT}/.cursorrules"
else
  copy_if_missing "${CTO_ROOT}/templates/cursorrules.template" "${REPO_ROOT}/.cursorrules"
fi

echo ""
echo "Next: @cto-assess run · fill PROFILE.md · fill REPLACE: tokens in .cursorrules"
