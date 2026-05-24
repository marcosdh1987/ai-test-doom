---
trigger: always_on
---

# Antigravity Workspace Rule

Use this repository's governed structure as the canonical source of truth.

## Governance

Read and apply:

- @.github/architecture.md
- @.github/standards.md
- @.github/domain-boundaries.md

## Skills

Antigravity discovers workspace-native skills from:

- @.agents/skills/

The governed sources remain:

- @.github/skills/
- @.github/skills-external/

Refresh the Antigravity-native layout with:

- `make setup-antigravity-skills`
- `make sync-skills`

If an internal governed skill and an external synced skill share the same name, prefer the internal governed skill.

## Automation And Orchestration

Read and follow:

- @.github/automation.md
- @.github/orchestration.md

## Runtime Rules

- Interact in the same language as the user.
- Keep all code artifacts in English.
- Prefer `make` targets and `uv` workflows.
- Update docs in `docs/` when implementation or tests change.
- Use absolute imports only.
