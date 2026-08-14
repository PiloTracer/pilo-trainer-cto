---
name: cto-mentor
description: >-
  Run or prepare a mentoring session against the active program. Writes session
  logs under .work.cto/sessions/<program-slug>/. Requires program-active (or -y).
---

# cto-mentor

**Requires:** program-active (waiver `-y` for ad-hoc; still write a session log).
On failure emit the canonical BLOCKED report from `skills/SKILL_DEPENDENCIES.md`.

- **Operator handoff:** every response that ends a turn follows the [Operator handoff contract](../SKILL_DEPENDENCIES.md#operator-handoff-contract) — terse output; approvals under `**Needs your approval:**` citing `path:L<n>`; questions numbered under `**Needs your answer:**`; exactly one `**Next step:**` command; one line when nothing is needed (Form A). Decisions and questions never mixed; empty sections omitted.
- **Document clarity:** every generated document follows the [Document clarity contract](../SKILL_DEPENDENCIES.md#document-clarity-contract) — Status + Needs header, separate Decisions/Open questions lists, one `## Next action`, no placeholder scaffolding left behind.

## Parse

| Invoke | Action |
|--------|--------|
| `@cto-mentor run` | Live mentoring session |
| `@cto-mentor prepare` | Prep agenda for next session |
| `@cto-mentor status` | Last session + next module |

## prepare

1. Load active PROGRAM + progress + HANDOFF + the learner's per-area levels (PROFILE + latest assessment); set scaffolding per `standards/level-adaptation.md`.
2. Write `.work.cto/sessions/<program-slug>/YYYY-MM-DD-prep-<slug>.md` with agenda, pre-read, drill, success check. Create the program subdirectory if it does not exist yet (ad-hoc sessions under `-y` use `sessions/ad-hoc/`).
3. Update NEXT.

## run

Follow `standards/mentoring.md`:

0. **Retrieval opening (5 min, closed-book).** Ask the learner to recall last session's commitment and one concept from the retrieval queue in `notes.md`, without opening notes. Then check the record together. The gap is the diagnostic.
1. Orient (goal for this session, 1 sentence).
2. Socratic diagnosis — scan `standards/anti-patterns.md` and challenge what you find, by name.
3. Teach one concept with a concrete company-shaped example, scaffolded to the learner's level per `standards/level-adaptation.md`.
4. Run or assign one drill (`@cto-drill` may be nested).
5. Commit to one decision/action; log it.
6. Write the session log to `.work.cto/sessions/<program-slug>/YYYY-MM-DD-<topic-slug>.md` (same program subdirectory as the prep; drill artifacts and feedback files for the session live alongside it).
7. **Tick the task ledger** in `programs/<slug>/progress.md`: set each deliverable this session closed to `done` with the session-log path as Evidence, bump any `Done/Total` counts, and update `Deliverables complete`. A task without an evidence path stays pending.
8. Update the **retrieval queue** in `notes.md`: add today's concept; remove anything recalled cleanly twice, at least a week apart; move anything the learner could not retrieve to the front.
9. Update COMPETENCY evidence + HANDOFF + NEXT. Score movement needs an artifact, per `standards/assessment.md`.

New work assigned mid-session (extra reading, a follow-up artifact) gets **added** to the
ledger as a pending row in the same pass — otherwise it is invisible to `@cto-review status`.

## Session log shape

```markdown
# Session — YYYY-MM-DD — <title>
**Status:** Draft | In review | Approved | Superseded — YYYY-MM-DD
**Needs:** <one line, or nothing>

## Goal
## What we covered
## Challenge / pushback
## Drill / practice
## Decisions / commitments
## Sources referenced
## Next action
```
