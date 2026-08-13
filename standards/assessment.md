# Assessment standard

Binding for `@cto-assess`, `@cto-drill`, and `@cto-review` evidence.

## Scoring scale (1–5)

| Score | Meaning |
|-------|---------|
| 1 | Missing / harmful patterns |
| 2 | Aware but inconsistent |
| 3 | Solid baseline for role |
| 4 | Strong; coaches others |
| 5 | Exceptional / reference-level |

Do not award 4–5 without artifact evidence (memo, drill, decision log).

## What the levels mean (anchors)

A bare 1–5 invites drift: everyone scores themselves 3, and "3" means nothing six weeks later.
Score against **scope of effect** and **whether the behaviour survives pressure** — the axes
public engineering ladders converge on (see the Dropbox and Rent the Runway frameworks in
`references/core-library.md`, which level on scope, collaborative reach, and impact).

| Score | Scope of effect | Under pressure | Evidence that supports it |
|-------|-----------------|----------------|---------------------------|
| **1** | Own work only, and the pattern causes harm to others | Abandons the practice immediately | — |
| **2** | Own work; inconsistent | Drops it when the week gets hard | Self-report |
| **3** | One team, reliably | Holds under normal load; slips under crisis | One drill at pass, or one real artifact |
| **4** | Multiple teams or a function; others adopt the practice from you | Holds under crisis; you can explain *why* to someone who disagrees | Repeated artifacts across ≥2 contexts, plus evidence someone else adopted it |
| **5** | Organisation-wide, or externally recognised | You improve the practice itself, and know where it fails | Sustained artifacts plus a documented case where you changed the standard approach |

**Score movement:** a level rises on evidence, never on a session going well. Moving 3 → 4
needs a *second* context, not a better version of the same artifact. `@cto-review certify`
enforces this.

**The cap rule:** self-report alone caps every area at 3. That cap lifts per area only when a
drill artifact exists for it.

## Drill rubric (each scored 1–5)

- **Clarity** — bottom line and structure
- **Leverage** — focuses on high-impact levers
- **Risk** — names failure modes and mitigations
- **Stakeholder care** — comms fit audience
- **Learnability** — creates a feedback loop

**Pass:** average ≥3 and no dimension at 1.

### Structural failures are reported separately

Some defects are not captured by an average. A record can score 3.2 and still be structurally
broken — for instance a decision record with only two options (see `standards/decision-record.md`
for the gate list).

Report as: `PASS, avg 3.2 — structural miss: <what>, required in next attempt.`
Never let a passing average bury a structural miss, and never fail an otherwise strong artifact
solely on a structural miss — carry it forward as a hard requirement instead.

## Written feedback files

A scored drill may leave a feedback file alongside the learner's artifact: the corrected
version with every change marked (e.g. `» CORRECTION`) and the reason inline. Rules:

- The learner's original is never edited — it is the data; the feedback file is separate.
- Every change carries its reason; a corrected artifact without reasons is just a model answer.
- It ends with the concrete deltas the next attempt must show — feedback closes the loop only
  when the next artifact can be checked against it.

## Baseline assessment

Must cover six areas: Role & leverage, Org & people, Delivery & systems, Product & stakeholders,
Governance & risk, Strategy & scale.

For each area record: score, the anchor that justifies it, and the evidence type. Self-report
alone → label as self-report and apply the cap; triangulate with drills when possible.

## Re-assessment

Re-score an area only when new evidence exists. A scheduled re-assessment with no new artifacts
produces the same numbers and wastes a session — check the ledger first, and if nothing has been
produced, say that rather than re-running the questionnaire.
