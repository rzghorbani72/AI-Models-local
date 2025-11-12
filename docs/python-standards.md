# Python 3.12+ - Latest Standards (Nov 2025)

## Python 3.12 Key Features

### Type Hints (PEP 692: TypedDict with Unpack)

```python
# ✅ Modern type hints with TypedDict
from typing import TypedDict, Unpack

class UserData(TypedDict):
    name: str
    email: str
    age: int

def create_user(**kwargs: Unpack[UserData]) -> dict:
    """Type-safe function with unpacked TypedDict."""
    return kwargs

# Type checker knows exactly what keys are expected
user = create_user(name="Alice", email="alice@example.com", age=30)
```

### Per-Interpreter GIL (PEP 703)

```python
# Python 3.12 allows disabling GIL per interpreter
import sys
import threading

# In Python 3.13+, can be disabled entirely
# For now in 3.12, use asyncio for concurrency
import asyncio

async def fetch_data(url: str) -> str:
    """Async/await is preferred for concurrent I/O."""
    # Simulated fetch
    await asyncio.sleep(1)
    return f"Data from {url}"

async def main():
    tasks = [
        fetch_data("https://api1.com"),
        fetch_data("https://api2.com"),
        fetch_data("https://api3.com"),
    ]
    results = await asyncio.gather(*tasks)
    return results

# asyncio.run(main())
```

### Deprecation Warnings Improvements

```python
# Python 3.12 shows the exact line of deprecated code
import warnings

# Clear deprecation warnings for migration planning
warnings.filterwarnings('error', category=DeprecationWarning)

# Use try-except to handle deprecated APIs gracefully
try:
    from typing import List  # Deprecated in 3.12, use list instead
except DeprecationWarning:
    pass  # Handle gracefully
```

---

## Modern Python Patterns

### Dataclasses (PEP 557)

```python
from dataclasses import dataclass, field
from datetime import datetime

@dataclass
class User:
    """Modern data container with automatic __init__, __repr__, etc."""
    id: str
    name: str
    email: str
    created_at: datetime = field(default_factory=datetime.now)
    tags: list[str] = field(default_factory=list)

    def add_tag(self, tag: str) -> None:
        """Add a tag to the user."""
        if tag not in self.tags:
            self.tags.append(tag)

# Usage
user = User(id="1", name="Alice", email="alice@example.com")
user.add_tag("vip")
print(user)  # Clean __repr__ output
```

### Pydantic v2 (For Validation)

```python
from pydantic import BaseModel, Field, ValidationError
from typing import Optional

class User(BaseModel):
    """Modern data validation with Pydantic v2."""
    id: str = Field(..., description="User ID")
    name: str = Field(..., min_length=1, max_length=100)
    email: str = Field(..., pattern=r'^[\w\.-]+@[\w\.-]+\.\w+$')
    age: Optional[int] = Field(None, ge=0, le=150)
    tags: list[str] = Field(default_factory=list)

    class Config:
        json_schema_extra = {
            "example": {
                "id": "123",
                "name": "Alice",
                "email": "alice@example.com",
                "age": 30,
                "tags": ["admin", "verified"]
            }
        }

# Validation automatically happens
try:
    user = User(id="1", name="Alice", email="invalid-email", age=30)
except ValidationError as e:
    print(e.errors())  # Clear validation errors
```

### Type Hints (Updated for 3.12)

```python
from typing import Callable, Sequence, Mapping, Never
from collections.abc import Iterator, Generator

# ✅ Use built-in generics (3.9+)
def process_items(items: list[str]) -> dict[str, int]:
    """Use list and dict directly, not List and Dict."""
    return {item: len(item) for item in items}

# ✅ Use collections.abc for abstract types
def iterate_data(data: Sequence[int]) -> Iterator[int]:
    """Accept any sequence, return iterator."""
    return iter(data)

# ✅ Use Never for functions that never return
def raise_error(message: str) -> Never:
    """Function that never returns normally."""
    raise ValueError(message)

# ✅ Optional with better syntax
from typing import Optional
def find_user(user_id: str) -> Optional[dict]:
    """Can return None."""
    return None

# ✅ Union with pipe operator (3.10+)
def parse_number(value: str | int | float) -> float:
    """Accept multiple types."""
    return float(value)
```

---

## Async/Await Best Practices

### Async Functions (Modern Approach)

