# Skill Dependencies & Prerequisite Gates

## Operator handoff contract (mandatory for every skill)

<a id="operator-handoff-contract"></a>

Implements the operator-provided **Response Clarity Protocol** (origin: `.work.cto/prompts/improve-clarity-of-responses.md`). Every skill response that ends a turn must be **terse** and close with exactly one of two forms. No skill may invent a third.

**Form A — nothing needed:** a single line stating no user input is required (e.g. `Next: nothing - work complete`). Do not render empty sections.

**Form B — input needed:** end the response with this skeleton; omit any section that has nothing in it; nothing after `**Next step:**`:

```
**Needs your approval:**
1. <Decision> — see path/to/file.md:L42
2. <Decision> — see path/to/file.md (lines 40–45)

**Needs your answer:**
1. <Question>
2. <Question>

**Next step:**
`<exact command or action to run>`
```

Rules:

1. **Brevity.** Report only what changed and what's needed next. No restating the task, no filler transitions, no unrequested rationale. Short declarative sentences.
2. **Exact references.** Approvals cite the project-root-relative path **and** line number(s): `path/to/file.md:L42` or `path/to/file.md (lines 40–45)`. Never make the operator hunt.
3. **Decisions and questions are separate lists.** One decision per numbered item, each answerable with a single yes/no or choice. Questions numbered in their own list, self-contained — answerable without re-reading prior context. Never mix the two in one list.
4. **One next step.** Exactly one command/action, isolated at the end in exact syntax. If multiple sequential actions exist, present only the immediate one; mention later ones only if the operator asks.
5. **Nothing buried, nothing empty.** Never end a response with an unstated expectation; never render an empty section; never hide an operator action inside a paragraph.
6. **Report-internal sections don't replace the close.** A template's "Follow-ups" / "Remaining" / "Recommended next" section is report content; any operator-required approval or question in it must ALSO appear in the Form B close.

**Enforcement:** `scripts/framework-verify.sh` fails any `skills/*/skill.md` that does not reference this contract (`Operator handoff`).

## Document clarity contract (mandatory for document-generating skills)

<a id="document-clarity-contract"></a>

Implements the operator-provided **Documentation Clarity Protocol** (origin: `.work.cto/prompts/improve-clarity-of-documentation.md`). Applies to every document a skill generates under `.work.cto/`: assessments, PROGRAM.md files, module designs, session logs, drill artifacts, consultancy memos, source notes, update notes, review/certification reports.

1. **Header answers three questions (≤4 lines):** what it is (one sentence) · **Status** (`Draft` | `In review` | `Approved` | `Superseded` + date) · what it needs (one line, or `nothing`).
2. **Brevity.** Summary first; every section informs a decision or an action; no boilerplate.
3. **Exact references.** Claims cite `path/to/file.md:L42`; quantitative claims tagged `measured` | `estimated` | `assumption` | `unknown`.
4. **Decisions and questions in separate numbered lists** — `## Decisions needed` vs `## Open questions`; never mixed, never buried in prose; each item self-contained.
5. **`## Next action` section** — exactly one action in exact syntax, or one line `Next action: none — <reason>`.
6. **Non-negotiables:** no empty/placeholder sections (omit or write `none` + reason); no document without a Status line; no unstated expectations; template scaffolding (`REPLACE:*`, instructional comments) stripped or filled before a document is presented as complete.

**Enforcement:** `scripts/framework-verify.sh` fails any document-generating skill (`cto-assess`, `cto-consult`, `cto-curriculum`, `cto-drill`, `cto-mentor`, `cto-program-custom`, `cto-program-standard`, `cto-review`, `cto-sources`, `cto-update`) whose `skill.md` does not reference this contract (`Document clarity`).

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

`cto-bootstrap`, `cto-deploy-basic`, `cto-deploy-files`, `cto-deploy-repo`, `cto-session`, `cto-director`, `cto-process-router` — infrastructure / routing; invoke anytime.

## Gate table

| Gate | State | Check | Unlocked by |
|------|-------|-------|-------------|
| — | scaffold | `.work.cto/` exists | `@cto-bootstrap init` |
| 1 | profile-ready | `{PROFILE}` has role + goal (no REPLACE: leftovers for required fields) | `@cto-bootstrap init` + PROFILE fill |
| 2 | assessed | `.work.cto/assessments/baseline.md` exists | `@cto-assess run` |
| 3 | program-active | At least one `.work.cto/programs/<slug>/PROGRAM.md` | `@cto-program-standard install` or `@cto-program-custom` |
| 4 | mentoring-loop | Active program + ≥1 **real** session log (a prep file alone does not count) | `@cto-mentor run` |
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
