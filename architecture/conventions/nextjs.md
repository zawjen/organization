# Next.js Code Conventions

## 1. Project Structure

```
📦 src
 ┣ 📂 components
 ┃ ┣ 📜 Header.tsx
 ┃ ┣ 📜 Footer.tsx
 ┣ 📂 pages
 ┃ ┣ 📜 index.tsx
 ┃ ┣ 📜 about.tsx
 ┣ 📂 hooks
 ┃ ┣ 📜 useAuth.ts
 ┣ 📂 utils
 ┃ ┣ 📜 fetcher.ts
 ┣ 📂 styles
 ┃ ┣ 📜 global.css
 ┣ 📜 next.config.js
 ┣ 📜 tsconfig.json
 ┗ 📜 .eslintrc.json
```

## 2. Naming Conventions

- **Files:** Use `kebab-case` for non-components, `PascalCase` for components
- **Components:** Use `PascalCase`, e.g., `Header.tsx`
- **Functions & Variables:** Use `camelCase`, e.g., `fetchUserData`
- **Constants:** Use `UPPER_CASE`, e.g., `API_BASE_URL`
- **Enums:** Use `PascalCase` for names and `UPPER_CASE` for values

## 3. Pages & Routing

- Place pages inside `pages/` directory
- Use file-based routing, e.g., `pages/about.tsx` → `/about`
- Use dynamic routes when needed, e.g., `pages/post/[id].tsx`

```tsx
import { useRouter } from 'next/router';

const Post = () => {
  const router = useRouter();
  const { id } = router.query;

  return <h1>Post ID: {id}</h1>;
};

export default Post;
```

## 4. API Routes

- API routes should be placed inside `pages/api/`

```ts
import type { NextApiRequest, NextApiResponse } from 'next';

export default function handler(req: NextApiRequest, res: NextApiResponse) {
  res.status(200).json({ message: 'API working' });
}
```

## 5. Components & Props

- Use TypeScript for props validation

```tsx
interface ButtonProps {
  label: string;
  onClick: () => void;
}

const Button: React.FC<ButtonProps> = ({ label, onClick }) => {
  return <button onClick={onClick}>{label}</button>;
};

export default Button;
```

## 6. State Management

- Use React Context or SWR for global state when needed

```tsx
import useSWR from 'swr';

const fetcher = (url: string) => fetch(url).then((res) => res.json());

const Profile = () => {
  const { data, error } = useSWR('/api/user', fetcher);
  if (error) return <div>Failed to load</div>;
  if (!data) return <div>Loading...</div>;
  return <h1>{data.name}</h1>;
};

export default Profile;
```

## 7. Styling

- Use CSS Modules or Tailwind CSS

```tsx
import styles from './Header.module.css';

const Header = () => {
  return <header className={styles.header}>Welcome</header>;
};

export default Header;
```

## 8. Linting & Formatting

- Use ESLint and Prettier for consistent formatting

```json
{
  "extends": ["next/core-web-vitals"],
  "rules": {
    "react/jsx-props-no-spreading": "off"
  }
}
```

## 9. Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat(auth): add login feature
fix(api): resolve 500 error on user route
chore(deps): update Next.js version
```

---

By following these conventions, Next.js projects remain clean, maintainable, and scalable.

