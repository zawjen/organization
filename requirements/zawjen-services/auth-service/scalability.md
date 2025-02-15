# Introduction
Documents two ways to use Keycloak with Kong

### **Scalability and Best Practices: Using Kong with Keycloak**
The choice between **using Keycloak directly with Kong** versus **placing Keycloak behind an auth-service** depends on scalability, flexibility, security, and operational complexity.

---

## **1. Direct Integration: Kong ↔ Keycloak (Standard Practice)**
### **How It Works**
- Kong uses its **OIDC plugin** to validate tokens directly with Keycloak.
- Clients authenticate with Keycloak and obtain a token.
- Kong validates the token before forwarding API requests.

### **Pros ✅**
✔ **Standard approach** – Kong supports OpenID Connect natively.  
✔ **Better performance** – Kong caches token verification, reducing Keycloak load.  
✔ **Less operational overhead** – No need for an additional auth-service.  

### **Cons ❌**
✖ **Potential Keycloak overload** – If Kong frequently verifies tokens, Keycloak may receive many introspection requests.  
✖ **Limited customization** – Kong directly depends on Keycloak’s default token validation logic.  

### **When to Use?**
- **For high-performance API gateways** where token validation caching can optimize performance.
- **When using Kong Enterprise**, as it has built-in support for OIDC.
- **If Keycloak can scale independently** and handle token validation load.

### **Setup Example**
1. Configure Kong’s OpenID Connect plugin:
   ```sh
   curl -i -X POST http://localhost:8001/plugins \
     --data "name=openid-connect" \
     --data "config.issuer=http://keycloak:8080/realms/myrealm" \
     --data "config.client_id=kong-client" \
     --data "config.client_secret=YOUR_CLIENT_SECRET" \
     --data "config.introspection_endpoint=http://keycloak:8080/realms/myrealm/protocol/openid-connect/token/introspect" \
     --data "config.scopes=openid"
   ```
2. Clients authenticate and pass JWTs directly to Kong.

---

## **2. Using an Auth-Service (Keycloak Behind a Proxy)**
### **How It Works**
- An **auth-service** sits between Kong and Keycloak.
- Clients authenticate via `auth-service`, which forwards requests to Keycloak.
- Kong queries `auth-service` instead of Keycloak for token introspection.

### **Pros ✅**
✔ **Reduces Keycloak load** – `auth-service` can cache token validation results.  
✔ **Security** – Keycloak is hidden from the public network.  
✔ **Flexibility** – Custom logic (logging, user roles, IP restrictions) can be added.  

### **Cons ❌**
✖ **Adds an extra network hop** – Increases request latency.  
✖ **Another service to maintain** – More operational complexity.  
✖ **Potential bottleneck** – If `auth-service` is not well-scaled, it becomes a single point of failure.  

### **When to Use?**
- **For multi-tenancy setups** where multiple services authenticate via a single point.  
- **If you need heavy customization**, such as different authentication flows per client.  
- **When Keycloak is deployed in a private network** and should not be exposed directly.  

### **Setup Example**
1. Deploy an **auth-service** (Node.js, Go, etc.).
2. Configure Kong to validate tokens via `auth-service` instead of Keycloak:
   ```sh
   curl -i -X POST http://localhost:8001/plugins \
     --data "name=openid-connect" \
     --data "config.issuer=http://auth-service:4000/auth" \
     --data "config.client_id=kong-client" \
     --data "config.client_secret=YOUR_CLIENT_SECRET" \
     --data "config.introspection_endpoint=http://auth-service:4000/auth/introspect" \
     --data "config.scopes=openid"
   ```
3. `auth-service` fetches and caches token validation responses.

---

## **3. Which is More Scalable?**
| Feature           | **Direct (Kong ↔ Keycloak)** | **With Auth-Service** |
|------------------|--------------------|----------------|
| **Performance**  | 🔥 Faster (less latency) | 🚀 Extra processing overhead |
| **Scalability**  | 👍 Keycloak scales well with caching | ⚠ Extra scaling needed for `auth-service` |
| **Security**     | 🛡 Keycloak exposed to Kong | 🔐 Keycloak hidden behind auth-service |
| **Customization** | ❌ Limited | ✅ Flexible (custom logic, caching, logging) |
| **Complexity**   | ✅ Simple | ❌ More services to manage |

- **For high-performance APIs** → Use **direct Keycloak integration** with Kong.
- **For advanced security & customization** → Use **auth-service** as an intermediary.

---

## **4. Industry Best Practices**
🔹 **For large-scale setups**, **direct integration with Keycloak** is the most common practice.  
🔹 **For security-sensitive deployments**, enterprises often **use an auth-service** to shield Keycloak.  
🔹 **Caching token validation results** (e.g., Redis) is recommended **if frequent introspection causes performance issues**.  
