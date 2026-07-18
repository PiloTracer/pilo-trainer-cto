---
name: cto-program-standard
description: >-
  List and install standard curricula from the framework catalog into
  .training.cto/programs/. Never mutate curricula/ in the framework for learner content.
---

# cto-program-standard

**Requires:** profile-ready (assessed recommended).

## Parse

| Invoke | Action |
|--------|--------|
| `@cto-program-standard list` | Show catalog |
| `@cto-program-standard install - <slug>` | Copy into programs/ |
| `@cto-program-standard status` | Active programs |

## Catalog slugs

| Slug | File |
|------|------|
| `cto-foundations` | `curricula/cto-foundations.md` |
| `engineering-leadership` | `curricula/engineering-leadership.md` |
| `delivery-systems` | `curricula/delivery-systems.md` |
| `product-stakeholder` | `curricula/product-stakeholder.md` |
| `governance-risk` | `curricula/governance-risk.md` |
| `strategy-scale` | `curricula/strategy-scale.md` |
| `continuous-edge` | `curricula/continuous-edge.md` |

Resolve curricula path via `$TRAINER_CTO_SOURCE/curricula/` (thin) or local / `.ai.cto/curricula/` (fat/self-hosted).

## install

1. Confirm slug exists.
2. Create `.training.cto/programs/<slug>/`.
3. Copy catalog → `PROGRAM.md` (adapt lightly to PROFILE: duration notes, company stage — do not gut outcomes).
4. Create `progress.md` (all modules pending) and empty `notes.md`.
5. Set PROFILE active program; readiness → `program-active`.
6. Update NEXT → `@cto-mentor prepare` or `run`.
7. Optionally `@cto-sources curate` for the program's source list.

## Rules

**Never** edit framework `curricula/` for one learner. Always copy out.
