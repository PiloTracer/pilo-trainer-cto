# Governance & Risk

**Slug:** `governance-risk`  
**Duration:** 5–7 weeks · 2 sessions/week  
**Level:** CTO accountable for security, compliance, vendors, and AI use

## Audience / level assumptions

- Answerable to a board, auditor, customer, or regulator on security posture
- Owns vendor decisions that can take the product down from outside
- More likely to be asked "are we exposed?" than "which scanner did you buy?"

## Outcomes (measurable)

1. Risk register in business language, ranked, with owners
2. Vendor and concentration risk map including one openly unhedged dependency
3. AI use policy covering review, provenance, and third-party data
4. Compliance obligation map: obligation → engineering control → evidence
5. One board-ready answer to "are we exposed?" that survives follow-up

## Duration & cadence

5–7 weeks, 2 sessions/week plus one async drill.

## Modules

### M1 — Governance before tooling

- **Objectives:** Use the CSF 2.0 Govern function as the spine — organisational context, risk strategy, roles and authorities, policy, oversight, supply-chain risk. Govern was added in CSF 2.0 precisely because governance had been buried inside Identify and was invisible.
- **Drill:** `vendor-risk` — case 9, a peer breached through a supplier and the board wants an answer by Friday
- **Sources:** NIST CSF 2.0 — https://doi.org/10.6028/nist.cswp.29; release note — https://www.nist.gov/news-events/news/2024/02/nist-releases-version-20-landmark-cybersecurity-framework
- **Exit check:** The answer is structured by Govern categories and states plainly what is not yet known and by when

### M2 — Risk register that ranks

- **Objectives:** Top risks in business language; kill vanity controls
- **Drill:** Rank the top 5 risks for your company stage and delete 10 controls that buy nothing
- **Sources:** NIST CSF 2.0 Identify and Protect functions; OWASP Top 10 — https://owasp.org/www-project-top-ten/ (verify the current edition at drill time)
- **Exit check:** Each risk has an owner, a business consequence, and a rank justification. A register with no deletions failed.

### M3 — Vendor and concentration risk

- **Objectives:** Map who can take you down from outside; price the switch
- **Drill:** `vendor-risk` — critical provider changes terms with 30 days' notice
- **Sources:** NIST CSF 2.0 supply-chain risk (GV.SC); public incident corpus — https://github.com/danluu/post-mortems/
- **Exit check:** One dependency explicitly accepted as unhedged, with the reason written down

### M4 — AI governance

- **Objectives:** Policy for AI-assisted code and AI features: who reviews, what may leave the building, who is accountable
- **Drill:** `ai-governance` — case 8
- **Sources:** NIST AI Risk Management Framework — https://www.nist.gov/itl/ai-risk-management-framework (verify current version at drill time); DORA 2025 — https://research.google/pubs/dora-2025-state-of-ai-assisted-software-development-report/
- **Exit check:** Accountability named before tooling; the policy survives three plausible incidents

### M5 — Compliance and audit readiness

- **Objectives:** Obligation → control → evidence, so an audit is a retrieval exercise rather than a project
- **Drill:** Map one real obligation end to end and identify where the evidence does not exist
- **Sources:** NIST CSF 2.0 GV.OC-03 on legal and regulatory requirements; `standards/anti-patterns.md` § Governance and risk
- **Exit check:** At least one gap found and dated. A map with no gaps was not done honestly.

## Assessment / rubrics

| Criterion | Pass |
|-----------|------|
| Governance answer | Structured by Govern; unknowns stated with dates |
| Risk register | Ranked, owned, in business language; vanity controls removed |
| Vendor map | Switching costs priced; one unhedged dependency owned |
| AI policy | Accountability before tooling |
| Compliance map | Evidence gaps found, not hidden |

Reject fear-mongering and checkbox compliance without risk ranking. Drill dimensions per
`standards/assessment.md`: average ≥3, no dimension at 1.

## Exit criteria (program complete)

All module exit checks met; artifacts stored under `.work.cto/` and linked from the task
ledger; `@cto-review status` run with evidence paths cited.
