# HANDOFF — CTO training

**Last updated:** 2026-07-18  
**Session state:** idle

> **Context:** entries below document framework-build work on this self-hosted CTO Professor OS repo — not a real learner's training history. Treat as a framework-dev log until a real training project is explicitly started here.

## Latest action

**Date:** 2026-07-18  
**Request:** fix bootstrap-routing bug + full skills improvement pass (per plan `fix_bootstrap_routing_+_skills_audit_9b4218be`), then `@session-cto close commit push`  
**Executed:**
1. Fixed a real thin-client wiring bug: `templates/bootstrap.sh` now substitutes `TRAINER_CTO_SOURCE` for a brand-new target when an explicit source is given (`@cto-bootstrap init - <source-path>`); previously it silently left `REPLACE_BASICSOURCE` unfilled. Fixed `skills/deploy-basic/skill.md`'s inconsistent Parse table and documented the target-must-pre-exist requirement in `README.md` / `.quick/deploy-to-project.md`.
2. Fixed the framework-dev vs training-project routing bug: added a "learner-pipeline intent" guard to `.cursorrules` + `templates/cursorrules.template`, `START_HERE.md`, `skills/session-cto/skill.md`, `skills/cto-bootstrap/skill.md`, `skills/cto-director/skill.md` — never auto-propose/chain into `@cto-bootstrap init` etc. from an incomplete PROFILE alone.
3. Fixed `scripts/framework-verify.sh` (was `FAIL` on a stale string-match check) — now does real row-by-row checks plus regression guards for both bugs above; confirmed `=== PASS ===`.
4. Strengthened `cto-assess`, `cto-drill`, `cto-curriculum`, `cto-review` with explicit standards citations and a missing drill-report artifact shape.
5. Added additive clarifying notes to this file, `.training.cto/README.md`, `.training.cto/context/PROFILE.md` marking prior history as framework-dev, not real learner data.
**Blockers:** none  
**Next recommended:** see `{NEXT}` — no active learner pipeline; next step is a framework decision (CHANGELOG/version bump, or start a real training project).

## Active focus

- Program: (none yet — self-hosted instance is framework-dev, not a real training project; see note above)
- Module:
- Open consultancy:

## Carry-forward

- PROFILE.md REPLACE tokens are intentionally unfilled (see note in that file) — only fill them if this repo is deliberately turned into a real training project
- If/when a real training project starts here: `@cto-assess run` → pick standard or custom program
