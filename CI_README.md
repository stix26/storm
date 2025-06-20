# CI/CD Pipeline Documentation

This document describes the comprehensive CI/CD pipeline set up for the STORM project.

## Overview

The CI pipeline includes the following components:

1. **Python Tests & Linting** - Multi-version Python testing, code formatting, and linting
2. **Build Validation** - Package building and metadata validation
3. **Docker Validation** - Docker image building and testing
4. **SQL Validation** - SQL syntax checking and database connection analysis
5. **Security Analysis** - Security vulnerability scanning
6. **Integration Tests** - End-to-end functionality testing

## Workflow Triggers

The CI workflow runs on:
- Push to `main` or `develop` branches
- Pull requests to `main` or `develop` branches
- Manual trigger via GitHub Actions UI

## Jobs Breakdown

### 1. Python Tests (`python-tests`)

**Purpose**: Comprehensive Python code quality checks

**Features**:
- Multi-version Python testing (3.10, 3.11, 3.12)
- Code formatting with Black
- Linting with flake8
- Type checking with mypy
- Security scanning with bandit
- Vulnerability checking with safety
- Test execution with pytest
- Coverage reporting

**Tools Used**:
- `black` - Code formatting
- `flake8` - Linting
- `mypy` - Type checking
- `bandit` - Security scanning
- `safety` - Vulnerability checking
- `pytest` - Testing framework

### 2. Build Validation (`build-validation`)

**Purpose**: Validate package building and distribution

**Features**:
- Version consistency checking
- Package building with setuptools
- Metadata validation with twine
- Package structure validation

**Checks**:
- Version numbers match between `setup.py` and `__init__.py`
- Package builds successfully
- Package metadata is valid
- Required files are included in distribution

### 3. Docker Validation (`docker-validation`)

**Purpose**: Validate Docker containerization

**Features**:
- Dockerfile syntax validation
- Docker image building
- Container functionality testing
- Health check validation

**Checks**:
- Dockerfile exists and is valid
- Image builds successfully
- Package imports work in container
- Health checks pass

### 4. SQL Validation (`sql-validation`)

**Purpose**: Validate SQL-related code and files

**Features**:
- SQL file syntax checking
- Database connection code analysis
- SQL injection vulnerability detection

**Checks**:
- SQL files have valid syntax
- Database connection patterns are identified
- No obvious SQL injection vulnerabilities

### 5. Security Analysis (`security-analysis`)

**Purpose**: Comprehensive security scanning

**Features**:
- Code security scanning with bandit
- Dependency vulnerability checking
- Security report generation

**Tools Used**:
- `bandit` - Python security linter
- `safety` - Dependency vulnerability checker
- `pip-audit` - Package vulnerability auditor

### 6. Integration Tests (`integration-tests`)

**Purpose**: End-to-end functionality testing

**Features**:
- Package import testing
- Module functionality testing
- Example script validation

**Checks**:
- All modules can be imported
- Basic functionality works
- Example scripts compile correctly

## Local Development

### Running CI Checks Locally

Use the provided Makefile to run CI checks locally:

```bash
# Install development dependencies
make install-dev

# Run all CI checks
make ci-local

# Run individual checks
make format-check
make lint
make type-check
make security
make test
make build
make docker-build
```

### Docker Development

```bash
# Build Docker image
make docker-build

# Run container
make docker-run

# Run tests in Docker
make docker-test

# Use docker-compose
make docker-compose-up
make docker-compose-test
make docker-compose-down
```

## Configuration Files

### `.flake8`
Configures flake8 linting rules and exclusions.

### `pyproject.toml`
Centralized configuration for:
- Black code formatting
- MyPy type checking
- Pytest testing
- Coverage reporting
- Bandit security scanning
- Safety vulnerability checking

### `Dockerfile`
Multi-stage Docker build for production deployment.

### `docker-compose.yml`
Local development environment with testing services.

### `Makefile`
Simplified commands for common development tasks.

## Security Reports

The CI pipeline generates several security reports:
- `bandit-report.json` - Code security analysis
- `safety-report.json` - Dependency vulnerability report
- `pip-audit-report.json` - Package vulnerability audit

These reports are uploaded as artifacts and can be downloaded from the GitHub Actions run page.

## Troubleshooting

### Common Issues

1. **Version Mismatch**: Ensure version numbers in `setup.py` and `knowledge_storm/__init__.py` match
2. **Import Errors**: Check that all dependencies are properly installed
3. **Docker Build Failures**: Verify Dockerfile syntax and dependencies
4. **Test Failures**: Run tests locally to debug issues

### Debugging Commands

```bash
# Check version consistency
make version-check

# Clean build artifacts
make clean

# Run specific test file
python -m pytest tests/test_basic_imports.py -v

# Check package structure
python -c "import knowledge_storm; print(knowledge_storm.__file__)"
```

## Contributing

When contributing to the project:

1. Ensure all CI checks pass locally before pushing
2. Follow the established code formatting standards
3. Add tests for new functionality
4. Update documentation as needed
5. Check security reports for any new vulnerabilities

## Monitoring

The CI pipeline provides:
- Real-time status updates in GitHub
- Detailed logs for each job
- Artifact downloads for reports
- Coverage reports and trends
- Security vulnerability tracking

Monitor the GitHub Actions tab for:
- Build status and history
- Performance metrics
- Failure analysis
- Security alerts 