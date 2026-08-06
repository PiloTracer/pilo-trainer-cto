# Curricula catalog

Framework-owned standard programs. **Install** via `@cto-program-standard install - <slug>` — copies into `.work.cto/programs/`. Never edit these files for one learner.

| Slug | File | Focus |
|------|------|-------|
| `cto-foundations` | [cto-foundations.md](cto-foundations.md) | Role, leverage, calendar, decisions |
| `engineering-leadership` | [engineering-leadership.md](engineering-leadership.md) | Org, hiring, performance, culture |
| `delivery-systems` | [delivery-systems.md](delivery-systems.md) | Roadmap, architecture, reliability, debt |
| `product-stakeholder` | [product-stakeholder.md](product-stakeholder.md) | Product partnership, exec/board |
| `governance-risk` | [governance-risk.md](governance-risk.md) | Security, compliance, vendor, AI |
| `strategy-scale` | [strategy-scale.md](strategy-scale.md) | Scale, diligence, platform bets |
| `ai-engineering-leadership` | [ai-engineering-leadership.md](ai-engineering-leadership.md) | Leading an org through AI adoption |
| `continuous-edge` | [continuous-edge.md](continuous-edge.md) | Ongoing updates |

Custom programs: `@cto-program-custom - <request>`.

## SPEC compliance

Every file here carries the sections required by `standards/program-spec.md` — audience,
measurable outcomes, duration and cadence, modules with objectives/drill/sources/exit check,
assessment rubrics, and exit criteria. `@cto-program-standard install` checks this on copy, and
`scripts/framework-verify.sh` enforces it in CI.

Drills referenced by slug live in [`drills/case-library.md`](../drills/case-library.md).
Sources are drawn from [`references/core-library.md`](../references/core-library.md).
