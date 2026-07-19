---
name: deploy-basic
description: >-
  Thin-client bootstrap of CTO Professor OS into a target. Copies .cursorrules
  (TRAINER_CTO_SOURCE pointer) + .training.cto/ skeleton. Skills stay in source.
  Modes: default outbound, update, status. Never modifies the source.
---

# deploy-basic

**Shell:** `bash <source>/scripts/deploy-basic.sh <target-path> [--update|--force]`  
**Status:** `bash <source>/scripts/deploy-basic.sh --status [target-path]`

## Parse invocation

| User says | Mode |
|-----------|------|
| `@deploy-basic - /path/to/target` | outbound thin bootstrap |
| `@deploy-basic status` | read-only report |
| `@deploy-basic - /path/to/target --update` | re-sync pointer + merge candidates (target path always required, `--` prefix on the flag) |

## Protocol

1. **Target directory must already exist** (`mkdir -p` and, if it should be a repo, `git init` — done by the user or agent *before* this skill runs). This skill never creates the target repo itself; it only scaffolds the CTO Professor OS layer into an existing directory. If missing, stop and say so rather than erroring opaquely.
2. Validate source has `templates/cursorrules.template` + `skills/`.
3. Run `scripts/deploy-basic.sh <target-path> [--update|--force]` (agent may invoke shell directly).
4. Report pointer value, `.training.cto/` presence, next steps.
5. If target already has Agent OS `.cursorrules` without `TRAINER_CTO_SOURCE`, **do not clobber** — merge Source-resolution + CTO skills table + professor Identity section.

## New target repo, start to finish

`@deploy-basic` is the complete, from-scratch path (the source session already knows its own path; a freshly-opened target-repo session does not). For a brand-new project: create the repo (`mkdir` + `git init`) → run `@deploy-basic - /path/to/new-repo` from **this** source chat → open the target repo and continue with `@session-cto start`. Running `@cto-bootstrap init` standalone inside the target instead only works if you pass the source explicitly (`@cto-bootstrap init - <source-path>`) or a `.cursorrules` pointer already exists there.

## Local surface only

`.cursorrules`, `.training.cto/**` — never create local `.ai.cto/` in thin mode.
