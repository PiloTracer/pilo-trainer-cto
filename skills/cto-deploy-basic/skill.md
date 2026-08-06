---
name: cto-deploy-basic
description: >-
  Thin-client bootstrap of CTO Professor OS into a target. Copies .cursorrules
  (TRAINER_CTO_SOURCE pointer) + .work.cto/ skeleton. Skills stay in source.
  Modes: default outbound, update, status. Never modifies the source.
---

# cto-deploy-basic

**Shell:** `bash <source>/scripts/deploy-basic.sh <target-path> [--update|--force]`  
**Status:** `bash <source>/scripts/deploy-basic.sh --status [target-path]`

## Parse invocation

| User says | Mode |
|-----------|------|
| `@cto-deploy-basic - /path/to/target` | outbound thin bootstrap |
| `@cto-deploy-basic status` | read-only report |
| `@cto-deploy-basic - /path/to/target --update` | re-sync pointer + merge candidates (target path always required, `--` prefix on the flag) |

## Protocol

1. **Target directory must already exist** (`mkdir -p` and, if it should be a repo, `git init` — done by the user or agent *before* this skill runs). This skill never creates the target repo itself; it only scaffolds the CTO Professor OS layer into an existing directory. If missing, stop and say so rather than erroring opaquely.
2. Validate source has `templates/cursorrules.template` + `skills/`.
3. Run `scripts/deploy-basic.sh <target-path> [--update|--force]` (agent may invoke shell directly).
4. Report pointer value, `.work.cto/` presence, next steps.
5. If target already has Agent OS `.cursorrules` without `TRAINER_CTO_SOURCE`, **do not clobber** — merge Source-resolution + CTO skills table + professor Identity section.

## New target repo, start to finish

`@cto-deploy-basic` is the complete, from-scratch path (the source session already knows its own path; a freshly-opened target-repo session does not). For a brand-new project: create the repo (`mkdir` + `git init`) → run `@cto-deploy-basic - /path/to/new-repo` from **this** source chat → open the target repo and continue with `@cto-session start`. Running `@cto-bootstrap init` standalone inside the target instead only works if you pass the source explicitly (`@cto-bootstrap init - <source-path>`) or a `.cursorrules` pointer already exists there.

## Local surface only

`.cursorrules`, `.work.cto/**` — never create local `.ai.cto/` in thin mode.
