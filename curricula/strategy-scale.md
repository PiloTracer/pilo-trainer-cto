# Strategy & Scale

**Slug:** `strategy-scale`  
**Duration:** 6–8 weeks  
**Level:** CTO at growth / multi-team / M&A-adjacent

## Audience / level assumptions

- Multiple teams, where coordination cost has become the constraint
- Facing a platform investment, an acquisition, or a major vendor replacement
- Most likely failure mode on entry: scaling the org chart without scaling the decision system

## Duration & cadence

6–8 weeks, 2 sessions/week plus one async drill.

## Outcomes

- Multi-team scaling plan tied to strategy
- Platform bet with kill criteria
- Tech diligence checklist for acquire/build/partner
- Capacity model the board can understand

## Modules

### M1 — Scaling org + architecture together
- Objectives: Conway's law as a design tool; find the bottleneck that is organisational, not technical
- Drill: `org-design` — case 5, combined org and system bottleneck diagnosis
- Sources: Team Topologies key concepts — https://teamtopologies.com/key-concepts; *Accelerate*, Forsgren/Humble/Kim (Unverified page); DORA — https://dora.dev/research/
- Exit check: Names the cognitive load moved and the interaction mode for every remaining dependency

### M2 — Platform bets
- Objectives: Shared platform vs product teams; ROI and kill criteria
- Drill: Write a platform proposal with stop conditions, per `standards/decision-record.md`
- Sources: Team Topologies on platform teams — https://teamtopologies.com/key-concepts; https://itrevolution.com/articles/four-team-types/
- Exit check: Kill criteria are observable and dated; ≥3 options including not building it

### M3 — Diligence
- Objectives: Tech diligence for M&A or major vendor replace
- Drill: 90-minute diligence memo from a fictional data pack
- Sources: Public diligence checklists from reputable firms (name the specific URL at drill time — none currently verified in `references/core-library.md`, see its Gaps section)
- Exit check: Memo names the deal-breaker you would walk away over

### M4 — Capacity & portfolio
- Objectives: A capacity model a board can follow, and a strategy that declines things
- Drill: `roadmap-cut` — case 4, at portfolio rather than team scale
- Sources: `standards/metrics.md`; `standards/anti-patterns.md` § Delivery
- Exit check: Non-empty `Never` list at portfolio level

## Assessment / rubrics

| Criterion | Pass |
|-----------|------|
| Scale plan | Bottleneck named as org or system, with evidence |
| Platform bet | Kill criteria observable and dated |
| Diligence | A stated deal-breaker |
| Portfolio | Strategy names what you will *not* do |

Strategy must name what you will *not* do. Drill dimensions per `standards/assessment.md`:
average ≥3, no dimension at 1.

## Exit criteria (program complete)

Scale plan, platform memo, and a passing diligence drill; artifacts stored under
`.training.cto/` and linked from the task ledger; `@cto-review status` run with evidence paths.
