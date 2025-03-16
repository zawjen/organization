# frontend development process

## Setup

### `NextJs`

```
npx create-next-app@15.2.1 . --typescript
```

### `Shadcn`

```
npx shadcn@latest init
```

###  `Storybook` 

```
npx storybook@8.6.4
```

## Process

To improve modularity and speeds up web frontend development, we are using following workflow:

- Add or update `story` for new component in `Storybook` project [storybook-web-zawjen](https://github.com/zawjen/storybook-web-zawjen)
- Copy component in web projects
  - [web-zawjen](https://github.com/zawjen/web-zawjen)
  - [web-zawjen-admin](https://github.com/zawjen/web-zawjen-admin)

## Storybook Advantages

- The good thing about Storybook is that people across the world can develop and test UI components in isolation without worrying about app dependencies. 
- It has Powerful plugins like accessibility testing, viewport adjustments, and interaction testing. 
- The best thing perhaps is that Designers and product managers can review components without needing to run the full app.