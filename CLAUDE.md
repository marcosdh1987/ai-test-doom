# Claude Code Adapter

Use this repository-level structure as the canonical source of instructions.

## Governance

Always read and apply these files before generating code or plans:

- `.github/architecture.md`
- `.github/standards.md`
- `.github/domain-boundaries.md`

## Native Skills

Claude Code discovers internal and synced external skills from:

- `.claude/skills/`

Generate or refresh that native layout with:

- `make setup-claude-skills`

The governed internal source of truth remains:

- `.github/skills/`

External synced/vendor skills remain in:

- `.github/skills-external/`

Antigravity uses a separate generated native workspace mirror at:

- `.agents/skills/`

If overlap exists, prefer `.github/skills/` over `.github/skills-external/`.

## Automation

Prefer system-enforced quality over model-only behavior:

- Automation policy: `.github/automation.md`
- Quality gate sequence: `make format` -> `make fix` -> `make lint` -> `make test`

Check `Makefile` before suggesting commands.

## Orchestration

Use explicit orchestration for complex tasks:

- Orchestration policy: `.github/orchestration.md`
- Plan first, then execute.
- Complete each phase before moving to the next.
- Review diffs before finalizing.
- Validate results against automation requirements.

## Runtime Rules

- Interact in the same language as the user.
- Keep all code artifacts in English (identifiers, docstrings, comments, docs).
- Prefer `make` targets and `uv` workflows.
- When implementing or testing changes, create or update documentation in `docs/`.
- Use absolute imports only.
