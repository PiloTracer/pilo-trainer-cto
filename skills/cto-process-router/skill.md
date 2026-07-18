---
name: cto-process-router
description: >-
  Read-only signpost. Maps how-to questions to the correct CTO Professor skill.
  Does not execute workflows or write memory.
---

# cto-process-router

## Protocol

1. Read [`PROCESS_ROUTER.md`](../../PROCESS_ROUTER.md) and `skills/README.md`.
2. Answer with the exact `@skill mode` to run — no execution.
3. If gated, mention the prerequisite and unlock command from `SKILL_DEPENDENCIES.md`.
4. If free-text multi-step, suggest `@cto-director - <same request>`.

## Output shape

```text
Recommended: @<skill> <mode> [- <arg>]
Why: <one line>
If blocked: <gate + unlock>
```
