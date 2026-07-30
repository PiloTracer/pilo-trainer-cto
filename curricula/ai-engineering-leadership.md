# AI Engineering Leadership

**Slug:** `ai-engineering-leadership`  
**Duration:** 5–6 weeks · 2 sessions/week  
**Level:** Any CTO facing AI adoption pressure — first-time or seasoned

## Audience / level assumptions

- Under pressure from a CEO, board, or market to "adopt AI" with a number attached
- Owns delivery outcomes and will be held to them regardless of tooling choices
- May or may not be shipping AI *product*; this program is about leading an engineering org
  through AI adoption, which is the more common and less discussed problem

## Outcomes (measurable)

1. Written **AI adoption position** — what you will measure, what you expect to degrade first, and the guardrail that ships before rollout
2. **Measurement plan** pairing throughput with stability, resistant to per-developer misuse
3. **Governance policy** for AI-assisted code covering review, provenance, and third-party data
4. **Vendor and dependency risk map** for the AI services delivery now relies on
5. **Board narrative** that neither over-claims nor stonewalls
6. One **decision record** on a real AI build/buy/defer choice, per `standards/decision-record.md`

## Duration & cadence

5–6 weeks, 2 sessions/week plus one async drill. Compresses to 3 weeks at 2 drills/week if a
board date forces it — outcomes 1, 2, and 5 are the non-negotiable core.

## Modules

### M1 — The amplifier premise

- **Objectives:** Establish what the evidence actually says before forming a position. DORA's 2025 research frames AI as an amplifier: it magnifies the strengths of high-performing organisations and the dysfunctions of struggling ones. The leadership question is therefore not "adopt or not" but "which do we have more of."
- **Drill:** `ai-governance` case 8 in `drills/case-library.md` — CEO wants 40 engineers on assistants next quarter with a throughput number for the board
- **Sources:** DORA 2025 State of AI-assisted Software Development — https://research.google/pubs/dora-2025-state-of-ai-assisted-software-development-report/
- **Exit check:** Written position naming one existing strength AI will amplify and one existing dysfunction it will amplify, each with evidence from your own org

### M2 — Measuring without lying

- **Objectives:** Build a measurement plan that survives contact with a board deck. Pair throughput with stability; refuse per-individual delivery metrics.
- **Drill:** `board-qa` case 7 — defend your deployment cadence to a board member holding a benchmark
- **Sources:** `standards/metrics.md`; DORA four keys — https://dora.dev/research/; *The SPACE of Developer Productivity* — https://queue.acm.org/detail.cfm?id=3454124
- **Exit check:** Plan names metrics from ≥3 SPACE dimensions, pairs every throughput metric with a stability metric, and states one blind spot per metric

### M3 — Governance of AI-assisted code

- **Objectives:** Review policy, provenance and licensing, data leaving the building, and who is accountable when generated code fails
- **Drill:** Write the one-page policy; the professor attacks it with three plausible incidents
- **Sources:** NIST CSF 2.0 Govern function — https://doi.org/10.6028/nist.cswp.29
- **Exit check:** Policy answers who reviews, what may not be sent to a third party, and who is accountable — in that order, without deferring to "the team decides"

### M4 — Dependency and vendor risk

- **Objectives:** Map the AI services delivery now depends on; price the switch; decide what must stay portable
- **Drill:** `vendor-risk` — your primary model provider changes terms or degrades with 30 days' notice
- **Sources:** NIST CSF 2.0 supply-chain risk (GV.SC); `standards/anti-patterns.md` § Governance and risk
- **Exit check:** Map names each critical dependency, the switching cost, and one dependency you have deliberately accepted as unhedged, with the reason

### M5 — The board narrative

- **Objectives:** Communicate AI posture to non-technical stakeholders without over-claiming or stonewalling
- **Drill:** One-page board update on AI adoption including something that is going badly
- **Sources:** `standards/anti-patterns.md` § Stakeholders
- **Exit rubric:** BLUF, ≤3 decisions, ≤2 risks, one ask; bad news in the first line; no benchmark quoted without its caveat

## Assessment / rubrics

| Criterion | Pass |
|-----------|------|
| Position quality | Names a specific dysfunction AI will amplify in *your* org, not in general |
| Measurement | Throughput paired with stability; no per-individual delivery metric |
| Governance | Accountability named before tooling |
| Risk map | At least one unhedged dependency stated openly with a reason |
| Board narrative | Forces a decision; bad news leads |
| Decision record | ≥3 options with a genuine defer option; reversal trigger present |

Drill dimensions per `standards/assessment.md`: clarity, leverage, risk, stakeholder care,
learnability — average ≥3, no dimension at 1.

## Exit criteria (program complete)

All module exit checks met; the six outcome artifacts stored under `.training.cto/` and linked
from the task ledger; `@cto-review status` run with evidence paths cited.

## Note on freshness

This is the fastest-moving area in the catalog. `@cto-update run` should re-check the DORA
report generation and any vendor-specific claims before the program is installed — an AI
curriculum citing two-year-old research teaches the wrong reflex about currency.
