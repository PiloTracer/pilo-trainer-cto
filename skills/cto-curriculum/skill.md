---
name: cto-curriculum
description: >-
  Design or refine curriculum modules, sequencing, outcomes, and drills for
  an active or draft program under .training.cto/programs/.
---

# cto-curriculum

## Parse

| Invoke | Action |
|--------|--------|
| `@cto-curriculum design - <topic>` | New module set (needs profile-ready) |
| `@cto-curriculum refine - <slug>` | Improve existing PROGRAM.md (needs program-active) |
| `@cto-curriculum status` | Summarize active program structure |

## design

Produce a module plan; if no program folder yet, create draft under `programs/<slug>/` or hand off to `@cto-program-custom` for full SPEC.

## refine

1. Load `programs/<slug>/PROGRAM.md`.
2. Fix sequencing, prune fluff, strengthen drills, align sources.
3. Write changes; note delta in `notes.md`.

## Rules

Follow `standards/program-spec.md`. Cite public sources honestly via `@cto-sources` patterns.
