# Metrics standard

Binding whenever a skill discusses engineering measurement — `@cto-consult`, `@cto-mentor`,
`@cto-drill` (`board-qa`, `roadmap-cut`), and the `delivery-systems` curriculum.

A CTO gets asked "how do we measure engineering?" by someone who has read one article. The
job is to answer without either capitulating to a benchmark or dismissing the question.

## DORA — the four keys

Delivery performance, from the [DORA research programme](https://dora.dev/research/).
Definitions per the [2024 Accelerate State of DevOps Report](https://dora.dev/research/2024/dora-report/2024-dora-accelerate-state-of-devops-report.pdf):

| Metric | Definition |
|--------|------------|
| **Deployment frequency** | How often application changes reach production |
| **Change lead time** | Time from commit to running successfully in production |
| **Change fail rate** | Share of deployments that cause a production failure needing a hotfix or rollback |
| **Failed deployment recovery time** | How long it takes to recover from a failed deployment (older material calls this MTTR) |

They factor into two groups: lead time, deployment frequency, and recovery time describe
**throughput**; change fail rate and rework rate describe **stability**. Quoting throughput
alone is the most common misuse.

A fifth metric, **reliability**, was added in 2021
([Google Cloud](https://cloud.google.com/blog/products/devops-sre/using-the-four-keys-to-measure-your-devops-performance)).

### Corrections the professor should make on sight

- **"Elite performers" is stale.** Cluster analysis in the 2022 report found only High, Medium, and Low — no Elite tier. A learner quoting 2018-era tiers as current is working from old material.
- **Change fail rate has always been the awkward one.** DORA's own analysis notes it correlates with the other three but resists being combined into a single factor. Treat a clean composite "DORA score" with suspicion.
- **These are team and system metrics.** Applied to individuals they become a performance-management weapon and stop measuring delivery.

## SPACE — productivity is not one number

From *The SPACE of Developer Productivity*, Forsgren, Storey, Maddila, Zimmermann, Houck &
Butler, ACM Queue 19(1), 2021 — https://queue.acm.org/detail.cfm?id=3454124

Five dimensions: **S**atisfaction and well-being · **P**erformance · **A**ctivity ·
**C**ommunication and collaboration · **E**fficiency and flow.

The paper's argument is that productivity cannot be reduced to a single dimension, and that
useful measurement means holding several metrics **in tension**. Practical rule: pick metrics
from at least three dimensions, and never report activity on its own.

DORA and SPACE are complementary, not competing. DORA measures delivery outcomes; SPACE
covers the wider experience, including the human dimensions DORA does not touch.

## Using metrics as a CTO

- **Pair every throughput metric with a stability metric.** Deployment frequency alone rewards shipping breakage.
- **Say what a metric cannot see.** A number offered without its blind spot invites over-trust.
- **Never rank individuals on delivery metrics.** Ask what the number would do to behaviour if someone's rating depended on it — that is the number's real specification.
- **Baseline before you target.** Measure for a quarter before promising a direction of travel.
- **Metrics diagnose, they do not explain.** They tell you something changed, never why.

## When a board asks for a single number

There isn't one, and saying so is the correct answer — but not on its own. Offer a small paired
set (one throughput, one stability, one satisfaction signal), state the blind spot in each, and
name the decision each would actually change. A board asking for one number is usually asking
whether you are in control of delivery; answer that question.
