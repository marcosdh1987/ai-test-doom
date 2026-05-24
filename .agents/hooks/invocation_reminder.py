#!/usr/bin/env python3

import json
import sys

REMINDER = (
    "Repository reminder: read .github/architecture.md, .github/standards.md, "
    ".github/domain-boundaries.md, prefer make/uv workflows, and update docs/ when src/ or tests/ change. "
    "For skills/rules changes, keep .agents/ and governed .github/ sources aligned."
)


def main() -> None:
    raw = sys.stdin.read().strip()
    invocation_num = 0
    if raw:
        try:
            payload = json.loads(raw)
            invocation_num = int(payload.get("invocationNum", 0))
        except (json.JSONDecodeError, TypeError, ValueError):
            invocation_num = 0

    if invocation_num > 1:
        sys.stdout.write(json.dumps({"injectSteps": []}))
        return

    sys.stdout.write(json.dumps({"injectSteps": [{"ephemeralMessage": REMINDER}]}))


if __name__ == "__main__":
    main()