```python
import asyncio
from typing import Coroutine
import aiohttp

async def fetch_user(user_id: str) -> dict:
    """Async function for I/O-bound operations."""
    # Simulated API call
    await asyncio.sleep(0.1)
    return {"id": user_id, "name": "Alice"}

async def fetch_multiple_users(user_ids: list[str]) -> list[dict]:
    """Fetch multiple users concurrently."""
    tasks = [fetch_user(uid) for uid in user_ids]
    return await asyncio.gather(*tasks)

async def main():
    """Entry point for async operations."""
    users = await fetch_multiple_users(["1", "2", "3"])
    print(users)

# Run with asyncio.run(main())
```

### Error Handling in Async Code

```python
import asyncio

async def risky_operation() -> str:
    """Operation that might fail."""
    await asyncio.sleep(0.1)
    raise ValueError("Something went wrong")

async def safe_wrapper() -> str:
    """Safely handle async errors."""
    try:
        return await risky_operation()
    except ValueError as e:
        print(f"Caught error: {e}")
        return "fallback value"

async def main():
    result = await safe_wrapper()
    print(result)

# asyncio.run(main())
```

---

## FastAPI Best Practices (Latest)

### Basic Setup (3.12 Compatible)

```python
from fastapi import FastAPI, HTTPException, Depends
from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime

app = FastAPI(
    title="My API",
    description="A modern API built with FastAPI",
    version="1.0.0"
)

# ✅ Use Pydantic for request/response models
class UserCreate(BaseModel):
    name: str = Field(..., min_length=1, max_length=100)
    email: str = Field(..., pattern=r'^[\w\.-]+@[\w\.-]+\.\w+$')

class UserResponse(BaseModel):
    id: str
    name: str
    email: str
    created_at: datetime

# ✅ Type hints for all parameters
@app.post("/users", response_model=UserResponse)
async def create_user(user: UserCreate) -> UserResponse:
    """Create a new user."""
    return UserResponse(
        id="123",
        name=user.name,
        email=user.email,
        created_at=datetime.now()
    )

# ✅ Path parameters with type hints
@app.get("/users/{user_id}", response_model=UserResponse)
async def get_user(user_id: str) -> UserResponse:
    """Get a user by ID."""
    # In practice, fetch from database
    if user_id == "invalid":
        raise HTTPException(status_code=404, detail="User not found")

    return UserResponse(
        id=user_id,
        name="Alice",
        email="alice@example.com",
        created_at=datetime.now()
    )

# ✅ Query parameters with defaults
@app.get("/users")
async def list_users(
    skip: int = 0,
    limit: int = 10,
    search: Optional[str] = None
) -> list[UserResponse]:
    """List users with pagination."""
    return []
```

### Dependency Injection (Modern Pattern)

```python
from fastapi import Depends, HTTPException
from typing import Annotated

# Define dependencies
async def get_current_user(token: str) -> dict:
    """Validate token and return user."""
    if not token.startswith("bearer_"):
        raise HTTPException(status_code=401, detail="Invalid token")
    return {"user_id": "123", "name": "Alice"}

# Use dependencies
@app.get("/profile")
async def get_profile(
    current_user: Annotated[dict, Depends(get_current_user)]
) -> dict:
    """Get current user's profile."""
    return current_user
```

### Error Handling

```python
from fastapi import HTTPException
from fastapi.responses import JSONResponse
from starlette.exceptions import HTTPException as StarletteHTTPException

@app.exception_handler(StarletteHTTPException)
async def http_exception_handler(request, exc: StarletteHTTPException):
    """Custom HTTP exception handler."""
    return JSONResponse(
        status_code=exc.status_code,
        content={
            "error": exc.detail,
            "status_code": exc.status_code,
            "path": str(request.url)
        }
    )

@app.post("/users")
async def create_user(user: UserCreate) -> UserResponse:
    """Create user with error handling."""
    if not user.email:
        raise HTTPException(status_code=400, detail="Email is required")
    return UserResponse(
        id="123",
        name=user.name,
        email=user.email,
        created_at=datetime.now()
    )
```

---

## Testing Patterns (Pytest)

### Unit Tests with Pytest

