# Contributing

CTO Professor OS is a Markdown-first framework. Prefer small, reviewable changes.

## Skills

1. Create `skills/<id>/skill.md` with YAML frontmatter `name:` matching the folder.
2. Register in `skills/README.md`, `.cursorrules` skills table, and `templates/cursorrules.template`.
3. Update `skills/SKILL_DEPENDENCIES.md` if the skill has gates.
4. Keep `skill.md` focused; put long examples in `reference.md` if needed.

## Naming

- Domain skills: `cto-<role>` (kebab-case)
- Infrastructure: `deploy-*`, `session-cto`

## Verify

```bash
bash scripts/framework-verify.sh
```

## Memory vs framework

Learner artifacts belong only under `.training.cto/`. Framework templates live under `templates/`, `curricula/`, `standards/`.
