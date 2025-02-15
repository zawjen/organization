# React Native Paper Guide

## 1. Introduction
React Native Paper is a library that provides Material Design components for React Native applications. It helps developers build beautiful, consistent, and accessible UIs with ease.

---

## 2. Installation

### Prerequisites
- React Native project setup
- Node.js installed

### Install React Native Paper
```bash
npm install react-native-paper
```

### Install React Native Vector Icons (Required for Icons)
```bash
npm install react-native-vector-icons
```

Ensure `react-native-vector-icons` is linked if using React Native CLI:
```bash
npx react-native link react-native-vector-icons
```

---

## 3. Setup & Theme Configuration

### Import Provider
Wrap your app with the `PaperProvider` to enable theming and component usage.

```tsx
import React from 'react';
import { Provider as PaperProvider } from 'react-native-paper';
import { NavigationContainer } from '@react-navigation/native';
import HomeScreen from './HomeScreen';

export default function App() {
  return (
    <PaperProvider>
      <NavigationContainer>
        <HomeScreen />
      </NavigationContainer>
    </PaperProvider>
  );
}
```

### Custom Theme
Define a custom theme to override default styles.

```tsx
import { MD3LightTheme as DefaultTheme, Provider as PaperProvider } from 'react-native-paper';

const theme = {
  ...DefaultTheme,
  colors: {
    ...DefaultTheme.colors,
    primary: '#6200ee',
    accent: '#03dac4',
  },
};

export default function App() {
  return (
    <PaperProvider theme={theme}>
      {/* App Components */}
    </PaperProvider>
  );
}
```

---

## 4. Components

### 4.1 Button
```tsx
import { Button } from 'react-native-paper';

<Button mode="contained" onPress={() => console.log('Pressed')}>Click Me</Button>
```

### 4.2 Text Input
```tsx
import { TextInput } from 'react-native-paper';

<TextInput label="Email" mode="outlined" />
```

### 4.3 Card
```tsx
import { Card, Title, Paragraph } from 'react-native-paper';

<Card>
  <Card.Content>
    <Title>Card Title</Title>
    <Paragraph>Card content goes here.</Paragraph>
  </Card.Content>
</Card>
```

### 4.4 Snackbar
```tsx
import { Snackbar } from 'react-native-paper';
import { useState } from 'react';

const [visible, setVisible] = useState(false);

<Snackbar
  visible={visible}
  onDismiss={() => setVisible(false)}
  action={{ label: 'Undo', onPress: () => {} }}
>
  Snackbar message here.
</Snackbar>
```

---

## 5. Navigation with React Navigation
Install dependencies:
```bash
npm install @react-navigation/native @react-navigation/stack react-native-screens react-native-safe-area-context react-native-gesture-handler react-native-reanimated
```

Example:
```tsx
import { createStackNavigator } from '@react-navigation/stack';
import { NavigationContainer } from '@react-navigation/native';
import HomeScreen from './HomeScreen';

const Stack = createStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen name="Home" component={HomeScreen} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}
```

---

## 6. Theming and Dark Mode

### Enable Dark Mode
```tsx
import { MD3DarkTheme, Provider as PaperProvider } from 'react-native-paper';
import { useColorScheme } from 'react-native';

export default function App() {
  const scheme = useColorScheme();
  const theme = scheme === 'dark' ? MD3DarkTheme : DefaultTheme;

  return <PaperProvider theme={theme}>{/* Components */}</PaperProvider>;
}
```

---

## 7. Best Practices
- Use `PaperProvider` at the root of the app.
- Avoid hardcoding colors; use themes for scalability.
- Use `useTheme()` to access theme values dynamically.
- Use React Navigation for seamless navigation with Paper components.

---

### Conclusion
React Native Paper simplifies UI development with Material Design principles, enabling beautiful and functional React Native apps. Integrating it with theming, navigation, and best practices ensures a smooth development experience.

