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
| `@deploy-basic update` | re-sync pointer + merge candidates |

## Protocol

1. Validate target exists; source has `templates/cursorrules.template` + `skills/`.
2. Run `scripts/deploy-basic.sh` (agent may invoke shell directly).
3. Report pointer value, `.training.cto/` presence, next steps.
4. If target already has Agent OS `.cursorrules` without `TRAINER_CTO_SOURCE`, **do not clobber** — merge Source-resolution + CTO skills table + professor Identity section.

## Local surface only

`.cursorrules`, `.training.cto/**` — never create local `.ai.cto/` in thin mode.
