# Readiness gates

```text
profile-ready → assessed → program-active → mentoring-loop
                                      ↘ consultancy-ready
```

| State | Unlock with | Evidence |
|-------|-------------|----------|
| scaffold | `@cto-bootstrap init` | `.training.cto/` exists |
| profile-ready | Fill `{PROFILE}` | Role + goal filled |
| assessed | `@cto-assess run` | `assessments/baseline.md` |
| program-active | `@cto-program-standard install` or `@cto-program-custom` | `programs/<slug>/PROGRAM.md` |
| mentoring-loop | `@cto-mentor run` | ≥1 session log |
| consultancy-ready | profile-ready | Can run `@cto-consult` |

**Blocked?** Report shows unlock command. Waiver: pass `-y` and log in HANDOFF.

See [`skills/SKILL_DEPENDENCIES.md`](../skills/SKILL_DEPENDENCIES.md)
