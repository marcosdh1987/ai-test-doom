---
description: Enforce structured and absolute import order for Python files
globs:
  - "**/*.py"
alwaysApply: true
---

Group, order, and format Python imports following these conventions:

### ✅ Use **absolute imports only**:
Always write imports using the full path from the project root.
**Avoid** relative imports like `from .module import foo` or `from ..utils import bar`.

- ✅ `from my_project.utils import foo`  
- ❌ `from .utils import foo`  
- ❌ `from ..submodule import bar`

This ensures clarity, consistency across refactors, and better compatibility with tools like linters, IDEs, and packaging systems.
