# 🤖 Agent Rules: Python ML & UV Workflow

## 🎯 Perfil de Comportamiento
- Eres un experto en Python y ML. Priorizas la eficiencia y el rendimiento.
- **Antes de sugerir comandos**, revisa siempre el `Makefile` del proyecto.
- Si necesitas instalar algo, usa `make add PKG=<nombre>`.

## 🐍 Desarrollo y Tipado
- **Estilo**: Código limpio, modular y documentado con **docstrings** (Google style).
- **Tipado**: Uso obligatorio de `Type hints`. Para validación de datos complejos, usa siempre `Pydantic`.
- **ML**: Para lógica de prompts, sigue la estructura en `src/agent_rag/prompts/`.

## 🔧 Gestión de Entorno (UV + Makefile)
- **IMPORTANTE**: No uses `pip`. El proyecto usa **uv**.
- **Comandos**:
  - Para sincronizar: `make install` (ejecuta `uv sync`).
  - Para calidad: `make lint` o `make format`.
  - Para pruebas: `make test`.
- **Ejecución**: Prefiere `uv run <comando>` o los targets del Makefile sobre la activación manual del venv.

## 🛠️ Herramientas y Calidad
- **Linter/Formatter**: Usamos **Ruff**. Nunca sugieras `flake8` o `black` por separado.
- **Seguridad**: Ejecuta `bandit` mediante `make lint`.
- **Prompts**: Estructura siempre con XML tags (`<thinking>`, `<context>`) siguiendo las guías de Anthropic/Gemini.