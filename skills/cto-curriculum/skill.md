---
name: cto-curriculum
description: >-
  Design or refine curriculum modules, sequencing, outcomes, and drills for
  an active or draft program under .work.cto/programs/.
---

# cto-curriculum

**Requires:** profile-ready for `design`; program-active for `refine` (waiver `-y`, logged in HANDOFF).

On failure emit the canonical BLOCKED report from `skills/SKILL_DEPENDENCIES.md`.

## Parse

| Invoke | Action |
|--------|--------|
| `@cto-curriculum design - <topic>` | New module set (needs profile-ready) |
| `@cto-curriculum refine - <slug>` | Improve existing PROGRAM.md (needs program-active) |
| `@cto-curriculum status` | Summarize active program structure |

## design

Produce a module plan following `standards/program-spec.md`'s required sections (outcomes, audience/level, duration, modules with drill + sources + exit check, assessment rubrics, exit criteria).

**Output:** `.work.cto/programs/<slug>/PROGRAM.md` with every SPEC section present, stubbed where unknown — never a plan that exists only in chat. If the scope is a full program rather than a module set, hand off to `@cto-program-custom` instead of half-building one here.

Seed `progress.md` and `notes.md` from their templates alongside it, per `@cto-program-standard` § *Seeding the task ledger*. A program folder without a ledger is invisible to `@cto-review status`. Create `.work.cto/sessions/<slug>/` alongside the program folder — session logs for the program live there, per `standards/mentoring.md`.

## refine

1. Load `programs/<slug>/PROGRAM.md`.
2. Fix sequencing, prune fluff, strengthen drills, align sources.
3. Write changes; record the delta in `notes.md` § *Deltas* with the date and the reason.
4. **Re-sync the task ledger** in `progress.md`: add rows for new drills, sources, and exit-check items; move rows whose premise you deferred into the Deferred table with the unblocking condition. Never silently drop a row a learner has already partly completed.

## Rules

Follow `standards/program-spec.md`. Cite public sources honestly via `@cto-sources` patterns, drawing from `references/core-library.md` first.

Refining a module never rewrites completed history — a module split creates new rows, it does not erase evidence already filed against the old ones.

- **Operator handoff:** every response that ends a turn follows the [Operator handoff contract](../SKILL_DEPENDENCIES.md#operator-handoff-contract) — terse output; approvals under `**Needs your approval:**` citing `path:L<n>`; questions numbered under `**Needs your answer:**`; exactly one `**Next step:**` command; one line when nothing is needed (Form A). Decisions and questions never mixed; empty sections omitted.
- **Document clarity:** every generated document follows the [Document clarity contract](../SKILL_DEPENDENCIES.md#document-clarity-contract) — Status + Needs header, separate Decisions/Open questions lists, one `## Next action`, no placeholder scaffolding left behind.
