# Skill Dependencies & Prerequisite Gates

## Gate Graph

```text
cto-bootstrap init
       │  scaffold + PROFILE → profile-ready
       ▼
cto-assess run
       │  State: assessed
       ▼
cto-program-standard install  OR  cto-program-custom
       │  State: program-active
       ▼
cto-mentor / cto-drill          cto-consult (consultancy-ready after profile-ready)
cto-curriculum refine
cto-sources / cto-update
       │
       ▼
cto-review status / certify
```

## System skills (no gate)

`deploy-basic`, `deploy-files`, `deploy-repo`, `session-cto`, `cto-director`, `cto-process-router` — infrastructure / routing; invoke anytime.

## Gate table

| Gate | State | Check | Unlocked by |
|------|-------|-------|-------------|
| — | scaffold | `.training.cto/` exists | `@cto-bootstrap init` |
| 1 | profile-ready | `{PROFILE}` has role + goal (no REPLACE: leftovers for required fields) | `@cto-bootstrap init` + PROFILE fill |
| 2 | assessed | `.training.cto/assessments/baseline.md` exists | `@cto-assess run` |
| 3 | program-active | At least one `.training.cto/programs/<slug>/PROGRAM.md` | `@cto-program-standard install` or `@cto-program-custom` |
| 4 | mentoring-loop | Active program + ≥1 session log OR NEXT points to mentor | `@cto-mentor run` |
| 5 | consultancy-ready | profile-ready (assessed recommended) | `@cto-bootstrap init` |

## Skill requirements

| Skill | Requires | Waiver |
|-------|----------|--------|
| `cto-assess` | profile-ready | `-y` + log in HANDOFF |
| `cto-program-standard` | profile-ready (assessed recommended) | `-y` |
| `cto-program-custom` | profile-ready | `-y` |
| `cto-curriculum` | program-active for `refine`; `design` needs profile-ready | `-y` |
| `cto-mentor` | program-active | `-y` (ad-hoc session; still write session log) |
| `cto-drill` | assessed recommended | `-y` |
| `cto-consult` | profile-ready | `-y` |
| `cto-sources` | scaffold | none |
| `cto-update` | scaffold | none |
| `cto-review` | scaffold | none |

## Blocked report shape

```text
BLOCKED (prerequisite): <gate description>
  Required state: <state>
  Current state: <current>
  To proceed: <command>
```
