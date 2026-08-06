# Programs cheat sheet

| Want | Command |
|------|---------|
| List catalog | `@cto-program-standard list` |
| Install | `@cto-program-standard install - cto-foundations` |
| Custom | `@cto-program-custom - <request>` |
| Refine | `@cto-curriculum refine - <slug>` |

## Catalog slugs

| Slug | Focus |
|------|-------|
| `cto-foundations` | Role, leverage, calendar, decisions |
| `engineering-leadership` | Org, hiring, performance, culture |
| `delivery-systems` | Roadmap, architecture, reliability, debt |
| `product-stakeholder` | Product partnership, exec/board |
| `governance-risk` | Security, compliance, vendor, AI |
| `strategy-scale` | Scale, diligence, platform bets |
| `ai-engineering-leadership` | Leading an org through AI adoption |
| `continuous-edge` | Ongoing updates |

Catalog files: [`curricula/`](../curricula/) · Cases: [`drills/case-library.md`](../drills/case-library.md) · Sources: [`references/core-library.md`](../references/core-library.md)

## What install creates

```text
.work.cto/programs/<slug>/
  PROGRAM.md    # the SPEC
  progress.md   # task ledger — every deliverable, evidence path required to mark done
  notes.md      # retrieval queue + deltas
```

Sources are seeded into `.work.cto/sources/` at the same time. Check standing with
`@cto-review status` — see [`progress.md`](progress.md).
