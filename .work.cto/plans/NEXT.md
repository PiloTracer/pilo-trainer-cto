# NEXT — CTO training

**Status:** Active — 2026-08-14 · **Needs:** nothing
**Updated:** 2026-08-14

## Next action

Cut the release covering CHANGELOG Unreleased (clarity contracts + cto-session alignment + deploy verification), then continue in the thin-client target `/mnt/work/Projects/trainer-cto-custom`:

```
@cto-session start → @cto-bootstrap init → @cto-assess run
```

Optional first: `git init` in the target if version control is desired.

## Source repo (framework-dev)

| Priority | Action | Skill |
|----------|--------|-------|
| 1 | Cut release covering Unreleased (clarity contracts + cto-session alignment + deploy verification) | manual / `@cto-director` |
| 2 | ~~Decide + apply audit fixes F1/F2 (`agent.os.framework.md` protected-surface drift)~~ — done 2026-08-14 | manual |
| 3 | ~~Align `cto-session` with `session-control` (verbs, protocols, repo-mode commit scope)~~ — done 2026-08-14 | `@cto-session` |
| 4 | ~~Adopt clarity contracts (operator handoff + document clarity) + audit~~ — done 2026-08-14 | `.work.cto/prompts/adopt-framework-improvements.md` |

## Blocked

- (none)
