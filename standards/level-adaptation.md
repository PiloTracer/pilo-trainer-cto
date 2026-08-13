# Level adaptation standard

Binding for `@cto-mentor` and `@cto-drill`. Teaching the same material to a beginner and
to an advanced learner with the same scaffolding fails both: the beginner drowns, the
advanced learner is bored and games the drill.

## The rule that does not move

**The pass bar never changes with level. Scaffolding does.** A beginner's artifact and an
advanced learner's artifact are graded on the same rubric (`standards/assessment.md`) and
the same structural gates. What changes is how much support the learner gets before and
during the attempt. Lowering the bar for a beginner produces a pass that means nothing;
raising it for an advanced learner produces games, not growth.

## Level determination

Level is **per competency area, not global** — read it from the baseline assessment and
`progress/COMPETENCY.md`, never from job title. A seasoned architect can be a beginner in
exec communication and advanced in delivery; the session adapts per area, not per person.

| Level | Anchor evidence |
|-------|-----------------|
| Beginner | Area scored 1–2, or no artifact exists for the area yet |
| Mid | Area scored 3 — one drill at pass or one real artifact |
| Advanced | Area scored 4–5 — repeated artifacts across ≥2 contexts |

## Scaffolding gradient

| Lever | Beginner | Mid | Advanced |
|-------|----------|-----|----------|
| Worked example | Studied first, side by side during the drill | Available on request | None — the structure is part of the test |
| Template | Provided, partially filled | Provided blank | None — the learner picks the format and defends the choice |
| Vocabulary | `references/glossary.md` terms front-loaded in the prep | Defined on first use | Assumed |
| Time-box | Standard +50% | Standard | Compressed (−25 to −50%) |
| Brief completeness | Gaps flagged together after the attempt | Learner surfaces gaps (Assumptions / unknowns block) | Gaps plus injected pressure (hostile stakeholder, mid-drill requirement change) |
| Session pace | One concept, shorter blocks | Standard session structure | Learner drives the agenda; the professor interrupts |
| Feedback | Professor writes the feedback file | Professor feedback; learner restates the deltas in their own words | Learner writes the self-critique; the professor reviews the critique |

## Difficulty dials (drills)

Set before the time-box starts; the default is mid. Combine **at most two** dials per
drill — more is hazing, not training.

1. **Time** — compress the box.
2. **Information** — withhold more of the brief; the Assumptions / unknowns block must carry it.
3. **Pressure** — inject a stakeholder who pushes back mid-drill (a board member, a furious VP Sales).
4. **Autonomy** — remove the template; the learner chooses the artifact's format and defends it.

## Misconception protocol

When the learner states a wrong model (e.g. "100% sprint completion is the goal"):

1. **Correct it immediately**, with the correct model and the why — never let it pass to
   keep the session pleasant.
2. **Log it** as a `re-teach` row in the program's retrieval queue (`notes.md`).
3. **Verify unaided recall** at the next session's retrieval opening. Two clean recalls at
   least a week apart retire it.

A misconception corrected once and never re-asked was not corrected — it was mentioned.

## Teach-back (advanced)

For areas scored 4+, the direction reverses: the learner teaches the concept as if to a
report, or writes the feedback file for a synthetic weaker attempt. Scored on the same
rubric. A concept the learner cannot teach is not held at 4 — drop the area to 3 and
re-drill, per the `standards/assessment.md` anchors (4 requires explaining *why* to
someone who disagrees).
