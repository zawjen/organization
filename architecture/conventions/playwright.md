# Playwright Guide for End-to-End Testing

## 1. Introduction
Playwright is a powerful end-to-end testing framework that supports multiple browsers, including Chromium, Firefox, and WebKit. It enables automated testing with fast execution, parallel testing, and robust debugging features.

---

## 2. Installation

### Prerequisites
- Node.js (v14+ recommended)

### Install Playwright
```bash
npm init playwright@latest
```

or manually install it:
```bash
npm install --save-dev @playwright/test
```

### Install Browsers
```bash
npx playwright install
```

---

## 3. Project Structure
```
my-playwright-project/
├── tests/              # Test files
│   ├── example.spec.ts # Example test
├── playwright.config.ts # Playwright configuration
├── package.json        # Dependencies and scripts
└── tsconfig.json       # TypeScript configuration
```

---

## 4. Writing Tests
Create a test file `tests/example.spec.ts`:
```ts
import { test, expect } from '@playwright/test';

test('should navigate to Google', async ({ page }) => {
  await page.goto('https://www.google.com');
  await expect(page).toHaveTitle(/Google/);
});
```

### Running Tests
```bash
npx playwright test
```

---

## 5. Configuration
Customize `playwright.config.ts`:
```ts
import { defineConfig } from '@playwright/test';

export default defineConfig({
  use: {
    headless: false, // Run in non-headless mode
    viewport: { width: 1280, height: 720 },
  },
  reporter: 'html', // Generates an HTML report
});
```

Run with configuration:
```bash
npx playwright test --config=playwright.config.ts
```

---

## 6. Interacting with Elements

### Clicking Elements
```ts
await page.click('text=Submit');
```

### Filling Inputs
```ts
await page.fill('#username', 'testuser');
```

### Taking Screenshots
```ts
await page.screenshot({ path: 'screenshot.png' });
```

---

## 7. Debugging

### Run in Debug Mode
```bash
npx playwright test --debug
```

### Inspect Elements
```ts
await page.pause();
```

### View Trace
```bash
npx playwright show-trace trace.zip
```

---

## 8. Parallel Testing
Enable parallel execution in `playwright.config.ts`:
```ts
export default defineConfig({
  workers: 4, // Run 4 tests in parallel
});
```

Run tests in parallel:
```bash
npx playwright test --shard=1/2
```

---

## 9. API Testing with Playwright
Playwright supports API testing alongside UI tests.

### Example API Test
```ts
test('should fetch user data', async ({ request }) => {
  const response = await request.get('https://jsonplaceholder.typicode.com/users/1');
  expect(response.status()).toBe(200);
  const data = await response.json();
  expect(data.name).toBe('Leanne Graham');
});
```

---

## 10. Continuous Integration (CI/CD)

### GitHub Actions Workflow
Create `.github/workflows/playwright.yml`:
```yaml
name: Playwright Tests
on: [push, pull_request]
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3
      - name: Install dependencies
        run: npm install
      - name: Install Playwright browsers
        run: npx playwright install
      - name: Run tests
        run: npx playwright test
```

---

## 11. Best Practices
- Use **selectors wisely** (prefer `data-testid` over fragile CSS selectors).
- **Enable retries** to handle flaky tests.
- **Run tests in parallel** for faster execution.
- **Use fixtures** for reusable test setups.
- **Store secrets securely** using environment variables.

---

### Conclusion
Playwright is a robust testing tool with excellent browser automation support. By following best practices and integrating with CI/CD, you can achieve efficient and reliable end-to-end testing.

