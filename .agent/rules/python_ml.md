# 🤖 Agent Rules: Python ML & UV Workflow

## 🎯 Perfil de Comportamiento
- Eres un experto en Python y ML. Priorizas la eficiencia y el rendimiento.
- **Antes de sugerir comandos**, revisa siempre el `Makefile` del proyecto.
- **Interacción**: Responde al usuario en Español o Ingles dependiendo el idioma en que te pregunte.
- **Código y Documentación**: Todo el código, nombres de variables, docstrings y comentarios deben estar estrictamente en **Inglés**.

## 🔧 Gestión de Entorno y Herramientas (UV + Makefile)
- **Instalación**: Usa siempre `make install` (que ejecuta `uv sync`). No uses `pip` directamente.
- **Dependencias**: Para añadir paquetes, usa `make add PKG=<package>`.
- **Calidad de Código**: 
  - Formateo y Linting: Usa `make format` y `make lint` (basados en **Ruff** y **Bandit**).
  - Tests: Los archivos de prueba deben estar en `tests/`. Ejecuta `make test` para validar.

## 🐍 Desarrollo y Tipado
- **Estilo**: Código limpio, modular y documentado con **docstrings** (Google style).
- **Tipado**: Uso obligatorio de `Type hints`. Para validación de datos complejos, usa siempre `Pydantic`.
- **ML**: Para lógica de prompts, sigue la estructura en `src/agent_rag/prompts/`.

## 🛠️ Herramientas y Calidad
- **Linter/Formatter**: Usamos **Ruff**. Nunca sugieras `flake8` o `black` por separado.
- **Seguridad**: Ejecuta `bandit` mediante `make lint`.
- **Prompts**: Estructura siempre con XML tags (`<thinking>`, `<context>`) siguiendo las guías de Anthropic/Gemini.

## 📂 Estructura del Repositorio
- `src/`: Código fuente productivo. Sigue el principio de Responsabilidad Única (SRP).
- `notebooks/`: Únicamente para exploración y prototipado rápido de Data Science.
- `data/raw/`: Datos originales e inmutables. No se debe escribir aquí.
- `data/processed/`: Datos transformados listos para entrenamiento.
- `src/agent_rag/prompts/`: Carpeta específica para la gestión de prompts.

## 🏗️ Diseño y Modularidad
- **SRP**: Cada módulo o clase debe tener una sola razón para cambiar.
- **Pydantic**: Usa `BaseModel` para configuraciones y validación de datos.
- **Evita el Over-engineering**: No fragmentes el código en archivos minúsculos a menos que tengan ciclos de vida distintos.
- **Prompts**: Estructura los prompts complejos usando **XML tags** (`<thinking>`, `<context>`, `<instructions>`).

## 📋 Checklist de Validación de Planes
Antes de finalizar un plan, asegúrate de:
1. ¿El código está en inglés?
2. ¿Se han ejecutado los tests especificos o el linter (`make lint`)?
3. ¿La lógica de datos respeta la jerarquía raw/processed?