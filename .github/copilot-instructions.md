# Copilot Instructions (Template Governance Adapter)

Use the following 3-level structure as the single source of truth:

## Level 1 — Governance

- `.github/architecture.md`
- `.github/standards.md`
- `.github/domain-boundaries.md`

Always read and apply these files before generating code or plans.

## Level 2 — Operational Skills

Skill specs are stored in `.github/skills/`:

- `create_use_case`
- `create_repository_interface`
- `create_mle_agent_package`
- `generate_e2e_tests`
- `generate_implementation_docs`
- `refactor_to_clean_architecture`
- `validate_module_structure`
- `generate_migration_plan`

Each skill must:

- receive explicit input,
- produce structured output,
- comply with governance files.

## Level 3 — Real Automation

Prefer system-enforced quality over model-only behavior:

- strict lint rules
- CI checks
- structure enforcement
- PR bots

Automation policy reference:

- `.github/automation.md`

## Additional Rules

- Interact with user in the language used by the user.
- Keep all code artifacts in English.
- Prefer `Makefile` commands and `uv` workflow.
- When implementing and testing new changes, create or update documentation in `docs/`.
