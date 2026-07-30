# Case library

Each entry gives the drill type, where to find the material, the **pre-read boundary** (stop
reading here), and what the drill is really testing.

Sources indexed in `references/core-library.md`. The two public corpora that feed most of
these are [danluu/post-mortems](https://github.com/danluu/post-mortems/) and
[awesome-tech-postmortems](https://github.com/snakescott/awesome-tech-postmortems).

---

## 1. Decision-case ADR — from a public architecture decision

**Type:** `decision-case` · **Time-box:** 45 min write, 15 min self-score

Pick an architecture decision a company has written up publicly — a datastore migration, a
monolith split, a build-vs-buy reversal. Engineering blogs of companies that publish
retrospectives are the usual supply.

**Pre-read boundary:** the problem statement and constraints. Stop before the section where
they say what they chose.

**Testing:** whether you can generate a third option under time pressure. Most people find
two and stop, which is the failure `standards/decision-record.md` exists to catch.

**Scoring note:** compare *reasoning quality*, not agreement. Reaching a different conclusion
than the real team is fine and often correct given different constraints. Reaching the same
conclusion for weaker reasons is worse than it looks.

---

## 2. Postmortem authorship — from a timeline-only incident

**Type:** `incident` · **Time-box:** 60 min

Take an incident writeup from the danluu corpus. GitHub's availability reports are unusually
good for this — for example the DNS outage caused by a Puppet manifest restarting only the
authoritative nameserver, where incident response then rebuilt a zone file from a provisioning
API that itself depended on DNS.

**Pre-read boundary:** the timeline and impact. Stop before contributing factors and remedies.

**Requirements:** ≥3 contributing factors, **none labelled "human error"**, and ≤2
system-level fixes, each with an owner and a sentence stating what it would have prevented.

**Testing:** blameless analysis under the temptation of an obvious scapegoat. Dan Luu's
["Reading postmortems"](http://danluu.com/postmortem-lessons/) is the pre-read that makes this
land — configuration changes, not code bugs, dominate the worst public outages, and most
organisations still do not stage config the way they stage code.

---

## 3. Config-change blast radius

**Type:** `incident` · **Time-box:** 30 min · **Synthetic scenario, real pattern**

Your team ships a config change to production databases that alters how hosts answer
health-check pings. The routing layer marks the read endpoint unhealthy and site-wide reads
fail. (Pattern drawn from GitHub's August 2024 availability report; a config change broke
health-check responses and reads were down until it was reverted.)

**Prompt:** you have 10 minutes of incident and no confirmed cause. Write the first customer
comms, the internal escalation, and the one question you ask that most narrows the space.

**Testing:** whether "what changed recently" is your first instinct, and whether you can
communicate honestly before you know the cause.

---

## 4. Now / next / never triage

**Type:** `roadmap-cut` · **Time-box:** 45 min

Use the [ThoughtWorks Technology Radar](https://www.thoughtworks.com/radar) as an input set,
or a real backlog with names removed.

**Requirements:** explicit money, team, and deadline constraints stated up front. **`Never`
must be non-empty**, and each `Never` needs one sentence on what you are accepting by not
doing it.

**Testing:** whether you can decline in writing. An empty `Never` column means the exercise
was deferred, not completed.

---

## 5. Team topology redesign

**Type:** `org-design` · **Time-box:** 45 min

Pre-read: [Team Topologies key concepts](https://teamtopologies.com/key-concepts) or the free
[IT Revolution summary](https://itrevolution.com/articles/four-team-types/).

**Prompt:** a 25-engineer org where one stream-aligned team owns three unrelated domains plus
the deploy pipeline. Reassign into the four team types and name the interaction modes between
them.

**Requirements:** every team maps to exactly one of the four types; each dependency is labelled
collaboration, X-as-a-Service, or facilitation; state explicitly which cognitive load you moved
and to whom.

**Testing:** whether you reduce load or merely redraw the chart. Renaming teams without moving
responsibility is the standard failure.

---

## 6. CEO update under bad news

**Type:** `board-qa` · **Time-box:** 25 min · **Synthetic**

The migration slipped a second time. You have one page.

**Requirements:** BLUF, ≤3 decisions you need from the CEO, ≤2 risks, exactly one ask.
No status theatre — if the page does not force a decision, it failed.

**Testing:** whether you lead with the bad news. Burying it in paragraph four is the tell.

---

## 7. Delivery metrics under interrogation

**Type:** `board-qa` · **Time-box:** 30 min

Pre-read: `standards/metrics.md`.

**Prompt:** a board member read that elite teams deploy many times a day and asks why you
deploy weekly. Answer in writing.

**Requirements:** use the four keys correctly, pair throughput with stability, and name at least
one thing the metrics do not capture about your situation.

**Testing:** whether you can defend a measurement position without either capitulating to the
benchmark or dismissing the question. Note for the professor: the "Elite" cluster stopped
appearing in the 2022 report, and reliability was added as a fifth metric in 2021 — a learner
quoting 2018-era tiers as current should be corrected.

---

## 8. AI adoption without amplifying dysfunction

**Type:** `ai-governance` · **Time-box:** 45 min

Pre-read: [DORA 2025 State of AI-assisted Software Development](https://research.google/pubs/dora-2025-state-of-ai-assisted-software-development-report/).

**Prompt:** the CEO wants AI coding assistants rolled out to all 40 engineers next quarter and
expects a throughput number in the next board deck.

**Requirements:** a written position covering what you will measure, what you expect to get
worse first, and the guardrail you put in before rollout rather than after.

**Testing:** whether you engage with the amplifier finding — AI magnifies existing strengths
*and* existing dysfunction — instead of arguing for or against adoption in the abstract.

---

## 9. Security posture for a board that just read a headline

**Type:** `vendor-risk` · **Time-box:** 30 min

Pre-read: [NIST CSF 2.0](https://doi.org/10.6028/nist.cswp.29), the Govern function.

**Prompt:** a peer company was breached through a supplier. Your board wants to know if you are
exposed, by Friday.

**Requirements:** answer using the Govern function's structure — organisational context, risk
strategy, roles, policy, oversight, supply-chain risk — and state plainly what you do not know
yet and when you will.

**Testing:** whether you can give a governance answer instead of a tooling answer.

---

## 10. Hire-plan under a hiring freeze

**Type:** `hire-plan` · **Time-box:** 30 min · **Synthetic**

You have one open req and two critical gaps.

**Requirements:** a scorecard for the one role, an explicit statement of which gap stays open,
and the compensating control for the gap you are not filling.

**Testing:** whether you can allocate scarcity without pretending both gaps get covered.

---

## Adding cases

`@cto-update` may extend this file. Requirements: a real URL, an explicit pre-read boundary,
a stated time-box, and a line on what the case tests. Synthetic scenarios are allowed but must
be labelled in the first line and must be built on a documented pattern, not an invented one.
