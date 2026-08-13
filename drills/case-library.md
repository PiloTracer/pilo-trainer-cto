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

**Assumptions / unknowns required:** this brief is deliberately incomplete — no confirmed
cause, no system context. Name what you do not know as gaps in your response; never invent
the missing facts.

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

**Assumptions / unknowns required:** the brief omits *why* the migration slipped and what
the recovery plan is. State those as named gaps (or labelled assumptions) in the update —
inventing a cause is the failure.

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

**Assumptions / unknowns required:** the brief omits team context and the reason for the
freeze. State your assumptions on the page — named as assumptions, not presented as facts.

**Testing:** whether you can allocate scarcity without pretending both gaps get covered.

---

## 11. Tech debt with a price on it

**Type:** `tech-debt` · **Time-box:** 40 min · **Synthetic scenario, real pattern**

A service everyone calls "the legacy one" absorbs roughly a third of the team's time. An
engineer proposes a rewrite. The CEO asks what it buys.

**Requirements:** state the current cost per month in money or engineer-time, the cost of the
rewrite with a range, and what you would ship *instead* with the same budget. Then pick, and
name one debt item you are explicitly choosing to keep.

**Assumptions / unknowns required:** the brief supplies no figures. Your cost numbers must
arrive labelled as assumptions with a range — invented precision is the failure this drill
scores down.

**Testing:** whether debt is a number or a mood. "It slows us down" is not an answer, and
neither is a rewrite without the counterfactual — the money spent rewriting is money not spent
on something else, and that comparison is the decision.

**Failure mode to catch:** the estimate that arrives as a single confident figure. Ask for the
range, then ask which end they would tell the board.

---

## 12. Engagement charter under scope-creep pressure

**Type:** `decision-case` variant — charter draft · **Time-box:** 45 min · **Synthetic**

You are signing a fractional CTO seat: a 40-engineer fintech, monolith plus one standalone
service, a database migration scheduled in 30 days, a board meeting in 14 days, a
non-technical CEO, and an engineering org split 60/40 on freezing features. Bandwidth is
~10 hrs/week. Write the one-page engagement charter.

**Pre-read boundary:** the brief above only — no template and no prior charter. The
structure is part of the test.

**Requirements:** own/advise/escalate with a named decision owner per row; an Own column
sized to the stated bandwidth, not to appetite; ≥3 explicit out-of-scope items; success
criteria that each carry the five anchors (what is measured · with what instrument · whose
number · baseline + date · trigger); exit criteria naming both endings (renew vs handoff)
with pre-agreed outputs each.

**Assumptions / unknowns required:** the brief deliberately omits the tooling, the current
delivery baseline, and the engineering-leadership situation. An **Assumptions / unknowns**
block naming those gaps is part of the deliverable — inventing the missing facts is the
failure.

**Testing:** a charter is checkable at three levels — promises to the client (verifiable
only in a real engagement), decision architecture (checkable on the page), and structure
(checkable in 30 seconds). The drill grades the latter two. A charter whose success
criteria have no instrument, no owner, and no trigger reads well and is unverifiable; that
gap is the lesson.

**Failure mode to catch:** success criteria that escalate toward 100% ("100% sprint-goal
completion by sprint 4"). Sustained 100% is sandbagging — the metric is predictability,
and a criterion that rewards under-committing teaches the wrong lesson twice.

---

## Adding cases

`@cto-update` may extend this file. Requirements: a real URL, an explicit pre-read boundary,
a stated time-box, and a line on what the case tests. Synthetic scenarios are allowed but must
be labelled in the first line and must be built on a documented pattern, not an invented one.
Synthetic scenarios must also say that facts are deliberately omitted — the learner surfaces
the unknowns as named gaps in the deliverable (an "Assumptions / unknowns" block); inventing
the missing numbers is the failure the drill exists to catch.
