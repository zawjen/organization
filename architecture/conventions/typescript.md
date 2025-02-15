# TypeScript Code Conventions

## 1. Project Structure

```
📦 src
 ┣ 📂 models
 ┃ ┣ 📜 user.model.ts
 ┣ 📂 services
 ┃ ┣ 📜 user.service.ts
 ┣ 📂 controllers
 ┃ ┣ 📜 user.controller.ts
 ┣ 📂 utils
 ┃ ┣ 📜 helper.ts
 ┣ 📜 index.ts
 ┗ 📜 config.ts
```

## 2. Naming Conventions

- **Files:** Use `kebab-case`, e.g., `user.service.ts`
- **Classes:** Use `PascalCase`, e.g., `UserService`
- **Interfaces:** Prefix with `I`, e.g., `IUser`
- **Constants:** Use `UPPER_CASE`, e.g., `JWT_SECRET`
- **Functions & Variables:** Use `camelCase`, e.g., `getUserById`
- **Enums:** Use `PascalCase` for names and `UPPER_CASE` for values

## 3. Type Annotations & Interfaces

- Always use explicit type annotations when possible
- Use interfaces instead of type aliases where applicable

```ts
interface IUser {
  id: number;
  name: string;
  email: string;
}
```

## 4. Functions

- Use arrow functions for short callbacks
- Prefer function declarations for named functions

```ts
const add = (a: number, b: number): number => a + b;

function getUser(id: number): IUser {
  return { id, name: 'John Doe', email: 'john@example.com' };
}
```

## 5. Classes

- Use `private` and `readonly` modifiers when applicable

```ts
class UserService {
  private users: IUser[] = [];

  addUser(user: IUser): void {
    this.users.push(user);
  }
}
```

## 6. Modules & Imports

- Use ES module syntax
- Keep imports organized: standard libraries first, third-party libraries, then local modules

```ts
import fs from 'fs';
import express from 'express';
import { UserService } from './services/user.service';
```

## 7. Error Handling

- Use `try/catch` blocks for asynchronous code

```ts
async function fetchData(): Promise<void> {
  try {
    const response = await fetch('https://api.example.com/data');
    const data = await response.json();
    console.log(data);
  } catch (error) {
    console.error('Error fetching data', error);
  }
}
```

## 8. Linting & Formatting

- Use ESLint and Prettier for consistent formatting

```json
{
  "extends": ["eslint:recommended", "plugin:@typescript-eslint/recommended"],
  "rules": {
    "@typescript-eslint/no-unused-vars": "warn",
    "prettier/prettier": "error"
  }
}
```

## 9. Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat(user): add user service
fix(auth): resolve token expiration issue
chore(deps): update dependencies
```

---

By following these conventions, TypeScript projects remain clean, maintainable, and scalable.

