# Decision record standard

Binding for `@cto-drill` decision cases, `@cto-consult review`, and any decision-log
deliverable in a program.

Grounded in Michael Nygard's 2011 post
([Documenting Architecture Decisions](https://www.cognitect.com/blog/2011/11/15/documenting-architecture-decisions))
and the MADR template family at [adr.github.io](https://adr.github.io/). Nygard supplies the
five-section spine; MADR adds the fields that make a record *evaluable* — decision drivers,
a required list of considered options, and a confirmation step.

## Required sections

| # | Section | Requirement |
|---|---------|-------------|
| 1 | **Title** | A problem-solution phrase ("Use X for Y"), not a topic ("Decision about Y") |
| 2 | **Status** | `proposed` · `accepted` · `deprecated` · `superseded by <id>` |
| 3 | **Context** | The forces in tension. Value-neutral. State facts, not the preferred answer |
| 4 | **Decision drivers** | The criteria any option must satisfy. Without these, no one can check whether the chosen option actually wins |
| 5 | **Considered options** | **≥3, and at least one must be "do nothing / defer"** |
| 6 | **Decision outcome** | The chosen option and why it beats the others *on the drivers* |
| 7 | **Consequences** | Positive, negative, and neutral. A record with only upside is marketing |
| 8 | **Reversal trigger** | The observable condition that would make you undo this. See below |
| 9 | **Confirmation** | How you will know it was implemented and is working |

## The two-option failure

The single most common defect in a training ADR is presenting two options where one is
obviously worse — a straw man that manufactures a decision that was never in doubt.

Three real options, one of which is *do nothing*, forces an honest comparison. If the third
option cannot be written without embarrassment, the decision was already made and the record
is a justification, not a decision.

**Drill scoring:** fewer than three options is a structural failure. Note it explicitly and
require it in the next record, regardless of the rubric average.

## Reversal trigger

Nygard and MADR both stop at consequences. For CTO training the record must also answer:
*what would have to be true for this to be wrong?*

A usable trigger is observable and time-bound: "if p99 write latency stays above 200 ms four
weeks after cutover, we revert to the managed service." Not "if it doesn't work out."

This is where one-way and two-way door thinking lands in practice — an irreversible decision
is precisely one whose reversal trigger has no affordable remedy, and saying so in writing is
the point of the exercise.

## Rules

- **One decision per record.** Three decisions in one file is a design doc wearing a costume.
- **Numbered, never renumbered.** Stable IDs let other records and tickets link reliably.
- **Immutable once accepted.** Change of mind means a new record that supersedes the old one — never a silent edit.
- **Not back-editable in drills.** For decision-case drills the learner writes the record *before* reading the real outcome, then self-scores. Editing after reading destroys the only signal the drill produces.
- Length is a feature: most good records are 200–500 words.

## Scoring a decision record

Score the five dimensions in `standards/assessment.md`, then apply these structural gates.
A record can read well and still fail:

| Gate | Fail condition |
|------|----------------|
| Options | Fewer than 3, or no genuine do-nothing option |
| Drivers | Absent, or written after the fact to fit the choice |
| Consequences | Negatives missing or trivial |
| Reversal trigger | Absent, or not observable |
| Self-contradiction | The stated choice disagrees with the reasoning |

Report structural failures separately from the rubric average — a 3.2 average with no
reversal trigger is not the same performance as a 3.2 with one.
