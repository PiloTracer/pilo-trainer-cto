---
name: cto-assess
description: >-
  Diagnostic assessment of CTO level, gaps, and learning style. Writes
  assessments/baseline.md and updates competency map. Unlocks assessed.
---

# cto-assess

**Requires:** profile-ready (or `-y` waiver logged in HANDOFF).

## Parse

| Invoke | Action |
|--------|--------|
| `@cto-assess run` | Full diagnostic |
| `@cto-assess status` | Summarize latest baseline |

## run

1. Load `{PROFILE}` and prior assessments.
2. Interview / analyze across six areas (1–5): Role & leverage, Org & people, Delivery & systems, Product & stakeholders, Governance & risk, Strategy & scale. Follow `standards/assessment.md`'s scoring scale — do not award 4–5 without artifact evidence (memo, drill, decision log); label self-report-only scores as self-report. Probe efficiently: at most ~2 questions per area, prefer existing artifacts over lengthy interviews.
3. Identify top 3 gaps and recommended catalog slug(s) or custom program thesis.
4. Write `.training.cto/assessments/baseline.md` with scores, evidence, recommendations.
5. Update `.training.cto/progress/COMPETENCY.md` baselines.
6. Update PROFILE readiness → `assessed`; NEXT → program install/design.

## baseline.md shape

```markdown
# Baseline assessment — YYYY-MM-DD

## Scores
| Area | Score | Evidence |
...

## Top gaps
1. ...

## Recommended programs
- standard: <slug> OR custom: <thesis>

## Learning style
- ...
```

## Rules

Follow `standards/assessment.md` (binding). Do not inflate scores. Mark unverified self-reports clearly.
