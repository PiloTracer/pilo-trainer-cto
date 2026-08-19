---
name: cto-deploy-basic
description: >-
  Thin-client bootstrap of CTO Professor OS into a target. Copies .cursorrules
  (TRAINER_CTO_SOURCE pointer) + .work.cto/ skeleton. Skills stay in source.
  Modes: default outbound, update, status. Never modifies the source.
---

# cto-deploy-basic

**Shell:** `bash <source>/scripts/deploy-basic.sh <target-path> [update|--update|force|--force]`  
**Status:** `bash <source>/scripts/deploy-basic.sh status [target-path]`  
**Verify:** `bash <source>/scripts/deploy-basic.sh verify [target-path]`

**Flag equivalence:** modes and flags work with or without the `--` prefix — `<path> update` is identical to `<path> --update`, `status` to `--status`.

- **Operator handoff:** every response that ends a turn follows the [Operator handoff contract](../SKILL_DEPENDENCIES.md#operator-handoff-contract) — terse output; approvals under `**Needs your approval:**` citing `path:L<n>`; questions numbered under `**Needs your answer:**`; exactly one `**Next step:**` command; one line when nothing is needed (Form A). Decisions and questions never mixed; empty sections omitted.

## Parse invocation

| User says | Mode |
|-----------|------|
| `@cto-deploy-basic - /path/to/target` | outbound thin bootstrap |
| `@cto-deploy-basic status` | read-only quick report |
| `@cto-deploy-basic verify - /path/to/target` | deep wiring audit of the target's `.cursorrules` (pointer, REPLACE tokens, sister frameworks, `.work.cto/`) |
| `@cto-deploy-basic - /path/to/target update` | re-sync pointer + merge candidates (target path always required; `--update` is the same thing) |

## Protocol

1. **Target directory must already exist** (`mkdir -p` and, if it should be a repo, `git init` — done by the user or agent *before* this skill runs). This skill never creates the target repo itself; it only scaffolds the CTO Professor OS layer into an existing directory. If missing, stop and say so rather than erroring opaquely.
2. Validate source has `templates/cursorrules.template` + `skills/`.
3. Run `scripts/deploy-basic.sh <target-path> [update|force]` (agent may invoke shell directly).
4. **Verification is automatic:** every deploy/update ends with `scripts/verify-target.sh`, which audits the target's `.cursorrules` — `TRAINER_CTO_SOURCE` set + reachable + matching the current source location, remaining `REPLACE:` tokens, sister-framework discovery (the six `.ai.<fw>` slots — legacy + family naming — plus the Agent OS anchor `.ai` / `pilo.ai.logicbison`), and the `.work.cto/` skeleton. FAIL items abort the deploy with exit 1; WARN items (e.g. unfilled `REPLACE:PROJECT_NAME`) are reported for the operator.
5. Report pointer value, `.work.cto/` presence, verify result, next steps.
6. If target already has Agent OS `.cursorrules` without `TRAINER_CTO_SOURCE`, **do not clobber** — merge Source-resolution + CTO skills table + professor Identity section, then re-run `verify`.

## New target repo, start to finish

`@cto-deploy-basic` is the complete, from-scratch path (the source session already knows its own path; a freshly-opened target-repo session does not). For a brand-new project: create the repo (`mkdir` + `git init`) → run `@cto-deploy-basic - /path/to/new-repo` from **this** source chat → open the target repo and continue with `@cto-session start`. Running `@cto-bootstrap init` standalone inside the target instead only works if you pass the source explicitly (`@cto-bootstrap init - <source-path>`) or a `.cursorrules` pointer already exists there.

## Local surface only

`.cursorrules`, `.work.cto/**` — never create local `.ai.cto/` in thin mode.
