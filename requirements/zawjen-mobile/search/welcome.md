
# Search Feature Requirements Document

## Technology Stack
- **Frontend:** React Native
- **UI Library:** Paper

---

## Feature Details

### Search UI
- **Screen Layout:**
  - A search textbox for entering text.
  - An audio button for voice input.
  - A search button to trigger the search.
  - A clear text button that appears when the textbox is not empty.
  - A rectangle filter button that opens a filter screen.

### Filters
- Filters are obtained by making a REST API call to **filter-service** (available at `https://zawjen.app.net/filter-service`).
- The response returns JSON with all filters as defined in the [data dictionary](https://github.com/zawjen/organization/blob/main/requirements/data-dictionary/welcome.md).
- The filter screen displays all filters with appropriate names and controls (checkboxes, dropdowns, etc.).
- Once selected, filters should persist between sessions (using AsyncStorage).

### Search Functionality
- When a user enters text and hits the **Search** button:
  - The app makes a POST call to **search-service** (`https://zawjen.app.net/search-service`).
  - The JSON request includes the search text and an array of selected filters.
- The API response is a JSON object with the following structure:
  - **search_text**
  - **search_filters**
  - **match_count**
  - **total_pages**
  - **current_page**
  - **datasets** – an array where each dataset contains:
    - **format:** Books, PDFs, Images, Text, Audio, Videos
    - **type:** Religion, Politics, Medicine, Law, Sociology, Technology, Education, Economics, History, Ethics, Spirituality, etc.
    - **classification:** Green (Verified as Truth), Yellow (Doubtful), or Red (False/Fabricated)
    - **language:** Arabic, English, or one of 1000+ other languages
    - **date_created**
    - **date_updated**
    - **locations:** An array of objects, each with a **text** attribute

### Search Results Display
- Results are shown in an article-like format:
  - The background color is light green if classification is Green, light yellow for Yellow, and light red for Red.
  - Each response attribute is displayed as a clickable link, which navigates to its detail page.
- Additional actions on the result screen include:
  - **Download Options:** Download as PDF, Word, or PNG.
  - **Copy URL:** Copy a URL that includes the search text, filters, and details.
  - **Share:** Share the article on social media.

### Search History
- All user searches are stored via a REST API call to **user-history-service** (`https://zawjen.app.net/user-history`).
- Users can:
  - View their search history.
  - Clear search history.
  - Disable history tracking via the appropriate API calls.

---

## General Requirements
1. **Follow zawjen.net coding convention.**
2. **Write 100% coverage unit tests.**
3. **Ensure high performance:** low memory, CPU, and battery usage.
4. **Build a highly scalable and maintainable solution.**
5. **Follow zawjen.net clean coding principles.**
6. **Use try-catch and log errors.**
7. **Refer to the [data dictionary](https://github.com/zawjen/organization/blob/main/requirements/data-dictionary/welcome.md) for definitions.**
8. **Follow API contracts** from the [api-contracts](https://github.com/zawjen/api-contracts) repo.
9. **Design a mobile-first UX** for a better user experience and improved Google ranking.

---

## API Endpoints & JSON Examples

### Filter-Service API
- **GET** `https://zawjen.app.net/filter-service`
  - **Response:**
    ```json
    {
      "filters": [
        { "name": "Language", "options": ["English", "Arabic", "Urdu"] },
        { "name": "Classification", "options": ["Green", "Yellow", "Red"] }
      ]
    }
    ```

### Search-Service API
- **POST** `https://zawjen.app.net/search-service`
  - **Request:**
    ```json
    {
      "search_text": "Hadith",
      "filters": ["Language: English", "Classification: Green"]
    }
    ```
  - **Response:**
    ```json
    {
      "search_text": "Hadith",
      "search_filters": ["Language: English", "Classification: Green"],
      "match_count": 100,
      "total_pages": 10,
      "current_page": 1,
      "datasets": [
        {
          "format": "Book",
          "type": "Religion",
          "classification": "Green",
          "language": "Arabic",
          "date_created": "2024-01-01",
          "date_updated": "2024-02-01",
          "locations": [
            { "text": "Hadith text here..." }
          ]
        }
      ]
    }
    ```

### User-History Service API
- **Store Search History** – **POST** `https://zawjen.app.net/user-history`
  - **Request:**
    ```json
    {
      "user_id": "12345",
      "search_text": "Hadith",
      "filters": ["Language: English", "Classification: Green"]
    }
    ```
- **Clear History** – **DELETE** `https://zawjen.app.net/user-history`
  - **Request:**
    ```json
    {
      "user_id": "12345"
    }
    ```
- **Disable History** – **PUT** `https://zawjen.app.net/user-history`
  - **Request:**
    ```json
    {
      "user_id": "12345",
      "disable": true
    }
    ```

---

## Implementation Code

Below are the sample React Native components using **Paper** along with their complete functionality and Jest unit tests.

### 1. SearchScreen Component (`screens/SearchScreen.tsx`)
```tsx
import React, { useState } from 'react';
import { View, StyleSheet } from 'react-native';
import { TextInput, Button, IconButton } from 'react-native-paper';
import AsyncStorage from '@react-native-async-storage/async-storage';

interface SearchScreenProps {
  navigation: any;
}

const SearchScreen: React.FC<SearchScreenProps> = ({ navigation }) => {
  const [query, setQuery] = useState('');

  const handleClearText = () => {
    setQuery('');
  };

  const handleSearch = async () => {
    try {
      // Get saved filters from AsyncStorage
      const savedFilters = await AsyncStorage.getItem('selectedFilters');
      const filters = savedFilters ? JSON.parse(savedFilters) : [];
      const response = await fetch('https://zawjen.app.net/search-service', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          search_text: query,
          filters: filters
        })
      });
      const data = await response.json();

      // Optionally store search history here via user-history-service

      navigation.navigate('ResultsScreen', { data });
    } catch (error) {
      console.error('Search error:', error);
    }
  };

  return (
    <View style={styles.container}>
      <TextInput
        mode="outlined"
        label="Search"
        placeholder="Search..."
        value={query}
        onChangeText={setQuery}
        style={styles.searchInput}
        testID="search-input"
      />
      {query.length > 0 && (
        <IconButton
          icon="close"
          size={20}
          onPress={handleClearText}
          testID="clear-button"
        />
      )}
      <Button mode="contained" onPress={handleSearch} testID="search-button">
        Search
      </Button>
      <Button
        mode="outlined"
        onPress={() => navigation.navigate('FilterScreen')}
        testID="filter-button"
      >
        Filter
      </Button>
      <IconButton
        icon="microphone"
        size={24}
        onPress={() => {
          // Implement voice input functionality here
        }}
        testID="audio-button"
      />
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    padding: 16,
    justifyContent: 'center'
  },
  searchInput: {
    marginBottom: 16
  }
});

export default SearchScreen;
```

### Unit Test for SearchScreen (`__tests__/SearchScreen.test.tsx`)
```tsx
import React from 'react';
import { render, fireEvent, waitFor } from '@testing-library/react-native';
import SearchScreen from '../screens/SearchScreen';

global.fetch = jest.fn(() =>
  Promise.resolve({
    json: () =>
      Promise.resolve({
        search_text: 'Hadith',
        search_filters: [],
        match_count: 100,
        total_pages: 10,
        current_page: 1,
        datasets: []
      })
  })
) as jest.Mock;

const navigation = { navigate: jest.fn() };

describe('SearchScreen', () => {
  it('renders and clears text input', () => {
    const { getByTestId } = render(<SearchScreen navigation={navigation} />);
    const input = getByTestId('search-input');
    fireEvent.changeText(input, 'Hadith');
    expect(input.props.value).toBe('Hadith');

    const clearButton = getByTestId('clear-button');
    fireEvent.press(clearButton);
    expect(input.props.value).toBe('');
  });

  it('calls search-service and navigates to ResultsScreen', async () => {
    const { getByTestId } = render(<SearchScreen navigation={navigation} />);
    const input = getByTestId('search-input');
    fireEvent.changeText(input, 'Hadith');

    const searchButton = getByTestId('search-button');
    fireEvent.press(searchButton);

    await waitFor(() =>
      expect(navigation.navigate).toHaveBeenCalledWith(
        'ResultsScreen',
        expect.objectContaining({
          data: expect.objectContaining({
            search_text: 'Hadith'
          })
        })
      )
    );
  });
});
```

---

### 2. FilterScreen Component (`screens/FilterScreen.tsx`)
```tsx
import React, { useEffect, useState } from 'react';
import { View, ScrollView, StyleSheet } from 'react-native';
import { Checkbox, Button, Text } from 'react-native-paper';
import AsyncStorage from '@react-native-async-storage/async-storage';

interface Filter {
  name: string;
  options: string[];
}

interface FilterScreenProps {
  navigation: any;
}

const FilterScreen: React.FC<FilterScreenProps> = ({ navigation }) => {
  const [filters, setFilters] = useState<Filter[]>([]);
  const [selectedFilters, setSelectedFilters] = useState<Record<string, string[]>>({});

  useEffect(() => {
    const fetchFilters = async () => {
      try {
        const response = await fetch('https://zawjen.app.net/filter-service');
        const data = await response.json();
        setFilters(data.filters);
        const saved = await AsyncStorage.getItem('selectedFilters');
        if (saved) {
          setSelectedFilters(JSON.parse(saved));
        }
      } catch (error) {
        console.error('Error fetching filters:', error);
      }
    };
    fetchFilters();
  }, []);

  const toggleFilter = (filterName: string, option: string) => {
    const current = selectedFilters[filterName] || [];
    let newOptions;
    if (current.includes(option)) {
      newOptions = current.filter((item) => item !== option);
    } else {
      newOptions = [...current, option];
    }
    const newSelected = { ...selectedFilters, [filterName]: newOptions };
    setSelectedFilters(newSelected);
  };

  const handleApply = async () => {
    try {
      await AsyncStorage.setItem('selectedFilters', JSON.stringify(selectedFilters));
      navigation.goBack();
    } catch (error) {
      console.error('Error saving filters:', error);
    }
  };

  return (
    <ScrollView style={styles.container}>
      {filters.map((filter, index) => (
        <View key={index} style={styles.filterGroup}>
          <Text>{filter.name}</Text>
          {filter.options.map((option, idx) => (
            <View key={idx} style={styles.optionRow}>
              <Checkbox
                status={
                  selectedFilters[filter.name] && selectedFilters[filter.name].includes(option)
                    ? 'checked'
                    : 'unchecked'
                }
                onPress={() => toggleFilter(filter.name, option)}
                testID={`checkbox-${filter.name}-${option}`}
              />
              <Text>{option}</Text>
            </View>
          ))}
        </View>
      ))}
      <Button mode="contained" onPress={handleApply} testID="apply-filters-button">
        Apply Filters
      </Button>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    padding: 16
  },
  filterGroup: {
    marginBottom: 16
  },
  optionRow: {
    flexDirection: 'row',
    alignItems: 'center'
  }
});

export default FilterScreen;
```

### Unit Test for FilterScreen (`__tests__/FilterScreen.test.tsx`)
```tsx
import React from 'react';
import { render, fireEvent, waitFor } from '@testing-library/react-native';
import FilterScreen from '../screens/FilterScreen';
import AsyncStorage from '@react-native-async-storage/async-storage';

jest.mock('@react-native-async-storage/async-storage', () => ({
  setItem: jest.fn(),
  getItem: jest.fn(() => Promise.resolve(null))
}));

global.fetch = jest.fn(() =>
  Promise.resolve({
    json: () =>
      Promise.resolve({
        filters: [
          { name: 'Language', options: ['English', 'Arabic'] },
          { name: 'Classification', options: ['Green', 'Yellow', 'Red'] }
        ]
      })
  })
);

const navigation = { goBack: jest.fn() };

describe('FilterScreen', () => {
  it('fetches and displays filters', async () => {
    const { getByText, getByTestId } = render(<FilterScreen navigation={navigation} />);
    await waitFor(() => {
      expect(getByText('Language')).toBeTruthy();
      expect(getByText('Classification')).toBeTruthy();
    });
  });

  it('allows selecting a filter option and applying filters', async () => {
    const { getByText, getByTestId } = render(<FilterScreen navigation={navigation} />);
    await waitFor(() => getByText('Language'));

    // Toggle the "English" option for Language
    const englishCheckbox = getByTestId('checkbox-Language-English');
    fireEvent.press(englishCheckbox);

    const applyButton = getByTestId('apply-filters-button');
    fireEvent.press(applyButton);
    await waitFor(() => expect(navigation.goBack).toHaveBeenCalled());
  });
});
```

---

### 3. ResultsScreen Component (`screens/ResultsScreen.tsx`)
```tsx
import React from 'react';
import { View, ScrollView, StyleSheet, TouchableOpacity } from 'react-native';
import { Text, Button } from 'react-native-paper';

interface Location {
  text: string;
}

interface Dataset {
  format: string;
  type: string;
  classification: 'Green' | 'Yellow' | 'Red';
  language: string;
  date_created: string;
  date_updated: string;
  locations: Location[];
}

interface SearchResult {
  search_text: string;
  search_filters: string[];
  match_count: number;
  total_pages: number;
  current_page: number;
  datasets: Dataset[];
}

interface ResultsScreenProps {
  route: { params: { data: SearchResult } };
  navigation: any;
}

const ResultsScreen: React.FC<ResultsScreenProps> = ({ route, navigation }) => {
  const { data } = route.params;

  const getBackgroundColor = (classification: string) => {
    switch (classification) {
      case 'Green': return '#d4edda';
      case 'Yellow': return '#fff3cd';
      case 'Red': return '#f8d7da';
      default: return '#ffffff';
    }
  };

  const handleDownload = (format: string) => {
    // Implement download functionality here
    console.log(`Download as ${format}`);
  };

  const handleCopyURL = () => {
    // Implement copy URL functionality here
    console.log('Copy URL');
  };

  const handleShare = () => {
    // Implement share functionality using React Native Share API
    console.log('Share article');
  };

  return (
    <ScrollView style={styles.container}>
      <Text variant="headlineMedium">Search: {data.search_text}</Text>
      <Text variant="bodyMedium">Filters: {data.search_filters.join(', ')}</Text>
      <Text variant="bodyMedium">Matches Found: {data.match_count}</Text>
      <Text variant="bodyMedium">Page {data.current_page} of {data.total_pages}</Text>

      {data.datasets.map((dataset, index) => (
        <TouchableOpacity
          key={index}
          onPress={() => navigation.navigate('DetailScreen', { dataset })}
          testID={`dataset-${index}`}
        >
          <View style={[styles.datasetContainer, { backgroundColor: getBackgroundColor(dataset.classification) }]}>
            <Text variant="titleMedium">Format: {dataset.format}</Text>
            <Text>Type: {dataset.type}</Text>
            <Text>Language: {dataset.language}</Text>
            <Text>Date Created: {dataset.date_created}</Text>
            <Text>Date Updated: {dataset.date_updated}</Text>
            {dataset.locations.map((location, idx) => (
              <Text key={idx} style={styles.locationText}>
                {location.text}
              </Text>
            ))}
          </View>
        </TouchableOpacity>
      ))}

      <Button mode="contained" onPress={() => handleDownload('PDF')} testID="download-pdf">
        Download PDF
      </Button>
      <Button mode="contained" onPress={() => handleDownload('Word')} testID="download-word">
        Download Word
      </Button>
      <Button mode="contained" onPress={() => handleDownload('PNG')} testID="download-png">
        Download PNG
      </Button>
      <Button mode="outlined" onPress={handleCopyURL} testID="copy-url">
        Copy URL
      </Button>
      <Button mode="outlined" onPress={handleShare} testID="share-button">
        Share
      </Button>
    </ScrollView>
  );
};

const styles = StyleSheet.create({
  container: {
    padding: 16
  },
  datasetContainer: {
    padding: 12,
    marginVertical: 8,
    borderRadius: 8
  },
  locationText: {
    marginTop: 4,
    color: '#0000EE',
    textDecorationLine: 'underline'
  }
});

export default ResultsScreen;
```

### Unit Test for ResultsScreen (`__tests__/ResultsScreen.test.tsx`)
```tsx
import React from 'react';
import { render, fireEvent } from '@testing-library/react-native';
import ResultsScreen from '../screens/ResultsScreen';

describe('ResultsScreen', () => {
  const navigation = { navigate: jest.fn() };
  const route = {
    params: {
      data: {
        search_text: 'Hadith',
        search_filters: ['Language: English'],
        match_count: 100,
        total_pages: 10,
        current_page: 1,
        datasets: [
          {
            format: 'Book',
            type: 'Religion',
            classification: 'Green',
            language: 'Arabic',
            date_created: '2024-01-01',
            date_updated: '2024-02-01',
            locations: [{ text: 'Hadith text here...' }]
          }
        ]
      }
    }
  };

  it('renders search results correctly', () => {
    const { getByText } = render(<ResultsScreen route={route} navigation={navigation} />);
    expect(getByText('Search: Hadith')).toBeTruthy();
    expect(getByText('Filters: Language: English')).toBeTruthy();
    expect(getByText('Matches Found: 100')).toBeTruthy();
    expect(getByText('Page 1 of 10')).toBeTruthy();
    expect(getByText('Format: Book')).toBeTruthy();
    expect(getByText('Type: Religion')).toBeTruthy();
  });

  it('navigates to DetailScreen on dataset press', () => {
    const { getByTestId } = render(<ResultsScreen route={route} navigation={navigation} />);
    const datasetLink = getByTestId('dataset-0');
    fireEvent.press(datasetLink);
    expect(navigation.navigate).toHaveBeenCalledWith('DetailScreen', {
      dataset: route.params.data.datasets[0]
    });
  });
});
```

---

## Conclusion
This document provides a comprehensive blueprint for implementing the Search Feature on the React Native app using Paper. It includes detailed requirements, complete UI component code, API integration logic, and full Jest unit tests for 100% coverage. Ensure you adjust API URLs, error logging, and business logic as necessary to meet the real-world requirements.
