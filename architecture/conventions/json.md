# JSON Best Practices

## 1. Formatting & Structure

- Use **consistent indentation** (2 or 4 spaces) for readability.
- Always use **double quotes (`"`)** for keys and string values.
- Use **camelCase** for keys to maintain consistency.
- Avoid **trailing commas** as they can cause errors in parsing.

### Example:
```json
{
  "userId": 1,
  "userName": "JohnDoe",
  "email": "john.doe@example.com"
}
```

## 2. Data Types

- Use appropriate data types: `string`, `number`, `boolean`, `array`, `object`, `null`
- Avoid storing numbers as strings unless necessary.

### Example:
```json
{
  "age": 30,
  "isActive": true,
  "tags": ["developer", "writer"],
  "profile": null
}
```

## 3. Nesting & Organization

- Keep JSON objects **flat** where possible.
- Use **nesting** only when logically required.
- Avoid deeply nested structures for maintainability.

### Example (Good):
```json
{
  "user": {
    "id": 1,
    "name": "John Doe",
    "contact": {
      "email": "john.doe@example.com",
      "phone": "123-456-7890"
    }
  }
}
```

### Example (Bad - Too Nested):
```json
{
  "user": {
    "details": {
      "personal": {
        "name": "John Doe",
        "contact": {
          "email": "john.doe@example.com"
        }
      }
    }
  }
}
```

## 4. Arrays & Collections

- Use arrays for lists instead of object keys.
- Ensure consistency in array values.

### Example:
```json
{
  "users": [
    {
      "id": 1,
      "name": "John Doe"
    },
    {
      "id": 2,
      "name": "Jane Smith"
    }
  ]
}
```

## 5. Null vs Empty Values

- Use `null` when a value is **intentionally missing**.
- Use **empty arrays (`[]`)** or objects (`{}`) instead of `null` if a collection exists but has no values.

### Example:
```json
{
  "comments": []  // No comments available
}
```

## 6. Consistent Key Naming

- Use **camelCase** for keys.
- Avoid abbreviations unless widely known.
- Maintain a consistent pattern across the dataset.

### Example:
```json
{
  "firstName": "John",
  "lastName": "Doe",
  "dateOfBirth": "1990-01-01"
}
```

## 7. Boolean Values

- Use `true` or `false` instead of `"yes"/"no"` or `1/0`.

### Example:
```json
{
  "isActive": true,
  "isVerified": false
}
```

## 8. API Response Structure

- Wrap API responses in a structured format.
- Use `data`, `meta`, and `error` fields for clarity.

### Example (Successful Response):
```json
{
  "data": {
    "id": 1,
    "name": "John Doe"
  },
  "meta": {
    "timestamp": "2025-02-15T12:00:00Z"
  }
}
```

### Example (Error Response):
```json
{
  "error": {
    "message": "Invalid request parameters",
    "code": 400
  }
}
```

## 9. Security Considerations

- **Never** store passwords in plain text; always hash them.
- Avoid exposing **sensitive information** like API keys.
- Ensure proper **escaping** of special characters to prevent injection attacks.

## 10. JSON Schema Validation

- Define a JSON schema for data validation.
- Use tools like **AJV**, **JSON Schema Validator**, or built-in JSON schema validation in APIs.

### Example Schema:
```json
{
  "$schema": "http://json-schema.org/draft-07/schema#",
  "type": "object",
  "properties": {
    "userId": { "type": "integer" },
    "email": { "type": "string", "format": "email" }
  },
  "required": ["userId", "email"]
}
```

---

By following these best practices, JSON data remains **clean, structured, and easy to manage**.

