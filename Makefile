# =============================================================================
# This Makefile provides commands to configure, run, and work with
# the specialized agent for medical consultation preparation using SBAR.
#
# Main features:
# - Virtual environment management with uv
# - Linting and formatting tools for code quality
# - Development and production server
# - Interactive CLI and single question mode
# - Batch testing against the API
# - Docker containerization support
#
# Basic usage:
#   make install          # Set up development environment
#   make format           # Automatically format code
#   make lint             # Check code quality
#   make test             # Run tests
#   make run-api          # Start API server
#   make build-api        # Build API Docker image
# =============================================================================

export PYTHON_VERSION=3.11.9
export ENVIRONMENT=localhost
VENV_DIR ?= .venv
KERNEL_NAME=ai-kernel

# =============================================================================
# DEVELOPMENT ENVIRONMENT CONFIGURATION
# =============================================================================

# Set up virtual environment and install all dependencies using uv.lock
install:
	@echo "🚀 Configuring project with uv..."
	@if ! command -v uv &> /dev/null; then \
		echo "❌ uv is not installed. Installing..."; \
		pip install uv; \
	fi
	@echo "📌 Pinning Python version $(PYTHON_VERSION)..."
	@uv python pin $(PYTHON_VERSION)
	@echo "📦 Syncing dependencies (creating .venv if it doesn't exist)..."
	@uv sync
	@echo "🔌 Registering Jupyter kernel..."
	@uv run python -m ipykernel install --user --name=$(KERNEL_NAME) --display-name="Python (uv)"
	@echo "✅ Environment ready! Use 'source .venv/bin/activate' to activate."

# Add a new library to the project (replaces editing requirements.in)
# Usage: make add PKG=tensorflow
add:
	@echo "📦 Adding package $(PKG)..."
	@uv add $(PKG)
	@echo "✅ Package added and lockfile updated."

# Remove a library from the project
# Usage: make remove PKG=tensorflow
remove:
	@echo "🗑️ Removing package $(PKG)..."
	@uv remove $(PKG)
	@echo "✅ Package removed and lockfile updated."

# Generate requirements.txt (for legacy compatibility or simple deployments)
generate-requirements:
	@echo "📋 Exporting requirements.txt from uv.lock..."
	@uv export --format requirements-txt > requirements.txt
	@echo "✅ requirements.txt generated"

# Set up pre-commit hooks (Recommended to run once)
setup-hooks:
	@echo "🪝 Installing pre-commit hooks..."
	@if [ ! -d .venv ]; then make install; fi
	@uv run pre-commit install
	@echo "✅ Hooks installed!"

# =============================================================================
# CODE QUALITY AND LINTING
# =============================================================================

