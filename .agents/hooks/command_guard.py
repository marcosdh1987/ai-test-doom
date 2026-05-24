#!/usr/bin/env python3

import json
import shlex
import sys

DENY_PREFIXES = (
    "git reset --hard",
    "git checkout --",
    "git clean -fd",
    "git clean -xfd",
)

ASK_PREFIXES = (
    "pip install",
    "pip uninstall",
    "python -m pip install",
    "python -m pip uninstall",
)


def _normalize_command(command_line: str) -> str:
    return " ".join(command_line.strip().split())


def _response(decision: str, reason: str = "", permission: str | None = None) -> None:
    payload: dict[str, object] = {"decision": decision}
    if reason:
        payload["reason"] = reason
    if permission:
        payload["permissionOverrides"] = [permission]
    sys.stdout.write(json.dumps(payload))


def main() -> None:
    raw = sys.stdin.read().strip()
    if not raw:
        _response("allow")
        return

    try:
        payload = json.loads(raw)
    except json.JSONDecodeError:
        _response("allow")
        return

    tool_call = payload.get("toolCall", {})
    if tool_call.get("name") != "run_command":
        _response("allow")
        return

    args = tool_call.get("args", {})
    command_line = str(args.get("CommandLine", "")).strip()
    if not command_line:
        _response("allow")
        return

    normalized = _normalize_command(command_line)

    for prefix in DENY_PREFIXES:
        if normalized.startswith(prefix):
            _response(
                "deny",
                "This repository disallows destructive git reset/clean commands from Antigravity hooks.",
            )
            return

    for prefix in ASK_PREFIXES:
        if normalized.startswith(prefix):
            _response(
                "force_ask",
                "Prefer `make add`, `make remove`, or `uv` workflows instead of direct pip commands in this template.",
                f"command({command_line})",
            )
            return

    try:
        first_token = shlex.split(command_line)[0]
    except ValueError:
        _response("allow")
        return

    if first_token == "pytest":
        _response(
            "ask",
            "Prefer `make test` or `make test-unit` unless you explicitly need a direct pytest invocation.",
            f"command({command_line})",
        )
        return

    _response("allow")


if __name__ == "__main__":
    main()
