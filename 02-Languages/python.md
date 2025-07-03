# Python Rules

## Environment Management
- Check for existing virtual environment (venv, conda, pipenv, poetry)
- Use existing dependency management tool
- Check `requirements.txt`, `pyproject.toml`, or `environment.yml`
- Maintain Python version compatibility

## Package Management
```bash
# pip
pip install -r requirements.txt
pip freeze > requirements.txt

# Poetry
poetry install
poetry add package-name

# Pipenv
pipenv install
pipenv install package-name

# Conda
conda env create -f environment.yml
conda install package-name
```

## Code Style
- Follow PEP 8 style guidelines
- Use existing linting configuration (flake8, pylint, ruff)
- Maintain consistent import organization
- Use type hints when available

## Import Organization
```python
# Standard library imports
import os
import sys
from pathlib import Path

# Third-party imports
import numpy as np
import pandas as pd
import requests

# Local application imports
from .models import User
from .utils import helper_function
```

## Type Hints
```python
from typing import List, Dict, Optional, Union, Callable

def process_data(
    data: List[Dict[str, Union[str, int]]], 
    callback: Optional[Callable] = None
) -> Dict[str, int]:
    """Process data with optional callback."""
    result = {}
    for item in data:
        # Processing logic
        if callback:
            callback(item)
    return result
```

## Testing
- Use existing test framework (pytest, unittest)
- Follow existing test file patterns (`test_*.py`, `*_test.py`)
- Use existing fixtures and conftest.py
- Maintain test coverage

## Common Commands
```bash
# Run tests
pytest
python -m pytest
python -m unittest

# Linting
flake8
pylint
ruff check

# Formatting
black .
isort .

# Type checking
mypy
pyright
```

## Framework-Specific Rules

### Django
- Follow Django project structure
- Use existing models and migrations
- Implement proper URL patterns
- Use Django's built-in authentication
- Follow existing template structure

### FastAPI
- Use existing dependency injection patterns
- Implement proper Pydantic models
- Use existing middleware configuration
- Follow OpenAPI documentation standards

### Flask
- Use existing application factory pattern
- Implement proper blueprints
- Use existing configuration management
- Follow existing template structure

## Data Science Projects
```python
# Jupyter notebooks
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

# Standard data analysis structure
def load_data(filepath: str) -> pd.DataFrame:
    """Load and validate data."""
    return pd.read_csv(filepath)

def clean_data(df: pd.DataFrame) -> pd.DataFrame:
    """Clean and preprocess data."""
    return df.dropna()

def analyze_data(df: pd.DataFrame) -> Dict:
    """Perform data analysis."""
    return df.describe().to_dict()
```

## Error Handling
```python
# Specific exceptions
try:
    with open('file.txt', 'r') as f:
        content = f.read()
except FileNotFoundError:
    logging.error("File not found")
    raise
except PermissionError:
    logging.error("Permission denied")
    raise

# Context managers
from contextlib import contextmanager

@contextmanager
def database_connection():
    conn = create_connection()
    try:
        yield conn
    finally:
        conn.close()
```

## Logging
```python
import logging

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

logger = logging.getLogger(__name__)

def process_data():
    logger.info("Starting data processing")
    try:
        # Processing logic
        logger.info("Data processing completed")
    except Exception as e:
        logger.error(f"Data processing failed: {e}")
        raise
```

## File Organization
```
project/
├── src/
│   ├── __init__.py
│   ├── main.py
│   ├── models/
│   ├── services/
│   ├── utils/
│   └── tests/
├── requirements.txt
├── pyproject.toml
├── README.md
└── .gitignore
```

## Best Practices
- Use `pathlib` for file operations
- Implement proper configuration management
- Use dataclasses for structured data
- Implement proper exception handling
- Write docstrings for modules, classes, and functions
- Use `with` statements for resource management

---
Tags: #python #django #fastapi #flask #pytest #data-science #rules