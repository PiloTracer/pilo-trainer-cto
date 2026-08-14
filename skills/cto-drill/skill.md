---
name: cto-drill
description: >-
  Practical CTO drills: incident, org design, roadmap cut, hire plan, board Q&A,
  vendor risk, AI governance. Writes assessments/drill-*.md.
---

# cto-drill

**Requires:** assessed recommended (`-y` to skip).
On failure emit the canonical BLOCKED report from `skills/SKILL_DEPENDENCIES.md`.

## Parse

`@cto-drill run - <type>`  
`@cto-drill list`  
`@cto-drill status`

## Case library first

Read `drills/case-library.md` before inventing a scenario. It holds runnable cases built on
real public incidents and decisions, each with a pre-read boundary and a time-box. Invent a
scenario only when no case fits, and say that you are doing so.

Decision-case drills are additionally bound by `standards/decision-record.md` — ≥3 options
including a genuine defer, decision drivers, and an observable reversal trigger. Fewer than
three options is a structural failure reported separately from the rubric average.

## Drill types

| Type | Practice |
|------|----------|
| `decision-case` | Architecture/strategy decision from a public already-decided case; record written before reading the outcome |
| `incident` | SEV handling, comms, postmortem quality |
| `org-design` | Team topology for a constraint |
| `roadmap-cut` | Cut 40% without killing strategy |
| `hire-plan` | Role scorecard + funnel for one critical seat |
| `board-qa` | Hostile board questions |
| `vendor-risk` | Critical vendor failure / lock-in |
| `ai-governance` | AI policy decision under ambiguity |
| `tech-debt` | Debt vs feature tradeoff with numbers |

## Protocol

1. Select a case from `drills/case-library.md`, or set a scenario using PROFILE company stage (invent plausible details, labeled as scenario). State the pre-read boundary before the learner starts. **Synthetic briefs are deliberately incomplete: tell the learner the brief omits facts on purpose, and require every deliverable to carry an "Assumptions / unknowns" block — missing facts are named as gaps, never invented.**
2. Set the difficulty dials for the learner's level in this area per `standards/level-adaptation.md` (default: mid; at most two dials), then time-box: learner responds; professor critiques.
3. Score against the `standards/assessment.md` drill rubric (clarity, leverage, risk, stakeholder care, learnability — each 1–5). Pass: average ≥3 and no dimension at 1.
4. Write `.work.cto/assessments/drill-YYYY-MM-DD-<type>.md`.
5. **Tick the task ledger** in the active `programs/<slug>/progress.md`: mark the matching drill row `done` with this file as Evidence, or bump its `Done/Total`. A failed drill stays `in-progress` — record the score, do not mark it done.
6. Update COMPETENCY evidence if strong (score-backed, per `standards/assessment.md` — do not award 4–5 without evidence).

## drill-*.md shape

```markdown
# Drill — YYYY-MM-DD — <type>
**Status:** Draft | In review | Approved | Superseded — YYYY-MM-DD
**Needs:** <one line, or nothing>

## Scenario
## Learner response
## Critique
## Rubric scores
| Dimension | Score | Notes |
|-----------|-------|-------|
| Clarity | | |
| Leverage | | |
| Risk | | |
| Stakeholder care | | |
| Learnability | | |

## Pass/fail
## Follow-up

## Next action
<one action in exact syntax — or `Next action: none — <reason>`>
```

## Rules

Drills are practice — not real instructions to harm systems. Keep scenarios realistic. Follow `standards/assessment.md` (binding) for rubric and pass bar, and report structural failures separately from the average.

Never let the learner edit a decision-case record after reading the real outcome. The gap
between the two is the entire result of the drill.

- **Operator handoff:** every response that ends a turn follows the [Operator handoff contract](../SKILL_DEPENDENCIES.md#operator-handoff-contract) — terse output; approvals under `**Needs your approval:**` citing `path:L<n>`; questions numbered under `**Needs your answer:**`; exactly one `**Next step:**` command; one line when nothing is needed (Form A). Decisions and questions never mixed; empty sections omitted.
- **Document clarity:** every generated document follows the [Document clarity contract](../SKILL_DEPENDENCIES.md#document-clarity-contract) — Status + Needs header, separate Decisions/Open questions lists, one `## Next action`, no placeholder scaffolding left behind.
