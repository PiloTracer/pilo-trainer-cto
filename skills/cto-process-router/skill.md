---
name: cto-process-router
description: >-
  Read-only signpost. Maps how-to questions to the correct CTO Professor skill.
  Does not execute workflows or write memory.
---

# cto-process-router

- **Operator handoff:** every response that ends a turn follows the [Operator handoff contract](../SKILL_DEPENDENCIES.md#operator-handoff-contract) — terse output; approvals under `**Needs your approval:**` citing `path:L<n>`; questions numbered under `**Needs your answer:**`; exactly one `**Next step:**` command; one line when nothing is needed (Form A). Decisions and questions never mixed; empty sections omitted.

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

Close the response with Form A or Form B per the Operator handoff contract.
