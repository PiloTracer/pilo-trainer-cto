# Delivery & Systems

**Slug:** `delivery-systems`  
**Duration:** 6–8 weeks · 2 sessions/week  
**Level:** Any CTO owning delivery outcomes

## Audience / level assumptions

- Accountable for what ships and whether it stays up
- Has, or is expected to produce, delivery numbers for someone non-technical
- Team large enough that delivery is a system property, not a personal output

## Outcomes (measurable)

1. Roadmap that survives a 40% cut, with a non-empty `Never` list
2. Decision record for one live architecture bet, meeting `standards/decision-record.md`
3. Reliability ownership model with an SLO and a named owner
4. Tech debt policy framed in money and time, not virtue
5. Delivery measurement plan pairing throughput with stability

## Duration & cadence

6–8 weeks, 2 sessions/week plus one async drill.

## Modules

### M1 — Roadmap integrity

- **Objectives:** Cut without destroying strategy; make declining explicit
- **Drill:** `roadmap-cut` — case 4 in `drills/case-library.md`
- **Sources:** *Inspired*, Marty Cagan (Unverified page); ThoughtWorks Technology Radar — https://www.thoughtworks.com/radar
- **Exit check:** `Never` column non-empty, each entry with one sentence on what is being accepted

### M2 — Architecture tradeoffs

- **Objectives:** Options under uncertainty, irreversible choices, migration cost
- **Drill:** `decision-case` — case 1. Write the record before reading the real outcome
- **Sources:** Nygard, "Documenting Architecture Decisions" — https://www.cognitect.com/blog/2011/11/15/documenting-architecture-decisions; templates at https://adr.github.io/; `standards/decision-record.md`
- **Exit check:** ≥3 options including a genuine defer; drivers stated before the choice; observable reversal trigger

### M3 — Reliability

- **Objectives:** SLO thinking, on-call load, blameless analysis
- **Drill:** `incident` — case 2, postmortem authorship from a timeline-only writeup
- **Sources:** Google *SRE* book, ch. 15 Postmortem Culture and ch. 16 On-call — https://sre.google/sre-book/table-of-contents/; Dan Luu, "Reading postmortems" — http://danluu.com/postmortem-lessons/; corpus at https://github.com/danluu/post-mortems/
- **Exit check:** ≥3 contributing factors, none labelled "human error"; ≤2 system fixes each with an owner and a would-have-prevented sentence

### M4 — Measuring delivery

- **Objectives:** Use the four keys honestly; resist the single-number request
- **Drill:** `board-qa` — case 7, defend your cadence to a board member holding a benchmark
- **Sources:** `standards/metrics.md`; DORA — https://dora.dev/research/; *The SPACE of Developer Productivity* — https://queue.acm.org/detail.cfm?id=3454124
- **Exit check:** Every throughput metric paired with a stability metric; one blind spot named per metric; no per-individual delivery metric proposed

### M5 — Tech debt

- **Objectives:** Price debt; refuse the rewrite fantasy
- **Drill:** `tech-debt` — quantify cost of delay against rewrite cost
- **Sources:** `standards/anti-patterns.md` § Delivery
- **Exit check:** A monthly cost in money or engineer-time, and one debt item explicitly accepted

## Assessment / rubrics

| Criterion | Pass |
|-----------|------|
| Roadmap | Prioritised; `Never` non-empty; risks honest |
| Decision record | Passes every gate in `standards/decision-record.md` |
| Postmortem | Blameless; system-level fixes with owners |
| Metrics | Throughput paired with stability; blind spots named |
| Debt | Economics stated; no rewrite without numbers |

Drill dimensions per `standards/assessment.md`: clarity, leverage, risk, stakeholder care,
learnability — average ≥3, no dimension at 1.

## Exit criteria (program complete)

All module exit checks met; artifacts stored under `.training.cto/` and linked from the task
ledger; `@cto-review status` run with evidence paths cited.
