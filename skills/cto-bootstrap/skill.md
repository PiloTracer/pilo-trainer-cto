---
name: cto-bootstrap
description: >-
  Scaffold .training.cto/ learner memory and drive PROFILE intake.
  Modes: init, status. Marks profile-ready when required PROFILE fields are filled.
---

# cto-bootstrap

## Parse

| Invoke | Action |
|--------|--------|
| `@cto-bootstrap init` | Run bootstrap + PROFILE interview |
| `@cto-bootstrap status` | Report scaffold + profile-ready |

## I0 — Pre-checks

- Resolve framework root (self-hosted / `$TRAINER_CTO_SOURCE` / `.ai.cto/`).
- Target project root = parent of memory (repo with `.training.cto` or cwd).

## I1 — init

1. Run `bash <framework>/templates/bootstrap.sh` with `REPO_ROOT` set (no-overwrite).
2. Read `{PROFILE}`. If REPLACE tokens remain for Name, Role, Level, Primary goal — interview (max 6 questions) and write answers.
3. Update `{HANDOFF}` and `{NEXT}`: next = `@cto-assess run`.
4. Report: paths created, profile-ready yes/no.

## I2 — status

Report existence of `.training.cto/`, PROFILE completeness, readiness state.

## Completion

Artifacts only under `.training.cto/`. Do not invent company facts.
