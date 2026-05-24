# Development Hooks Setup

## Pre-commit bootstrap

The `setup-hooks` target now ensures required tooling is available before hook installation.

### Command

```bash
make setup-hooks
```

### What it does

1. Verifies the virtual environment exists (`make install` if needed).
2. Syncs development dependencies with `uv sync --group dev`.
3. Installs Git hooks with `pre-commit install`.

This avoids failures like `Failed to spawn: pre-commit` when the binary is not yet installed.

## Antigravity hooks

The workspace now includes Antigravity-native hooks in `.agents/hooks.json`.

### What is configured

1. A `PreToolUse` command guard for `run_command`:
	- denies destructive Git commands such as `git reset --hard` and `git clean -xfd`
	- forces confirmation for direct `pip install` and `pip uninstall` so the template stays aligned with `make` and `uv`
	- asks for confirmation on direct `pytest` usage to steer the agent toward `make test` or `make test-unit`
2. A `PreInvocation` reminder:
	- injects a one-time reminder at the beginning of an Antigravity session to read governance docs, prefer `make` and `uv`, and update `docs/` when implementation changes touch `src/` or `tests/`

### Hook files

- `.agents/hooks.json`
- `.agents/hooks/command_guard.py`
- `.agents/hooks/invocation_reminder.py`

### Notes

- These hooks are workspace-local and are discovered natively by Antigravity.
- The command guard is intentionally narrow: it protects against clearly risky commands and nudges the agent toward this template's standard workflows without blocking normal development commands.
