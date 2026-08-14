---
name: cto-program-custom
description: >-
  Design a bespoke CTO training program from a special request. Confirm gate
  unless -y. Writes PROGRAM.md under .work.cto/programs/<slug>/.
---

# cto-program-custom

**Requires:** profile-ready.
On failure emit the canonical BLOCKED report from `skills/SKILL_DEPENDENCIES.md`.

## Parse

`@cto-program-custom - <request>`  
Flags: `-y` skip confirm · `--dry-run` plan only

## Protocol

1. Load PROFILE + baseline assessment (if missing, recommend `@cto-assess run` first; proceed with `-y` only if waived).
2. Probe max 3 questions if duration, level, or success criteria unclear.
3. Draft program SPEC (see standards/program-spec.md).
4. **Confirm** with learner unless `-y`.
5. Slugify title → `.work.cto/programs/<slug>/PROGRAM.md` + `progress.md` + `notes.md`. Create `.work.cto/sessions/<slug>/` — session logs for this program live there, per `standards/mentoring.md`.
6. Seed the `progress.md` **task ledger** from `templates/training/programs/progress.md.template` — one row per drill, per source work, and per exit-check item, with counted items (e.g. "≥3 ADRs") as a single `0/3` row. See `@cto-program-standard` § *Seeding the task ledger* (same binding rules). Create `notes.md` from `templates/training/programs/notes.md.template` so the retrieval queue exists from day one.
7. Seed `.work.cto/sources/README.md` from the program's `Sources:` lines (`Status: assigned`), per `standards/citation.md`.
8. Mark program-active; update HANDOFF/NEXT; optionally chain `@cto-sources curate`.

## PROGRAM.md minimum

- Outcomes (measurable)
- Audience / level assumptions
- Duration & cadence
- Modules (objectives, drills, sources)
- Assessment rubrics
- Exit criteria
- Header: Status line (`Draft`/`In review`/`Approved`/`Superseded` + date) + one-line Needs
- `## Next action` — one action in exact syntax, or `none — <reason>`

## Quality bar

Prefer fewer modules with hard drills over encyclopedic outlines. Align to learner constraint in PROFILE.

- **Operator handoff:** every response that ends a turn follows the [Operator handoff contract](../SKILL_DEPENDENCIES.md#operator-handoff-contract) — terse output; approvals under `**Needs your approval:**` citing `path:L<n>`; questions numbered under `**Needs your answer:**`; exactly one `**Next step:**` command; one line when nothing is needed (Form A). Decisions and questions never mixed; empty sections omitted.
- **Document clarity:** every generated document follows the [Document clarity contract](../SKILL_DEPENDENCIES.md#document-clarity-contract) — Status + Needs header, separate Decisions/Open questions lists, one `## Next action`, no placeholder scaffolding left behind.
