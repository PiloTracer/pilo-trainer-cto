# CTO anti-patterns

Binding for `@cto-mentor`, `@cto-consult`, and `@cto-review`.

The core principle of this framework is *correct the learner*. That instruction is useless
without a catalogue of what to look for. This is that catalogue: recurring CTO failure modes,
each with the tell that exposes it and the challenge that tests it.

**How to use:** scan for these during diagnosis. When one is present, name it and run the
challenge. Do not soften it into a suggestion — a named failure mode the learner can recognise
again later is worth more than a comfortable session.

---

## Role and leverage

| Anti-pattern | Tell | Challenge |
|--------------|------|-----------|
| **Senior IC in a CTO title** | Calendar dominated by code review and debugging; describes technical work as "the only thing that got done today" | "What did you do this week that nobody else in the company could have done?" |
| **Consensus theatre** | Every decision goes to a meeting; no owner named | "Who decided? If the answer is 'we', nobody did." |
| **Reorganising instead of deciding** | Structural change proposed for a problem that is a single unmade decision | "Which decision does this org chart make for you?" |
| **Heroism as strategy** | Reliability depends on one person's availability | "Write the exact sequence for the week they quit." |

## Decisions

| Anti-pattern | Tell | Challenge |
|--------------|------|-----------|
| **Two-option decision** | A real option and a straw man | "Give me the third option, including doing nothing." |
| **Retrospective justification** | Decision drivers written after the choice, fitting it exactly | "What would have changed your mind, and when did you last believe it might?" |
| **Reversibility blindness** | One-way and two-way doors treated with equal ceremony | "What does undoing this cost in month six?" |
| **Decision without a trigger** | No stated condition for revisiting | "What observation would tell you this was wrong?" |

## Delivery

| Anti-pattern | Tell | Challenge |
|--------------|------|-----------|
| **Velocity theatre** | Throughput reported without stability; story points to the board | "Show me change fail rate next to that." (See `metrics.md`) |
| **Empty Never column** | Every backlog item is now or next | "You have declined nothing. What are you accepting by not deciding?" |
| **Estimate as commitment** | A range quoted upward becomes a date quoted downward | "Which number did the CEO hear, and when did the range disappear?" |
| **Debt as a moral category** | Tech debt discussed as virtue or shame, never as interest paid | "What does this cost per month, in what currency?" |

## Organisation

| Anti-pattern | Tell | Challenge |
|--------------|------|-----------|
| **Cognitive overload sold as ownership** | One team owns several unrelated domains plus the platform | "Which of these would you cut if the team lost two people?" |
| **Renaming without moving load** | Reorg changes labels; responsibilities identical | "Name the responsibility that changed hands." |
| **Hiring as the answer to a system problem** | Headcount request precedes any diagnosis | "If the req were denied permanently, what would you fix instead?" |
| **Ivory-tower enabling team** | A platform or architecture group that dictates rather than serves | "When did a consuming team last reject their advice, and what happened?" |

## Stakeholders

| Anti-pattern | Tell | Challenge |
|--------------|------|-----------|
| **Status theatre** | Weekly update lists activity; forces no decision | "Delete every sentence that does not need a reply. What's left?" |
| **Bad news buried** | The slip appears in paragraph four | "Move it to the first line and read it back." |
| **Translation avoidance** | Technical constraint explained in technical language to a non-technical audience | "Say it in money or in time." |
| **Over-promising to protect the relationship** | Commitments made to end an uncomfortable conversation | "What did you agree to that you do not believe?" |

## Governance and risk

| Anti-pattern | Tell | Challenge |
|--------------|------|-----------|
| **Tooling answer to a governance question** | "We bought a scanner" in response to "are we exposed?" | "Who owns the decision, and under what policy?" (See NIST CSF 2.0 Govern) |
| **Compliance as security** | Certification treated as evidence of safety | "Name a real attack the audit would not have caught." |
| **Supplier risk unmapped** | No inventory of who can take you down from outside | "Which vendor's bad Tuesday is your outage?" |

## AI-specific

| Anti-pattern | Tell | Challenge |
|--------------|------|-----------|
| **Adoption as strategy** | Rollout planned; no measurement, no guardrail | "What gets worse first, and how will you see it?" |
| **Amplifier blindness** | Expecting AI to fix a delivery process that is already broken | DORA's 2025 finding is that AI amplifies existing strengths *and* existing dysfunction. "Which one do you have more of right now?" |
| **Individual gains, system silence** | Productivity claimed per developer; no system-level throughput or stability signal | "Show me it at the delivery level." |

## Training-specific

Failure modes of the learner's own practice, which `@cto-review` should watch for:

| Anti-pattern | Tell | Challenge |
|--------------|------|-----------|
| **Comfortable drilling** | Repeatedly practising the strong skill; the hard deliverable stays untouched | "The item you keep not starting is the one worth starting." |
| **Reading as progress** | Books consumed, no notes filed, no artifact produced | Unfiled reading does not count. |
| **Retrospective ADR editing** | Record improved after seeing the real outcome | The gap was the data. Editing it deletes the result. |
| **Scoring drift** | Self-scores rising without harder scenarios | Raise the difficulty, or the score means nothing. |

---

## Rule

Name the pattern, run the challenge, record the learner's answer in the session log. An
anti-pattern spotted and not confronted is worse than one missed — it teaches the learner
that the professor will let things slide.
