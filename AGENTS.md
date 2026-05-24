# Codex UI Adapter

Use this repository-level structure as the canonical source of instructions.

## Level 1 — Governance

- `.github/architecture.md`
- `.github/standards.md`
- `.github/domain-boundaries.md`

## Level 2 — Operational Skills

Internal governed skills are the source of truth:

- `.github/skills/create_use_case.md`
- `.github/skills/create_repository_interface.md`
- `.github/skills/create_mle_agent_package.md`
- `.github/skills/generate_e2e_tests.md`
- `.github/skills/generate_implementation_docs.md`
- `.github/skills/refactor_to_clean_architecture.md`
- `.github/skills/validate_module_structure.md`
- `.github/skills/generate_migration_plan.md`
- `.github/skills/execute_engineering_task.md`
- `.github/skills/plan_and_execute_feature.md`

Claude Code native skill links are generated from `.github/skills/` and `.github/skills-external/` into:

- `.claude/skills/`

Antigravity native workspace skills are generated from the same governed sources into:

- `.agents/skills/`

Refresh them with:

- `make setup-claude-skills`
- `make setup-antigravity-skills`

Also load external synced/vendor skills from:

- `.github/skills-external/`

If overlap exists, prioritize `.github/skills/` over `.github/skills-external/`.

## Level 3 — Automation

- `.github/automation.md`

## Level 4 — Orchestration

- `.github/orchestration.md`

## Runtime Rules

- Use user language for interaction.
- Keep all code artifacts in English.
- Prefer Makefile and uv workflows.
