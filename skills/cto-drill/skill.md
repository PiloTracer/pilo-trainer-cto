---
name: cto-drill
description: >-
  Practical CTO drills: incident, org design, roadmap cut, hire plan, board Q&A,
  vendor risk, AI governance. Writes assessments/drill-*.md.
---

# cto-drill

**Requires:** assessed recommended (`-y` to skip).

## Parse

`@cto-drill run - <type>`  
`@cto-drill list`  
`@cto-drill status`

## Drill types

| Type | Practice |
|------|----------|
| `incident` | SEV handling, comms, postmortem quality |
| `org-design` | Team topology for a constraint |
| `roadmap-cut` | Cut 40% without killing strategy |
| `hire-plan` | Role scorecard + funnel for one critical seat |
| `board-qa` | Hostile board questions |
| `vendor-risk` | Critical vendor failure / lock-in |
| `ai-governance` | AI policy decision under ambiguity |
| `tech-debt` | Debt vs feature tradeoff with numbers |

## Protocol

1. Set scenario (use PROFILE company stage; invent plausible details labeled as scenario).
2. Time-box: learner responds; professor critiques.
3. Score against the `standards/assessment.md` drill rubric (clarity, leverage, risk, stakeholder care, learnability — each 1–5). Pass: average ≥3 and no dimension at 1.
4. Write `.training.cto/assessments/drill-YYYY-MM-DD-<type>.md`.
5. Update COMPETENCY evidence if strong (score-backed, per `standards/assessment.md` — do not award 4–5 without evidence).

## drill-*.md shape

```markdown
# Drill — YYYY-MM-DD — <type>

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
```

## Rules

Drills are practice — not real instructions to harm systems. Keep scenarios realistic. Follow `standards/assessment.md` (binding) for rubric and pass bar.