```python
# tests/test_user.py
import pytest
from datetime import datetime

class TestUserModel:
    """Test suite for User model."""

    def test_user_creation(self):
        """Test creating a user."""
        user = User(id="1", name="Alice", email="alice@example.com")
        assert user.id == "1"
        assert user.name == "Alice"

    def test_user_validation(self):
        """Test user validation with Pydantic."""
        with pytest.raises(ValidationError):
            User(id="1", name="", email="invalid")

    @pytest.fixture
    def sample_user(self) -> User:
        """Fixture providing a sample user."""
        return User(id="1", name="Alice", email="alice@example.com")

    def test_add_tag(self, sample_user: User):
        """Test adding tags to user."""
        sample_user.add_tag("vip")
        assert "vip" in sample_user.tags
```

### Async Testing

```python
import pytest
import asyncio

@pytest.mark.asyncio
async def test_fetch_user():
    """Test async function."""
    user = await fetch_user("1")
    assert user["id"] == "1"

@pytest.mark.asyncio
async def test_fetch_multiple():
    """Test concurrent fetches."""
    users = await fetch_multiple_users(["1", "2", "3"])
    assert len(users) == 3
```

---

## Common Patterns to Avoid

| ❌ Old (Avoid) | ✅ New (Use) | Why |
|---|---|---|
| `from typing import List` | `list[str]` | PEP 585: Built-in generics (3.9+) |
| `Optional[str]` | `str \| None` | Cleaner syntax (3.10+) |
| Callbacks | `async/await` | Better readability for I/O |
| `threading` | `asyncio` | Better for I/O, lighter weight |
| String formatting with `%` | f-strings | More readable and performant |
| `__future__` imports for annotations | Default in 3.10+ | Already available |
| Manual class `__init__` | `dataclasses` or `Pydantic` | Less boilerplate |

---

## Security Best Practices

### Input Validation

```python
from pydantic import BaseModel, validator, ValidationError
import re

class UserInput(BaseModel):
    username: str
    email: str
    password: str

    @validator('username')
    def username_alphanumeric(cls, v: str) -> str:
        """Ensure username is alphanumeric."""
        if not re.match(r'^[a-zA-Z0-9_]+$', v):
            raise ValueError('must be alphanumeric with underscores')
        return v

    @validator('password')
    def password_strong(cls, v: str) -> str:
        """Ensure password is strong."""
        if len(v) < 12:
            raise ValueError('must be at least 12 characters')
        if not any(c.isupper() for c in v):
            raise ValueError('must contain uppercase')
        return v
```

### SQL Injection Prevention

```python
# ❌ WRONG: String formatting
query = f"SELECT * FROM users WHERE id = {user_id}"

# ✅ CORRECT: Parameterized queries
import sqlite3
conn = sqlite3.connect(':memory:')
cursor = conn.cursor()
cursor.execute("SELECT * FROM users WHERE id = ?", (user_id,))
```

### Secrets Management

```python
import os
from dotenv import load_dotenv

# Load from .env file (never commit this!)
load_dotenv()

# Use environment variables
SECRET_KEY = os.getenv('SECRET_KEY')
DATABASE_URL = os.getenv('DATABASE_URL')

# Validate required secrets
if not SECRET_KEY:
    raise RuntimeError("SECRET_KEY environment variable must be set")
```

---

## Logging Best Practices

### Structured Logging

```python
import logging
import json
from typing import Any

# Configure logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

def structured_log(level: str, message: str, **extra: Any) -> None:
    """Log with structured data."""
    log_entry = {
        "message": message,
        "level": level,
        **extra
    }
    logger.log(getattr(logging, level), json.dumps(log_entry))

# Usage
structured_log(
    "INFO",
    "User created",
    user_id="123",
    email="alice@example.com"
)
```

---

## Environment Setup (3.12+)

### Virtual Environment

```bash
# Create virtual environment
python3.12 -m venv venv

# Activate
source venv/bin/activate  # Linux/Mac
# or
venv\Scripts\activate  # Windows

# Install dependencies
pip install -r requirements.txt
```

### requirements.txt (Modern)

```
fastapi==0.104.1
uvicorn==0.24.0
pydantic==2.5.0
sqlalchemy==2.0.23
pytest==7.4.3
pytest-asyncio==0.21.1
aiohttp==3.9.1
python-dotenv==1.0.0
```

---

## Resources

- Python 3.12 Release Notes: https://www.python.org/downloads/release/python-3120
- Type Hints PEP 692: https://peps.python.org/pep-0692
- FastAPI Docs: https://fastapi.tiangolo.com
- Pydantic v2: https://docs.pydantic.dev/latest
- Pytest: https://docs.pytest.org
- AsyncIO: https://docs.python.org/3/library/asyncio.html

**Last Updated:** November 2025
