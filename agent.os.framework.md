# CTO Professor OS — framework source marker

This file marks the repository root as the **CTO Professor OS framework source repo** (self-hosted `.ai.cto`).

- **Detection:** `@cto-session` treats a repo as the self-hosted framework source when `skills/cto-session/skill.md` exists at the repo root (see `skills/cto-session/skill.md` § Repo mode). This marker is documentary; no script or skill reads it.
- **Never modify:** this file is a protected surface (`.cursorrules` § Protected Files). Its content is fixed; do not edit, rename, or delete it.
- **Never deployed:** `scripts/deploy-files.sh` excludes it from fat-client vendoring; `deploy-basic` never writes root files. It must never appear in a consumer project.
