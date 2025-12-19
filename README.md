# Python ML Base Project

A modern Python base project template with best practices for machine learning and data science development.

## 🚀 Features

- **Modern Python 3.11** setup with virtual environment management
- **Ruff** for ultra-fast linting and formatting (replaces Black, Flake8, isort, pyupgrade)
- **Jupyter Notebooks** support with automated cleanup
- **Makefile** commands for common development tasks
- **Testing** setup with pytest and coverage
- **Security scanning** with Bandit
- **Docker** support for containerization

## 📋 Prerequisites

- Python 3.11.9+
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

```bash
# Create virtual environment and install dependencies
make install

# Activate virtual environment
source .venv/bin/activate
```

### 2. Code Quality

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

### 3. Testing

```bash
# Run all tests with coverage
make test

# Run unit tests only
make test-unit
```

### 4. Jupyter Notebooks

```bash
# After installation, select the kernel "Python (uv)" in Jupyter
# Notebooks are stored in notebooks/
# Outputs are automatically cleaned with nbstripout
```

## 📁 Project Structure

```
.
├── src/                    # Source code
├── tests/                  # Test files
├── notebooks/              # Jupyter notebooks
├── Makefile               # Development commands
├── pyproject.toml         # Project configuration (Ruff, pytest, coverage)
├── requirements.in        # Direct dependencies
└── README.md              # This file
```

## 🔧 Available Commands

| Command | Description |
|---------|-------------|
| `make install` | Setup virtual environment and install dependencies |
| `make format` | Format code with Ruff |
| `make lint` | Run code quality checks |
| `make lint-fast` | Quick Ruff-only analysis |
| `make fix` | Auto-fix linting issues |
| `make test` | Run tests with coverage |
| `make ci` | Run full CI pipeline |
| `make clean` | Remove cache and generated files |
| `make help` | Show all available commands |

## 🎯 Code Quality Tools

This project uses **Ruff** - a blazing fast Python linter and formatter written in Rust:

- **Formatting**: Compatible with Black (88 character line length)
- **Import sorting**: Replaces isort
- **Linting**: Includes rules from Flake8, pyupgrade, bugbear, and more
- **Speed**: 10-100x faster than traditional tools

Configuration is centralized in `pyproject.toml`.

## 📦 Managing Dependencies

```bash
# Add a new dependency
echo "package-name" >> requirements.in
make install

# Generate requirements.txt
make generate-requirements
```

## 🐳 Docker Support

```bash
# Build Docker image (if Dockerfile exists)
make build-api

# Run in Docker
make run-api-docker

# Stop Docker container
make stop-docker
```

## 🧪 Development Workflow

1. **Add your code** in `src/`
2. **Write tests** in `tests/`
3. **Format code**: `make format`
4. **Check quality**: `make lint`
5. **Run tests**: `make test`
6. **Commit** your changes

## 📝 Configuration

- **Ruff**: `pyproject.toml` - [tool.ruff]
- **Pytest**: `pyproject.toml` - [tool.pytest.ini_options]
- **Coverage**: `pyproject.toml` - [tool.coverage]

## 🤝 Contributing

1. Create a new branch
2. Make your changes
3. Run `make ci` to ensure quality
4. Submit a pull request

## 📚 Additional Resources

- [Ruff Documentation](https://docs.astral.sh/ruff/)
- [uv Documentation](https://github.com/astral-sh/uv)
- [Python Best Practices](https://docs.python-guide.org/)

## 📄 License

This is a template project - customize as needed for your use case.
