# Jest Code Conventions

## 1. Project Structure

```
📦 src
 ┣ 📂 components
 ┃ ┣ 📜 Button.tsx
 ┣ 📂 tests
 ┃ ┣ 📜 button.test.ts
 ┣ 📜 jest.config.js
 ┣ 📜 package.json
 ┗ 📜 tsconfig.json
```

## 2. Naming Conventions

- **Test files:** Use `.test.ts` or `.spec.ts`, e.g., `button.test.ts`
- **Test Suites:** Use `describe` blocks with a meaningful name
- **Test Cases:** Use `it` or `test` with a clear description

## 3. Writing Tests

- Use `expect` for assertions
- Keep tests small and focused

```ts
import { render, screen } from '@testing-library/react';
import Button from '../components/Button';

describe('Button Component', () => {
  it('renders the button correctly', () => {
    render(<Button label="Click me" />);
    expect(screen.getByText('Click me')).toBeInTheDocument();
  });
});
```

## 4. Mocks & Spies

- Use `jest.fn()` to create mock functions
- Use `jest.spyOn()` to track method calls

```ts
const mockFn = jest.fn();
mockFn();
expect(mockFn).toHaveBeenCalled();
```

```ts
const obj = { method: () => 'real' };
const spy = jest.spyOn(obj, 'method');
obj.method();
expect(spy).toHaveBeenCalled();
```

## 5. Testing Asynchronous Code

- Use `async/await` with `expect`

```ts
test('fetches data successfully', async () => {
  const data = await fetchData();
  expect(data).toEqual({ id: 1, name: 'John' });
});
```

## 6. Setup & Teardown

- Use `beforeEach` and `afterEach` for setup/cleanup

```ts
beforeEach(() => {
  // Setup logic
});

afterEach(() => {
  // Cleanup logic
});
```

## 7. Snapshot Testing

- Use Jest snapshots for UI components

```ts
test('matches snapshot', () => {
  const tree = renderer.create(<Button label="Click" />).toJSON();
  expect(tree).toMatchSnapshot();
});
```

## 8. Coverage Reports

- Enable coverage reports in `jest.config.js`

```js
module.exports = {
  collectCoverage: true,
  coverageDirectory: 'coverage',
};
```

Run tests with coverage:
```bash
jest --coverage
```

## 9. Running Tests

- Run all tests: `yarn test`
- Watch mode: `yarn test -- --watch`
- Run a single test file: `jest button.test.ts`

## 10. Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat(button): add snapshot tests
fix(form): resolve validation issue
chore(tests): improve coverage
```

---

By following these conventions, Jest tests remain clean, maintainable, and effective.

