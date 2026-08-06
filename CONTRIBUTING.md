# Contributing

CTO Professor OS is a Markdown-first framework. Prefer small, reviewable changes.

## Skills

1. Create `skills/<id>/skill.md` with YAML frontmatter `name:` matching the folder.
2. Register in `skills/README.md`, `README.md` § *Skills at a glance*, `.cursorrules` skills table, and `templates/cursorrules.template`.
3. Update `skills/SKILL_DEPENDENCIES.md` if the skill has gates.
4. A gated skill needs a `**Requires:**` line and must emit the canonical BLOCKED report. If the gate table grants a `-y` waiver, say so in the skill too.
5. Keep `skill.md` focused; put long examples in `reference.md` if needed.

## Curricula

A new catalog program must be registered in **three** places or verify fails:
`curricula/README.md`, `skills/cto-program-standard/skill.md` catalog table, and `README.md`.
It must also carry every section required by `standards/program-spec.md` — audience, measurable
outcomes, duration and cadence, modules with objectives/drill/sources/exit check, assessment
rubrics, and exit criteria.

## Standards, references, and drills

- **Every standard must be referenced by at least one skill.** Verify fails on an orphan — a standard nothing binds is decoration.
- **`references/core-library.md`**: entries need title + author or URL, plus a verification status and a `Checked` date. Load the page or mark it **Unverified**. Never assert a chapter number you have not confirmed.
- **`drills/case-library.md`**: each case needs a real URL, an explicit pre-read boundary, a time-box, and a line on what it tests. Synthetic scenarios are allowed but must say so in the first line and be built on a documented pattern.

## Naming

- Domain skills: `cto-<role>` (kebab-case)
- Infrastructure: `cto-deploy-*`, `cto-session`

## Verify

```bash
bash scripts/framework-verify.sh
```

Add a guard for any new invariant you introduce, and confirm it actually fails when broken —
a check that cannot fail is not a check.

## Memory vs framework

Learner artifacts belong only under `.work.cto/`. Framework content lives under
`templates/`, `curricula/`, `standards/`, `references/`, and `drills/` — never edit those for
one learner's content; copy out instead.
