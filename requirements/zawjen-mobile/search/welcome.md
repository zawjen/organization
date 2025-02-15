# Search Requirements Document

## Overview
This document outlines the requirements for developing a **React Native** mobile app using **React Native Paper** UI components. The app will feature a **search textbox with an audio button**, an **exact search toggle**, and a **filter button** leading to a filter screen with hundreds of filters. The selected filters should persist across multiple app sessions. The app will send search queries to the `search-service` at `zawjen.app.net` via a **REST API** and display the results.

---

## Features

### 1. **Search Functionality**
- A **search textbox** where users can type search queries.
- A **Search button** that triggers a search request to the `search-service`.
- An **audio button** to enable voice input for search queries.
- An **exact match toggle button** to switch between exact and fuzzy search.

### 2. **Filter Functionality**
- A **Filter button** that opens a filter screen with hundreds of filters.
- Selected filters should persist across multiple app sessions.
- Filters should be dynamically loaded and categorized for ease of selection.

### 3. **API Integration**
- The app will call `search-service` at `zawjen.app.net` with a **JSON request** containing:
  - `searchText`: The user's search query.
  - `exactMatch`: Boolean indicating if exact match is required.
  - `filters`: Selected filters.
- The response from `search-service` will include:
  - `searchText`: Echoed back.
  - `searchFilters`: List of applied filters.
  - `exactMatch`: Boolean value.
  - `count`: Total number of matches found.
  - `totalPages`: Total number of pages.
  - `currentPage`: The current page number.
  - `datasets`: An array of datasets with their respective locations.

### 4. **Dataset Structure**
Each dataset in the response will have the following attributes:

#### Dataset Metadata
- **Format**: Books, PDFs, Images, Text, Audio, Videos.
- **Type**: Religion, Politics, Medicine, Law, Sociology, Technology, Education, Economics, History, Ethics, Spirituality, etc.
- **Classification**:
  - **Green**: Verified as Truth
  - **Yellow**: Doubtful or requires further validation
  - **Red**: Identified as False or Fabricated
- **Language**: Arabic, English, or one of 1000+ other languages.
- **Date Created**: Timestamp of dataset creation.
- **Date Updated**: Timestamp of last update.

#### Location Data
Each dataset will contain an array of locations with the following attribute:
- **Complete text**: The full content of the matched dataset.

---

## Technical Stack
- **React Native** for mobile development.
- **React Native Paper** for UI components.
- **AsyncStorage** for persisting filter selections.
- **Axios** for REST API calls.
- **React Navigation** for managing navigation between search and filter screens.
- **Redux or Context API** for managing state if needed.
- **React Native Voice** for implementing audio input (optional).

---

## API Request & Response Format

### **Request to `search-service`**
```json
{
  "searchText": "example query",
  "exactMatch": true,
  "filters": {
    "format": "Books",
    "type": "Religion",
    "classification": "Green",
    "language": "Arabic"
  }
}
```

### **Response from `search-service`**
```json
{
  "searchText": "example query",
  "searchFilters": {
    "format": "Books",
    "type": "Religion",
    "classification": "Green",
    "language": "Arabic"
  },
  "exactMatch": true,
  "count": 25,
  "totalPages": 5,
  "currentPage": 1,
  "datasets": [
    {
      "format": "Books",
      "type": "Religion",
      "classification": "Green",
      "language": "Arabic",
      "dateCreated": "2025-01-01",
      "dateUpdated": "2025-02-15",
      "locations": [
        {
          "completeText": "Full text of the matched dataset..."
        }
      ]
    }
  ]
}
```

---

## Security Considerations
- All API requests must be authenticated using JWT.
- HTTPS must be enforced for secure communication.
- Rate limiting should be applied to prevent abuse.

---

## Conclusion
This document outlines the key functionalities and API interactions for building a **React Native mobile app with Paper UI** that integrates a search feature with extensive filters. The app will ensure a smooth user experience with session-persistent filters, an interactive search, and a robust API-backed data retrieval system.

