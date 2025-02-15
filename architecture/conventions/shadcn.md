# ShadCN UI Guide for Next.js & React

## 1. Introduction
ShadCN UI is a collection of beautifully designed, accessible, and customizable components built with **Radix UI** and **Tailwind CSS**. It provides an efficient way to build modern UI components with minimal effort.

---

## 2. Setup Guide

### Prerequisites
- Node.js (v16+)
- Next.js (v13+ recommended)
- Tailwind CSS installed

### Installation
1. **Install the CLI**
```bash
npx shadcn-ui@latest init
```

2. **Add Components**
```bash
npx shadcn-ui@latest add button card input
```
This will generate components inside the `components/ui/` folder.

3. **Ensure Tailwind Configuration**
Add the following to your `tailwind.config.js`:
```js
/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: "class",
  content: [
    "./pages/**/*.{js,ts,jsx,tsx}",
    "./components/**/*.{js,ts,jsx,tsx}",
    "./app/**/*.{js,ts,jsx,tsx}"
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};
```

4. **Use a Component**
```tsx
import { Button } from "@/components/ui/button";

export default function Home() {
  return <Button>Click Me</Button>;
}
```

---

## 3. Best Practices for Using ShadCN UI

### Component Organization
- Keep components inside `components/ui/`
- Create reusable **wrappers** for complex logic
- Use **variants** instead of multiple component instances

### Example with Variants
```tsx
import { cn } from "@/lib/utils";
import { Button } from "@/components/ui/button";

type ButtonVariant = "primary" | "secondary";

const CustomButton = ({ variant = "primary", children }: { variant: ButtonVariant; children: React.ReactNode }) => {
  return (
    <Button className={cn(variant === "primary" ? "bg-blue-500" : "bg-gray-500")}>
      {children}
    </Button>
  );
};

export default CustomButton;
```

---

## 4. Integration with Zustand (State Management)

### Install Zustand
```bash
npm install zustand
```

### Define Store
```tsx
import { create } from "zustand";

interface StoreState {
  count: number;
  increase: () => void;
}

const useStore = create<StoreState>((set) => ({
  count: 0,
  increase: () => set((state) => ({ count: state.count + 1 })),
}));

export default useStore;
```

### Use in a Component
```tsx
import { Button } from "@/components/ui/button";
import useStore from "@/store/store";

export default function Counter() {
  const { count, increase } = useStore();

  return (
    <div>
      <p>Count: {count}</p>
      <Button onClick={increase}>Increment</Button>
    </div>
  );
}
```

---

## 5. Integration with React Hook Form (Forms)

### Install Dependencies
```bash
npm install react-hook-form
```

### Use with ShadCN Input
```tsx
import { useForm } from "react-hook-form";
import { Input } from "@/components/ui/input";
import { Button } from "@/components/ui/button";

export default function MyForm() {
  const { register, handleSubmit } = useForm();
  
  const onSubmit = (data: any) => console.log(data);

  return (
    <form onSubmit={handleSubmit(onSubmit)}>
      <Input {...register("email")} placeholder="Enter your email" />
      <Button type="submit">Submit</Button>
    </form>
  );
}
```

---

## 6. Custom Theming
Modify the `tailwind.config.js` to extend styles:
```js
module.exports = {
  theme: {
    extend: {
      colors: {
        primary: "#1E40AF", // Custom primary color
      },
    },
  },
};
```

---

## 7. Performance Optimization
- Use **lazy loading** for components when possible.
- Keep **bundles small** by only importing used components.
- Use **Memoization (`useMemo`, `useCallback`)** for expensive computations.

---

## 8. Debugging & Common Issues
- **Ensure Tailwind is properly configured** in `tailwind.config.js`
- **Use Next.js dynamic imports** for large components
- **Check variant conflicts** when using multiple styles

---

### Conclusion
ShadCN UI provides an elegant and scalable way to build modern applications. With its deep integration with Tailwind, Zustand, and React Hook Form, it simplifies development while maintaining flexibility and performance.

