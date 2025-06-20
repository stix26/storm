.PHONY: help install test lint format clean build docker-build docker-run docker-test ci-local

help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Install dependencies
	pip install -r requirements.txt
	pip install -e .

install-dev: ## Install development dependencies
	pip install -r requirements.txt
	pip install pytest pytest-cov black flake8 mypy bandit safety pip-audit sqlparse
	pip install -e .

test: ## Run tests
	python -m pytest tests/ -v --cov=knowledge_storm --cov-report=html --cov-report=term

test-coverage: ## Run tests with coverage report
	python -m pytest tests/ -v --cov=knowledge_storm --cov-report=html --cov-report=xml

lint: ## Run linting checks
	flake8 knowledge_storm/ --count --select=E9,F63,F7,F82 --show-source --statistics
	flake8 knowledge_storm/ --count --exit-zero --max-complexity=10 --max-line-length=127 --statistics

format: ## Format code with Black
	black knowledge_storm/ examples/

format-check: ## Check code formatting
	black --check --diff knowledge_storm/ examples/

type-check: ## Run type checking with mypy
	mypy knowledge_storm/ --ignore-missing-imports --no-strict-optional

security: ## Run security checks
	bandit -r knowledge_storm/ -f json -o bandit-report.json
	safety check --json --output safety-report.json
	pip-audit --format json --output pip-audit-report.json

build: ## Build the package
	python -m build

clean: ## Clean build artifacts
	rm -rf build/
	rm -rf dist/
	rm -rf *.egg-info/
	rm -rf .pytest_cache/
	rm -rf .mypy_cache/
	rm -rf htmlcov/
	rm -rf .coverage
	rm -rf coverage.xml
	find . -type d -name __pycache__ -delete
	find . -type f -name "*.pyc" -delete

docker-build: ## Build Docker image
	docker build -t storm .

docker-run: ## Run Docker container
	docker run --rm storm

docker-test: ## Run tests in Docker
	docker run --rm storm python -m pytest tests/ -v

docker-compose-up: ## Start services with docker-compose
	docker-compose up -d

docker-compose-down: ## Stop docker-compose services
	docker-compose down

docker-compose-test: ## Run tests with docker-compose
	docker-compose run --rm storm-test

ci-local: ## Run all CI checks locally
	@echo "Running CI checks locally..."
	@echo "1. Format check..."
	@make format-check
	@echo "2. Linting..."
	@make lint
	@echo "3. Type checking..."
	@make type-check
	@echo "4. Security checks..."
	@make security
	@echo "5. Tests..."
	@make test
	@echo "6. Build check..."
	@make build
	@echo "7. Docker build..."
	@make docker-build
	@echo "✅ All CI checks passed!"

version-check: ## Check version consistency
	@echo "Checking version consistency..."
	@VERSION_SETUP=$$(grep -oP '(?<=version=\").*(?=\")' setup.py); \
	VERSION_INIT=$$(grep -oP '(?<=__version__ = \").*(?=\")' knowledge_storm/__init__.py); \
	echo "Version in setup.py: $$VERSION_SETUP"; \
	echo "Version in __init__.py: $$VERSION_INIT"; \
	if [ "$$VERSION_SETUP" != "$$VERSION_INIT" ]; then \
		echo "Error: Version mismatch!"; \
		exit 1; \
	else \
		echo "✅ Versions match!"; \
	fi

package-check: ## Check package metadata
	twine check dist/*

install-examples: ## Install example dependencies
	pip install streamlit

run-demo: ## Run the demo (if available)
	cd frontend/demo_light && streamlit run storm.py 