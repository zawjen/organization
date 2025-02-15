# Python Code Conventions

## 1. Project Structure

```
📦 project_name
 ┣ 📂 src
 ┃ ┣ 📂 modules
 ┃ ┃ ┣ 📜 user.py
 ┃ ┣ 📂 services
 ┃ ┃ ┣ 📜 user_service.py
 ┃ ┣ 📂 utils
 ┃ ┃ ┣ 📜 helper.py
 ┣ 📂 tests
 ┃ ┣ 📜 test_user.py
 ┣ 📜 main.py
 ┣ 📜 requirements.txt
 ┣ 📜 README.md
```

## 2. Naming Conventions

- **Files & Modules:** Use `snake_case`, e.g., `user_service.py`
- **Classes:** Use `PascalCase`, e.g., `UserService`
- **Functions & Variables:** Use `snake_case`, e.g., `get_user_data`
- **Constants:** Use `UPPER_CASE`, e.g., `API_BASE_URL`
- **Private Variables:** Prefix with `_`, e.g., `_cache`

## 3. Type Annotations

- Use type hints for function arguments and return types

```python
from typing import List

def get_users() -> List[str]:
    return ["Alice", "Bob"]
```

## 4. Functions & Methods

- Keep functions small and focused
- Use docstrings for documentation

```python
def fetch_data(url: str) -> dict:
    """Fetch data from a given URL and return as dictionary."""
    response = requests.get(url)
    return response.json()
```

## 5. Classes

- Use `@dataclass` for simple data storage classes

```python
from dataclasses import dataclass

@dataclass
class User:
    id: int
    name: str
    email: str
```

## 6. Exception Handling

- Handle exceptions properly using `try-except`

```python
try:
    data = fetch_data("https://api.example.com")
except Exception as e:
    print(f"Error fetching data: {e}")
```

## 7. Logging

- Use `logging` instead of `print`

```python
import logging

logging.basicConfig(level=logging.INFO)
logging.info("Application started")
```

## 8. Testing

- Use `pytest` for testing

```python
def test_addition():
    assert 1 + 1 == 2
```

## 9. Code Formatting

- Use `black` and `flake8` for formatting and linting

```bash
black .
flake8 .
```

## 10. Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat(user): add user service
fix(auth): resolve login bug
chore(deps): update dependencies
```

---

By following these conventions, Python projects remain clean, maintainable, and scalable.

