# REST API Endpoint Conventions

## 1. URL Structure

- Use **plural nouns** for resource names: `/users`, `/orders`
- Nest resources to show relationships: `/users/{user_id}/orders`
- Use **hyphens (-)** to separate words: `/user-profiles`
- Avoid verbs in URLs, use HTTP methods instead

### Examples:
```
GET    /users        # Retrieve all users
GET    /users/{id}   # Retrieve a single user
POST   /users        # Create a new user
PUT    /users/{id}   # Update an existing user
DELETE /users/{id}   # Delete a user
```

## 2. HTTP Methods

| Method  | Usage                         |
|---------|-------------------------------|
| `GET`   | Retrieve data                 |
| `POST`  | Create a new resource         |
| `PUT`   | Update an existing resource   |
| `PATCH` | Partially update a resource   |
| `DELETE`| Remove a resource             |

## 3. Status Codes

| Code  | Meaning                    |
|-------|----------------------------|
| 200   | OK                         |
| 201   | Created                    |
| 204   | No Content                 |
| 400   | Bad Request                |
| 401   | Unauthorized               |
| 403   | Forbidden                  |
| 404   | Not Found                  |
| 500   | Internal Server Error       |

## 4. Request & Response Format

- Use **JSON** for request and response payloads
- Include **Content-Type: application/json** in headers
- Return structured responses with `data` and `meta` fields

### Example Response:
```json
{
  "data": {
    "id": 1,
    "name": "John Doe",
    "email": "john.doe@example.com"
  },
  "meta": {
    "timestamp": "2025-02-15T12:00:00Z"
  }
}
```

## 5. Query Parameters

- Use query parameters for filtering, sorting, and pagination

### Example:
```
GET /users?sort=created_at&order=desc&page=2&limit=20
```

## 6. Authentication

- Use **Bearer Tokens** for authentication
- Include token in `Authorization` header

```http
Authorization: Bearer <token>
```

## 7. Error Handling

- Return meaningful error messages with `error` field

### Example Error Response:
```json
{
  "error": {
    "message": "Invalid request parameters",
    "code": 400
  }
}
```

## 8. Versioning

- Use versioning in the URL: `/v1/users`
- Avoid breaking changes in newer versions

## 9. Rate Limiting

- Implement rate limiting with headers:
```http
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 500
X-RateLimit-Reset: 1617628799
```

---

By following these conventions, REST APIs will be consistent, maintainable, and scalable.

