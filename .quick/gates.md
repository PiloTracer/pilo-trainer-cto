# Readiness gates

```text
profile-ready → assessed → program-active → mentoring-loop
                                      ↘ consultancy-ready
```

| State | Unlock with | Evidence |
|-------|-------------|----------|
| scaffold | `@cto-bootstrap init` | `.work.cto/` exists |
| profile-ready | Fill `{PROFILE}` | Role + goal filled |
| assessed | `@cto-assess run` | `assessments/baseline.md` |
| program-active | `@cto-program-standard install` or `@cto-program-custom` | `programs/<slug>/PROGRAM.md` |
| mentoring-loop | `@cto-mentor run` | ≥1 **real** session log — a prep file alone does not count |
| consultancy-ready | profile-ready | Can run `@cto-consult` |

**Blocked?** You get the canonical report:

```text
BLOCKED (prerequisite): <gate description>
  Required state: <state>
  Current state: <current>
  To proceed: <command>
```

Waiver: pass `-y` and it gets logged in HANDOFF. Waivers are available on `cto-assess`,
`cto-program-standard`, `cto-program-custom`, `cto-curriculum`, `cto-mentor`, `cto-drill`, and
`cto-consult`. There is no waiver for `scaffold` — run `@cto-bootstrap init`.

See [`skills/SKILL_DEPENDENCIES.md`](../skills/SKILL_DEPENDENCIES.md)
