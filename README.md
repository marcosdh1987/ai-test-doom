# Python ML Base Project

A modern Python base project template with best practices for machine learning and data science development.

## 🚀 Features

- **Modern Python 3.11** setup with `uv` for ultra-fast dependency management
- **Reproducible Environments** using `uv.lock`
- **Ruff** for ultra-fast linting and formatting (replaces Black, Flake8, isort, pyupgrade)
- **Jupyter Notebooks** support with automated cleanup (`nbstripout`)
- **Pre-commit hooks** to ensure quality before committing
- **Makefile** commands for common development tasks
- **Testing** setup with pytest and coverage
- **Docker** support for containerization

## 📋 Prerequisites

- Python 3.11+
- [uv](https://github.com/astral-sh/uv) - Fast Python package installer
- Make

### Install uv

```bash
# macOS/Linux
curl -LsSf https://astral.sh/uv/install.sh | sh

# Or with pip
pip install uv
```

## 🛠️ Quick Start

### 1. Setup Development Environment

This command will install the specific Python version defined in the Makefile, create the virtual environment, and sync all dependencies from `uv.lock`.

```bash
# Setup project
make install

# Activate virtual environment
source .venv/bin/activate
```

### 2. Setup Git Hooks (Recommended)

Install pre-commit hooks to automatically clean notebooks and format code before every commit.

```bash
make setup-hooks
```

### 3. Jupyter Notebooks

After running `make install`, a kernel named "Python (uv)" will be automatically registered.

```bash
# Start Jupyter
uv run jupyter lab
```

## 📦 Managing Dependencies

We use `uv` to manage dependencies in `pyproject.toml` and lock them in `uv.lock`.

### Add a new library

Instead of editing files manually, use the helper command:

```bash
# Add a package (e.g., tensorflow)
make add PKG=tensorflow

# Add a development dependency
make add PKG="pytest --dev"
```

This will:
1. Add the package to `pyproject.toml`
2. Update `uv.lock`
3. Install the package in your environment

### Remove a library

To remove a package you no longer need:

```bash
make remove PKG=tensorflow
```

### Generate requirements.txt

If you need a `requirements.txt` for legacy systems or deployment:

```bash
make generate-requirements
```

## 🎯 Code Quality

```bash
# Format code with Ruff
make format

# Run linting checks
make lint

# Auto-fix issues
make fix

# Run full CI pipeline (format + lint + test)
make ci
```

## 📁 Project Structure

```
.
├── src/                    # Source code
├── tests/                  # Test files
├── notebooks/              # Jupyter notebooks
├── Makefile               # Development commands
├── pyproject.toml         # Project configuration & dependencies
├── uv.lock                # Exact versions lockfile (DO NOT EDIT MANUALLY)
├── .pre-commit-config.yaml # Git hooks configuration
├── .editorconfig          # Editor formatting rules
└── README.md              # This file
```

## 🔧 Available Commands

| Command | Description |
|---------|-------------|
| `make install` | Setup environment, install python version and sync dependencies |
| `make add PKG=x` | Add a new dependency to the project |
| `make remove PKG=x` | Remove a dependency from the project |
| `make setup-hooks` | Install pre-commit hooks for git |
| `make format` | Format code with Ruff |
| `make lint` | Run code quality checks |
| `make fix` | Auto-fix linting issues |
| `make test` | Run tests with coverage |
| `make ci` | Run full CI pipeline |
| `make generate-requirements` | Export `uv.lock` to `requirements.txt` |
| `make clean` | Remove cache and generated files |
| `make help` | Show all available commands |

## 🐳 Docker Support

```bash
# Build Docker image
make build-api

# Run in Docker
make run-api-docker

# Stop Docker container
make stop-docker
```

## 📝 Configuration

- **Dependencies**: `pyproject.toml` - `[project.dependencies]`
- **Ruff**: `pyproject.toml` - `[tool.ruff]`
- **Pytest**: `pyproject.toml` - `[tool.pytest.ini_options]`
- **Editor**: `.editorconfig`

## 🤝 Contributing

1. Create a new branch
2. Make your changes
3. Run `make ci` to ensure quality
4. Submit a pull request

## 📄 License

This is a template project - customize as needed for your use case.
