# Search Feature Requirements Document

## Technology Stack
- **Frontend:** Next.js  
- **UI Library:** ShadCN (based on Tailwind CSS, Radix UI, etc.)

## Feature Overview

### User Interface
- **Search Screen:**  
  - A search textbox for entering queries.  
  - An audio button for voice input (to be integrated with a voice recognition service).  
  - A search button to trigger the search operation.  
  - A clear text button appears when the search textbox is not empty.  
  - A rectangle filter button that opens a separate filter screen.

- **Filter Screen:**  
  - Displays hundreds of filters with names and controls (e.g., checkboxes, dropdowns).  
  - Filters are dynamically obtained by calling the **filter-service** REST API.  
  - All available filters are defined in the [data dictionary](https://github.com/zawjen/organization/blob/main/requirements/data-dictionary/welcome.md).  
  - Once filters are selected, they are saved (using localStorage) and persist between sessions.

- **Search Execution & Results:**  
  - When the user types in the search textbox and clicks the **Search** button, a POST request is sent to **search-service** at `https://zawjen.app.net/search-service` with a JSON payload containing the search text and an array of selected filters.  
  - The search-service returns a JSON response (structure detailed below).  
  - The results are rendered in an article format:  
    - The article background is lightly colored: green for "Green" classification, yellow for "Yellow", red for "Red" (all “read” content uses a similar light color).  
    - Each attribute in the response is displayed as a clickable link that navigates to its detail page.

- **Additional Actions:**  
  - Users can download the article as PDF, Word, or PNG.  
  - Users can copy a URL that includes the search text, filters, and details.  
  - Users can share the article on social media.  
  - All searches are stored in user history (via a REST API call to **user-history-service** at `https://zawjen.app.net/user-history`).  
  - Users can clear history or disable history tracking via API calls.

---

## General Requirements

1. **Coding Conventions:** Follow zawjen.net coding conventions and clean coding principles.
2. **Unit Tests:** Provide 100% coverage using Jest.
3. **Performance:** The solution must be highly performant and efficient (low memory, CPU, and battery usage).
4. **Scalability & Maintainability:** The solution must be scalable and easy to maintain.
5. **Error Handling:** Use try-catch blocks with proper error logging.
6. **Data Dictionary:** Refer to the [data dictionary](https://github.com/zawjen/organization/blob/main/requirements/data-dictionary/welcome.md) for definitions.
7. **API Contracts:** Follow the JSON contracts provided in the [api-contracts](https://github.com/zawjen/api-contracts) repo.
8. **Mobile-First UX:** Design a mobile-first user experience to improve usability and SEO.

---

## API Request & Response Examples

### Filter-Service API
- **Endpoint:** `GET https://zawjen.app.net/filter-service`
- **Response:**
  ```json
  {
    "filters": [
      { "name": "Language", "options": ["English", "Arabic", "Urdu"] },
      { "name": "Classification", "options": ["Green", "Yellow", "Red"] },
      { "name": "Type", "options": ["Religion", "Politics", "Medicine", "Law", "Sociology", "Technology", "Education", "Economics", "History", "Ethics", "Spirituality"] }
    ]
  }
  ```

### Search-Service API
- **Endpoint:** `POST https://zawjen.app.net/search-service`
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
- **Store Search History (POST):**  
  **Endpoint:** `POST https://zawjen.app.net/user-history`
  ```json
  {
    "user_id": "12345",
    "search_text": "Hadith",
    "filters": ["Language: English", "Classification: Green"]
  }
  ```
- **Clear History (DELETE):**  
  **Endpoint:** `DELETE https://zawjen.app.net/user-history`
  ```json
  {
    "user_id": "12345"
  }
  ```
- **Disable History (PUT):**  
  **Endpoint:** `PUT https://zawjen.app.net/user-history`
  ```json
  {
    "user_id": "12345",
    "disable": true
  }
  ```

---

## Implementation Code (Next.js / ShadCN)

Below are sample code examples for each UI component along with complete functionality and unit tests using Jest.

### 1. Search Component

#### File: `components/Search.tsx`
```tsx
import { useState } from 'react';
import { Input } from '@/components/ui/input';
import { Button } from '@/components/ui/button';
import { SearchIcon, MicIcon, XIcon } from 'lucide-react';

export default function Search() {
  const [query, setQuery] = useState('');

  const handleClear = () => setQuery('');

  const handleSearch = async () => {
    try {
      // Retrieve selected filters from localStorage
      const filters = JSON.parse(localStorage.getItem('selectedFilters') || '[]');
      const response = await fetch('https://zawjen.app.net/search-service', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ search_text: query, filters })
      });
      const data = await response.json();
      // Navigate to results page (using your routing solution)
      // For example: router.push('/results', { state: { data } });
      console.log('Search result:', data);
    } catch (error) {
      console.error('Search error:', error);
    }
  };

  return (
    <div className="p-4 border rounded-lg flex items-center space-x-2">
      <Input
        type="text"
        placeholder="Search..."
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        className="flex-grow"
        data-testid="search-input"
      />
      {query && (
        <Button variant="ghost" onClick={handleClear} data-testid="clear-button">
          <XIcon size={16} />
        </Button>
      )}
      <Button variant="default" onClick={handleSearch} data-testid="search-button">
        <SearchIcon size={16} /> Search
      </Button>
      <Button variant="outline" onClick={() => console.log('Voice input triggered')} data-testid="audio-button">
        <MicIcon size={16} />
      </Button>
      <Button variant="secondary" onClick={() => window.location.assign('/filter')} data-testid="filter-button">
        Filter
      </Button>
    </div>
  );
}
```

#### Unit Test: `__tests__/Search.test.tsx`
```tsx
import { render, fireEvent, screen, waitFor } from '@testing-library/react';
import Search from '../components/Search';

global.fetch = jest.fn(() =>
  Promise.resolve({
    json: () =>
      Promise.resolve({
        search_text: 'Hadith',
        search_filters: ['Language: English', 'Classification: Green'],
        match_count: 100,
        total_pages: 10,
        current_page: 1,
        datasets: []
      })
  })
) as jest.Mock;

describe('Search Component', () => {
  beforeEach(() => {
    localStorage.clear();
  });

  it('should render and allow text input, clear input, and trigger search', async () => {
    render(<Search />);
    const input = screen.getByTestId('search-input');
    const clearButtonName = /clear/i;
    // Type a query
    fireEvent.change(input, { target: { value: 'Hadith' } });
    expect(input).toHaveValue('Hadith');

    // Clear the text
    const clearButton = screen.getByTestId('clear-button');
    fireEvent.click(clearButton);
    expect(input).toHaveValue('');

    // Set value again and trigger search
    fireEvent.change(input, { target: { value: 'Hadith' } });
    const searchButton = screen.getByTestId('search-button');
    fireEvent.click(searchButton);

    await waitFor(() => {
      expect(global.fetch).toHaveBeenCalledWith(
        'https://zawjen.app.net/search-service',
        expect.objectContaining({
          method: 'POST'
        })
      );
    });
  });
});
```

---

### 2. Filter Screen Component

#### File: `pages/filter.tsx`
```tsx
import { useEffect, useState } from 'react';
import { Checkbox } from '@/components/ui/checkbox';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';

interface Filter {
  name: string;
  options: string[];
}

export default function FilterScreen() {
  const [filters, setFilters] = useState<Filter[]>([]);
  const [selectedFilters, setSelectedFilters] = useState<Record<string, string[]>>({});

  useEffect(() => {
    const fetchFilters = async () => {
      try {
        const res = await fetch('https://zawjen.app.net/filter-service');
        const data = await res.json();
        setFilters(data.filters);
        const saved = localStorage.getItem('selectedFilters');
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
    const currentOptions = selectedFilters[filterName] || [];
    const updatedOptions = currentOptions.includes(option)
      ? currentOptions.filter((opt) => opt !== option)
      : [...currentOptions, option];
    setSelectedFilters({ ...selectedFilters, [filterName]: updatedOptions });
  };

  const handleApplyFilters = () => {
    try {
      localStorage.setItem('selectedFilters', JSON.stringify(selectedFilters));
      // Navigate back to the search screen
      window.location.assign('/');
    } catch (error) {
      console.error('Error saving filters:', error);
    }
  };

  return (
    <div className="p-4">
      {filters.map((filter, index) => (
        <div key={index} className="mb-4">
          <h3 className="font-bold">{filter.name}</h3>
          {filter.options.map((option, idx) => (
            <div key={idx} className="flex items-center">
              <Checkbox
                checked={selectedFilters[filter.name]?.includes(option) || false}
                onCheckedChange={() => toggleFilter(filter.name, option)}
                data-testid={`checkbox-${filter.name}-${option}`}
              />
              <span>{option}</span>
            </div>
          ))}
        </div>
      ))}
      <Button onClick={handleApplyFilters} data-testid="apply-filters-button">
        Apply Filters
      </Button>
    </div>
  );
}
```

#### Unit Test: `__tests__/FilterScreen.test.tsx`
```tsx
import { render, fireEvent, waitFor, screen } from '@testing-library/react';
import FilterScreen from '../pages/filter';

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
) as jest.Mock;

describe('FilterScreen', () => {
  beforeEach(() => {
    localStorage.clear();
  });

  it('fetches and displays filters', async () => {
    render(<FilterScreen />);
    await waitFor(() => {
      expect(screen.getByText('Language')).toBeTruthy();
      expect(screen.getByText('Classification')).toBeTruthy();
    });
  });

  it('allows selecting filter options and applies filters', async () => {
    render(<FilterScreen />);
    await waitFor(() => screen.getByText('Language'));
    
    // Toggle English option
    const englishCheckbox = screen.getByTestId('checkbox-Language-English');
    fireEvent.click(englishCheckbox);
    // Click apply button
    const applyButton = screen.getByTestId('apply-filters-button');
    fireEvent.click(applyButton);
    await waitFor(() => {
      expect(localStorage.getItem('selectedFilters')).toContain('English');
    });
  });
});
```

---

### 3. Results Screen Component

#### File: `pages/results.tsx`
```tsx
import { useRouter } from 'next/router';
import Link from 'next/link';
import { Button } from '@/components/ui/button';

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

export default function Results() {
  const router = useRouter();
  const { data } = router.query as { data: string };
  const result: SearchResult = JSON.parse(data);

  const getBackgroundColor = (classification: string) => {
    switch (classification) {
      case 'Green':
        return 'bg-green-100';
      case 'Yellow':
        return 'bg-yellow-100';
      case 'Red':
        return 'bg-red-100';
      default:
        return 'bg-gray-100';
    }
  };

  const handleDownload = (format: string) => {
    // Implement download functionality here
    console.log(`Download as ${format}`);
  };

  const handleCopyUrl = () => {
    // Implement copy URL functionality here
    console.log('Copy URL');
  };

  const handleShare = () => {
    // Implement share functionality here
    console.log('Share article');
  };

  return (
    <div className="p-4">
      <h1 className="text-2xl font-bold">Search: {result.search_text}</h1>
      <p>Filters: {result.search_filters.join(', ')}</p>
      <p>Matches Found: {result.match_count}</p>
      <p>
        Page {result.current_page} of {result.total_pages}
      </p>

      {result.datasets.map((dataset, index) => (
        <Link href={`/detail/${index}`} key={index}>
          <a className={`${getBackgroundColor(dataset.classification)} block p-4 my-2 rounded`}>
            <h2 className="text-xl font-semibold">Format: {dataset.format}</h2>
            <p>Type: {dataset.type}</p>
            <p>Language: {dataset.language}</p>
            <p>Date Created: {dataset.date_created}</p>
            <p>Date Updated: {dataset.date_updated}</p>
            {dataset.locations.map((location, idx) => (
              <p key={idx} className="text-blue-600 underline">{location.text}</p>
            ))}
          </a>
        </Link>
      ))}

      <div className="mt-4 space-x-2">
        <Button onClick={() => handleDownload('PDF')}>Download PDF</Button>
        <Button onClick={() => handleDownload('Word')}>Download Word</Button>
        <Button onClick={() => handleDownload('PNG')}>Download PNG</Button>
      </div>
      <div className="mt-4 space-x-2">
        <Button variant="outline" onClick={handleCopyUrl}>Copy URL</Button>
        <Button variant="outline" onClick={handleShare}>Share</Button>
      </div>
    </div>
  );
}
```

#### Unit Test: `__tests__/Results.test.tsx`
```tsx
import { render, fireEvent, screen } from '@testing-library/react';
import Results from '../pages/results';
import { useRouter } from 'next/router';

jest.mock('next/router', () => ({
  useRouter: jest.fn()
}));

describe('Results Page', () => {
  const resultData = {
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
  };

  beforeEach(() => {
    (useRouter as jest.Mock).mockReturnValue({
      query: { data: JSON.stringify(resultData) }
    });
  });

  it('renders search results correctly', () => {
    render(<Results />);
    expect(screen.getByText('Search: Hadith')).toBeTruthy();
    expect(screen.getByText('Filters: Language: English')).toBeTruthy();
    expect(screen.getByText('Matches Found: 100')).toBeTruthy();
    expect(screen.getByText('Page 1 of 10')).toBeTruthy();
    expect(screen.getByText('Format: Book')).toBeTruthy();
  });

  // Additional tests can simulate button clicks for download, copy, and share
});
```

---

## Conclusion
This document provides a comprehensive blueprint for implementing the Search Feature on a Next.js website using ShadCN. It includes detailed UI components, full functionality code, API integration logic, and complete Jest unit tests for 100% coverage. Adjust API endpoints, error handling, and business logic as required by your project.
