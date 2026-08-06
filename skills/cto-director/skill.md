---
name: cto-director
description: >-
  Universal orchestrator. Accepts free-text CTO training/consultancy requests,
  maps to skill chains, checks gates, Confirm gate unless -y. Redirects
  engineering/UI/biz to sibling directors.
---

# cto-director

## Free-text intake

1. **Capture** — quote user request in HANDOFF when executing.
2. **Load** — `{HANDOFF}`, `{NEXT}`, `{PROFILE}`, `{UNKNOWNS}`, `skills/README.md`, `SKILL_DEPENDENCIES.md`.
3. **Classify** — intent → skill (table below). Max 3 probe questions if unclear.
4. **Check gates** — for every skill in the planned chain, verify its prerequisite before proposing it. If one is unmet, emit the canonical BLOCKED report from `skills/SKILL_DEPENDENCIES.md` for that step and offer the unlock command instead of silently routing past it.
5. **Confirm** — show planned skill chain; wait unless `-y` or `--dry-run`.
6. **Execute** — run chain; update HANDOFF/NEXT.

## Intent → skill

| Intent cluster | Skill chain |
|----------------|-------------|
| Setup / empty memory (explicit training-project intent only — never inferred from an incomplete PROFILE during framework-dev work) | `@cto-bootstrap init` |
| Level / gaps / diagnostic | `@cto-assess run` |
| Install catalog program | `@cto-program-standard list` → `install - <slug>` |
| Custom program / special request | `@cto-program-custom - <request>` |
| Module design | `@cto-curriculum design` |
| Mentoring / teach / coach today | `@cto-session start` → `@cto-mentor run` |
| Consultancy / advice / decision | `@cto-consult memo` / `review` / `board` |
| Drill / practice / simulation | `@cto-drill run - <type>` |
| Reading list / sources | `@cto-sources curate` |
| Stay current / trends | `@cto-update run` |
| Progress / certify | `@cto-review status` |
| Deploy to another repo | `@cto-deploy-basic - <path>` |
| Engineering / code / backend | Redirect `@ai-director` or `@x-director` |
| UI / design | Redirect `@ui-director` |
| Biz / sales / content biz | Redirect `@biz-director` |

## Confirm block shape

```text
Plan:
1. @skill mode - arg
Confirm? (reply yes / pass -y next time)
```

## New skill protocol

If no skill fits: propose `cto-<role>` name, outline `skill.md`, ask before creating.
