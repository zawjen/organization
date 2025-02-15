# React Native Best Practices

## 1. Project Structure

- Follow a modular structure for better maintainability:

```
my-app/
├── src/
│   ├── components/   # Reusable UI components
│   ├── screens/      # Screen components
│   ├── navigation/   # Navigation setup
│   ├── services/     # API calls, async storage
│   ├── store/        # State management (Redux, Zustand, etc.)
│   ├── assets/       # Images, fonts, etc.
│   ├── hooks/        # Custom hooks
│   ├── utils/        # Utility functions
│   ├── theme/        # Theme and styles
│   ├── App.tsx       # Main entry point
│   ├── index.js      # Entry file
```

## 2. Naming Conventions

- Use **PascalCase** for component names: `MyComponent.tsx`
- Use **camelCase** for functions, variables, and file names: `handleClick.ts`
- Use **constants** for values stored globally: `const API_URL = 'https://api.example.com'`

## 3. Component Organization

- Keep components small and reusable.
- Separate logic and UI using hooks and utility functions.

### Example:
```tsx
// components/Button.tsx
import React from 'react';
import { TouchableOpacity, Text, StyleSheet } from 'react-native';

interface ButtonProps {
  title: string;
  onPress: () => void;
}

const Button: React.FC<ButtonProps> = ({ title, onPress }) => {
  return (
    <TouchableOpacity style={styles.button} onPress={onPress}>
      <Text style={styles.text}>{title}</Text>
    </TouchableOpacity>
  );
};

const styles = StyleSheet.create({
  button: { padding: 10, backgroundColor: 'blue', borderRadius: 5 },
  text: { color: 'white', fontSize: 16 }
});

export default Button;
```

## 4. State Management

- Use **React Context** for small-scale state management.
- Use **Redux Toolkit** or **Zustand** for larger applications.

## 5. Navigation

- Use **React Navigation** for handling navigation.
- Organize navigators into separate files.

### Example:
```tsx
// navigation/AppNavigator.tsx
import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';
import HomeScreen from '../screens/HomeScreen';
import DetailsScreen from '../screens/DetailsScreen';

const Stack = createStackNavigator();

const AppNavigator = () => (
  <Stack.Navigator>
    <Stack.Screen name="Home" component={HomeScreen} />
    <Stack.Screen name="Details" component={DetailsScreen} />
  </Stack.Navigator>
);

export default AppNavigator;
```

## 6. Styling

- Use **StyleSheet.create** for performance optimization.
- Consider **styled-components** or **Tailwind CSS** for better styling.

## 7. API Calls

- Use `fetch` or **Axios** for API requests.
- Store endpoints in a separate file (`src/services/api.ts`).

### Example:
```tsx
import axios from 'axios';
const API_URL = 'https://api.example.com';

export const fetchData = async () => {
  try {
    const response = await axios.get(`${API_URL}/data`);
    return response.data;
  } catch (error) {
    console.error('API Error:', error);
    throw error;
  }
};
```

## 8. Async Storage

- Use `@react-native-async-storage/async-storage` for persisting data.

### Example:
```tsx
import AsyncStorage from '@react-native-async-storage/async-storage';

export const storeData = async (key: string, value: string) => {
  try {
    await AsyncStorage.setItem(key, value);
  } catch (error) {
    console.error('Storage Error:', error);
  }
};
```

## 9. Performance Optimization

- Use `useMemo` and `useCallback` to optimize re-renders.
- Avoid inline styles and excessive re-renders.
- Use `FlatList` instead of `ScrollView` for long lists.

## 10. Debugging & Logging

- Use **Reactotron** for debugging.
- Use `console.log()` only in development.
- Remove all logs before production release.

---

Following these best practices will help you build scalable, maintainable, and high-performance React Native applications! 🚀

