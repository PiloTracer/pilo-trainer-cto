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
| `@cto-bootstrap init` | Run bootstrap + PROFILE interview (thin-client pointer only if one is already resolvable — see I0) |
| `@cto-bootstrap init - <source-path>` | Same, explicitly naming the trainer-cto source — required for a **brand-new** thin-client target with no existing `.cursorrules` |
| `@cto-bootstrap status` | Report scaffold + profile-ready |

## I0 — Pre-checks

- Resolve framework root, in order: explicit `<source-path>` arg → existing `.cursorrules`' `$TRAINER_CTO_SOURCE` → self-hosted (this repo is the framework) → local `.ai.cto/`.
- Target project root = parent of memory (repo with `.training.cto` or cwd).
- **Standalone-init limitation:** a fresh target repo with no `.cursorrules` yet and no `<source-path>` arg has no way to discover the trainer-cto source (no file to read it from). In that case `init` can only self-host or leave the thin-client pointer as `REPLACE_BASICSOURCE` — it cannot fully wire a thin-client target on its own. Tell the user to either pass `@cto-bootstrap init - <source-path>`, or run `@deploy-basic` from the source repo instead (that command already knows its own path).
- **Explicit-intent guard:** only run `init` on an explicit request to create/initialize a training project (a new project, or "set up my profile/training"). Do not self-trigger `init` just because `{PROFILE}` still has `REPLACE:` tokens, because a routing table suggests it, or because this looks like a fresh `.training.cto/` — those are necessary conditions, not sufficient ones. If invoked ambiguously while the same session is doing framework-dev work (editing `skills/`, `curricula/`, `standards/`, `templates/`, `scripts/`), ask for explicit confirmation before writing PROFILE or running the interview.

## I1 — init

1. If a `<source-path>` arg was given, resolve and pass it through as `TRAINER_CTO_SOURCE` when invoking bootstrap; otherwise resolve per I0.
2. Run `bash <framework>/templates/bootstrap.sh` with `REPO_ROOT` set (and `TRAINER_CTO_SOURCE` set when resolved to a real, different-from-target source — the script substitutes the pointer into a freshly-written `.cursorrules` in that case; no-overwrite otherwise).
3. Read `{PROFILE}`. If REPLACE tokens remain for Name, Role, Level, Primary goal — interview (max 6 questions) and write answers.
4. Update `{HANDOFF}` and `{NEXT}`: next = `@cto-assess run`.
5. Report: paths created, `.cursorrules` `TRAINER_CTO_SOURCE` state, profile-ready yes/no.

## I2 — status

Report existence of `.training.cto/`, PROFILE completeness, readiness state.

## Completion

Artifacts only under `.training.cto/`. Do not invent company facts.
