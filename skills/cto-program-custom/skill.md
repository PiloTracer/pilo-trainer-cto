---
name: cto-program-custom
description: >-
  Design a bespoke CTO training program from a special request. Confirm gate
  unless -y. Writes PROGRAM.md under .training.cto/programs/<slug>/.
---

# cto-program-custom

**Requires:** profile-ready.

## Parse

`@cto-program-custom - <request>`  
Flags: `-y` skip confirm · `--dry-run` plan only

## Protocol

1. Load PROFILE + baseline assessment (if missing, recommend `@cto-assess run` first; proceed with `-y` only if waived).
2. Probe max 3 questions if duration, level, or success criteria unclear.
3. Draft program SPEC (see standards/program-spec.md).
4. **Confirm** with learner unless `-y`.
5. Slugify title → `.training.cto/programs/<slug>/PROGRAM.md` + `progress.md` + `notes.md`.
6. Mark program-active; update HANDOFF/NEXT; optionally chain `@cto-sources curate`.

## PROGRAM.md minimum

- Outcomes (measurable)
- Audience / level assumptions
- Duration & cadence
- Modules (objectives, drills, sources)
- Assessment rubrics
- Exit criteria

## Quality bar

Prefer fewer modules with hard drills over encyclopedic outlines. Align to learner constraint in PROFILE.