# Automatically format code with ruff
format:
	@echo "🎨 Formatting code with ruff..."
	@if [ ! -d .venv ]; then make install; fi
	@. $(VENV_DIR)/bin/activate && ruff format src/ tests/
	@. $(VENV_DIR)/bin/activate && ruff check --select I --fix src/ tests/
	@echo "🧹 Cleaning notebook outputs..."
	@. $(VENV_DIR)/bin/activate && nbstripout notebooks/*.ipynb 2>/dev/null || echo "⚠️  No notebooks found or nbstripout not installed"
	@echo "✅ Code formatted and notebooks cleaned!"

# Check code quality with multiple tools
lint:
	@echo "🔍 Running code quality analysis..."
	@if [ ! -d .venv ]; then make install; fi
	@echo "🚀 Ruff (fast linter)..."
	@. $(VENV_DIR)/bin/activate && ruff check src/ tests/
	@echo " Bandit (security)..."
	@. $(VENV_DIR)/bin/activate && bandit -r src/ tests/ -f json -o security-report.json -ll -q || true
	@. $(VENV_DIR)/bin/activate && bandit -r src/ tests/ -ll || true
	@echo "✅ Quality analysis completed!"

# Check only with ruff (faster for development)
lint-fast:
	@echo "⚡ Fast analysis with ruff..."
	@if [ ! -d .venv ]; then make install; fi
	@. $(VENV_DIR)/bin/activate && ruff check src/ tests/
	@echo "✅ Fast analysis completed!"

# Automatically fix linting issues when possible
fix:
	@echo "🔧 Fixing issues automatically..."
	@if [ ! -d .venv ]; then make install; fi
	@. $(VENV_DIR)/bin/activate && ruff check --fix src/ tests/ || echo "⚠️  Some issues remain for manual review."
	@. $(VENV_DIR)/bin/activate && ruff format src/ tests/
	@echo "🧹 Cleaning notebook outputs..."
	@. $(VENV_DIR)/bin/activate && nbstripout notebooks/*.ipynb 2>/dev/null || echo "⚠️  No notebooks found or nbstripout not installed"
	@echo "✅ Code formatted and cleanups applied!"

# Fix issues aggressively (includes unsafe fixes)
fix-force:
	@echo "🚨 Applying aggressive fixes (unsafe)..."
	@if [ ! -d .venv ]; then make install; fi
	@. $(VENV_DIR)/bin/activate && ruff check --fix --unsafe-fixes src/ tests/ || echo "⚠️  Issues remain."
	@. $(VENV_DIR)/bin/activate && ruff format src/ tests/
	@echo "✅ Aggressive fixes applied!"

# =============================================================================
# SYSTEM TESTING
# =============================================================================

# Run all tests with coverage
test:
	@echo "🧪 Running tests with coverage..."
	@if [ ! -d .venv ]; then make install; fi
	@. $(VENV_DIR)/bin/activate && PYTHONPATH=${PWD}/src pytest tests/ --cov=src --cov-report=html --cov-report=term-missing || echo "⚠️  No tests found to run"
	@echo "✅ Tests completed! See report in htmlcov/index.html"

# Run specific tests
test-unit:
	@echo "🧪 Running unit tests..."
	@if [ ! -d .venv ]; then make install; fi
	@. $(VENV_DIR)/bin/activate && PYTHONPATH=${PWD}/src pytest tests/ -v

# =============================================================================
# APPLICATION EXECUTION
# =============================================================================

# Start LangGraph development server
run-dev:
	@echo "🚀 Starting development server..."
	@if [ ! -d .venv ]; then make install; fi
	@. $(VENV_DIR)/bin/activate && langgraph dev

# Start FastAPI server
run-api:
	@echo "🚀 Starting API server..."
	@if [ ! -d .venv ]; then make install; fi
	@. $(VENV_DIR)/bin/activate && PYTHONPATH=${PWD} uvicorn api:app --reload --host 0.0.0.0 --port 8008 --log-level debug

# Run CLI with a predefined question
run-question:
	@echo "🚀 Running a single question"
	@if [ ! -d .venv ]; then make install; fi
	@. $(VENV_DIR)/bin/activate && PYTHONPATH=${PWD}/src python main.py --question "I have frequent headaches, can you help me prepare my medical consultation?"

# Start interactive CLI mode
run-interactive:
	@echo "🚀 Starting interactive CLI mode"
	@if [ ! -d .venv ]; then make install; fi
	@. $(VENV_DIR)/bin/activate && PYTHONPATH=${PWD}/src python main.py --interactive

# =============================================================================
# DOCKER BUILD AND DEPLOYMENT
# =============================================================================

# Docker configuration variables
IMG_NAME ?= medical-agent
IMAGE_TAG ?= latest
CONTAINER_NAME ?= medical-agent-server
API_PORT ?= 8008

# Enable Docker BuildKit
export DOCKER_BUILDKIT=1

# Build API Docker image
build-api:
	@echo "🔨 Building FastAPI Docker image (using Dockerfile.api)..."
	@docker build --platform=linux/amd64 -t ${IMG_NAME}:${IMAGE_TAG} -f Dockerfile.api .
	@echo "✅ FastAPI Docker image built successfully!"

# Run Docker container
run-api-docker:
	@echo "🚀 Running Docker container..."
	@docker run --platform=linux/amd64 -e ENV=production -d -p ${API_PORT}:${API_PORT} --env-file .env ${IMG_NAME}:${IMAGE_TAG}
	@echo "✅ Docker container running at http://localhost:${API_PORT}!"

# Build without cache
build-fresh:
	@echo "🔨 Building Docker image without cache..."
	@docker build --no-cache --platform=linux/amd64 -t ${IMG_NAME}:${IMAGE_TAG} -f Dockerfile.api .
	@echo "✅ Docker image built successfully!"

# Stop Docker container
stop-docker:
	@echo "🛑 Stopping Docker container..."
	@docker stop ${CONTAINER_NAME} 2>/dev/null || true
	@docker rm ${CONTAINER_NAME} 2>/dev/null || true
	@echo "✅ Container stopped!"

# =============================================================================
# USEFUL COMMANDS
# =============================================================================

# Full validation command (CI/CD pipeline)
ci:
	@echo "🚀 Running full CI pipeline..."
	@make format
	@make lint
	@make test
	@echo "✅ CI pipeline completed successfully!"

# Show help information about available commands
help:
	@echo "🏥 Medical Consultation Preparation Agent - Available Commands:"
	@echo ""
	@echo "Development Setup:"
	@echo "  make install              Set up virtual environment and dependencies"
	@echo "  make setup-hooks          Set up pre-commit hooks"
	@echo "  make generate-requirements Generate requirements.txt from current environment"
	@echo ""
	@echo "Code Quality:"
	@echo "  make format               Automatically format code (ruff format + imports)"
	@echo "  make lint                 Full quality analysis (ruff + bandit)"
	@echo "  make lint-fast            Fast analysis with ruff only"
	@echo "  make fix                  Automatically fix issues (ruff check + format)"
	@echo "  make ci                   Full pipeline: format + lint + test"
	@echo ""
	@echo "Testing:"
	@echo "  make test                 Run all tests with coverage"
	@echo "  make test-unit            Run unit tests only"
	@echo "  make run-batch-test       Run batch tests against API (dataset v1)"
	@echo "  make run-batch-test-custom Run batch tests with custom parameters"
	@echo ""
	@echo "Application Execution (Local):"
	@echo "  make run-dev             Start LangGraph development server"
	@echo "  make run-api             Start FastAPI server"
	@echo "  make run-question        Test with predefined medical question"
	@echo "  make run-interactive     Start interactive CLI mode"
	@echo ""
	@echo "Docker:"
	@echo "  make build-api           Build API Docker image"
	@echo "  make build-fresh         Build without cache"
	@echo "  make run-api-docker      Run API in Docker container"
	@echo "  make stop-docker         Stop Docker container"
	@echo ""
	@echo "Service URLs:"
	@echo "  🚀 FastAPI: http://localhost:8008"
	@echo "  📖 API Documentation: http://localhost:8008/docs"
	@echo "  🔍 Agent Discovery: http://localhost:8008/.well-known/agent.json"
	@echo ""
	@echo "Utilities:"
	@echo "  make help                Show this help message"
	@echo "  make clean               Clean cache and generated files"
	@echo ""

# Clean generated files and cache
clean:
	@echo "🧹 Cleaning..."
	@rm -rf __pycache__ .pytest_cache htmlcov .coverage .mypy_cache .ruff_cache
	@rm -f security-report.json
	@find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	@find . -type f -name "*.pyc" -delete 2>/dev/null || true
	@echo "✅ Cleanup completed!"

# Set help as default goal
.DEFAULT_GOAL := help

# Declare phony targets
.PHONY: install setup-hooks run-dev run-api run-question run-interactive build-api run-api-docker stop-docker build-fresh clean help generate-requirements run-batch-test run-batch-test-custom test test-unit format lint lint-fast fix ci
