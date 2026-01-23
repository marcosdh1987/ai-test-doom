# Instrucciones de estilo para Copilot Chat

## 🐍 Desarrollo Python
- **Lenguaje**: Genera siempre código en **Python**.
- **Modularidad**: Organiza el código en **paquetes** y **módulos** claros.
- **Documentación**: Incluye **docstrings** explicativos en funciones y clases.
- **Type hints**: Usa anotaciones de tipo cuando sea apropiado.

## 🔧 Gestión de Entorno
- **Virtualenv**: Usa **uv** para gestión de dependencias (`uv sync`, `uv run`).
- **Activación**: Usa `source .venv/bin/activate` para activar el entorno.
- **Dependencias**: Gestiona mediante `pyproject.toml` (`make add PKG=...` o `uv add`).

## 🛠️ Herramientas de Proyecto
- **Makefile**: Usa `make <target>` para comandos del proyecto (install, run-api, run-batch-test, etc.).
- **Tests**: Coloca archivos de prueba en `tests/` con nombres descriptivos.
- **Docker**: Prefiere Docker Compose para servicios (`make build`, `make run`).

## 🤖 Agentes LLM y Prompts
- **LangChain**: Usa `ChatPromptTemplate` para prompts estructurados.
- **Organización**: Prompts en `src/agent_rag/prompts/{component}/{modelo}.py`.
- **Carga dinámica**: Usa `load_prompt()` con fallbacks por modelo.
- **Nomenclatura**: Exports como `{COMPONENT}_PROMPT` y `{COMPONENT}_CHAT_PROMPT`.

## ⚙️ Configuración
- **Variables de entorno**: Define en `.env.example` con categorías claras.
- **Settings**: Usa `Pydantic BaseModel` para configuración con validación.
- **Valores por defecto**: Siempre proporciona defaults sensatos.
- **Tipos de datos**: Maneja automáticamente bool, int, list desde env vars.

## 📚 Referencias y Mejores Prácticas

### 🎯 Prompt Engineering
- **XML Tags**: Sigue las técnicas de Anthropic para estructurar prompts con XML tags: https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/use-xml-tags
- **Guía completa**: Consulta la guía de prompting para técnicas avanzadas: https://www.promptingguide.ai/es
- **Estructuración**: Usa delimitadores claros (`<thinking>`, `<context>`, `<instructions>`) en prompts complejos.
- **Few-shot examples**: Incluye ejemplos cuando sea necesario para claridad.

### 🔧 Patrones de Código
- **Separation of concerns**: Mantén lógica de negocio separada de configuración.
- **Error handling**: Siempre incluye manejo de errores con logging apropiado.
- **Caching**: Usa `@lru_cache` para funciones costosas que se llaman repetidamente.
- **Type safety**: Prefiere validación con Pydantic sobre validación manual.
