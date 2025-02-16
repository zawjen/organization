# Introduction
Documents Keycloak and Kong integration

Keycloak can be integrated with Kong API Gateway to provide authentication and authorization using OpenID Connect (OIDC) or OAuth 2.0. Here's how you can do it:

---

## **1. Overview of Integration**
Kong acts as the API Gateway, and Keycloak serves as the Identity Provider (IdP). The integration allows Kong to validate access tokens issued by Keycloak before forwarding requests to backend services.

### **Use Cases**
- Protect APIs with OAuth 2.0 / OpenID Connect.
- Enforce authentication using Keycloak.
- Use Keycloak’s Role-Based Access Control (RBAC) with Kong.

---

## **2. Steps to Integrate Keycloak with Kong**
### **Step 1: Install and Configure Keycloak**
1. Install Keycloak and run it:
   ```sh
   docker run -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak start-dev
   ```
2. Access Keycloak at `http://localhost:8080`.
3. Create a new **realm** (e.g., `myrealm`).
4. Create a **client** (e.g., `kong-client`) and set:
   - `Client Protocol: openid-connect`
   - `Access Type: confidential`
   - `Service Accounts Enabled: ON`
5. Create **users** and assign roles if needed.

---

### **Step 2: Configure Kong**
1. **Install Kong Gateway**
   - Follow the [Kong installation guide](https://docs.konghq.com/gateway/latest/install/).

2. **Enable OpenID Connect Plugin**  
   Kong provides an OIDC plugin (`oidc`) that integrates with Keycloak.
   ```sh
   curl -i -X POST http://localhost:8001/plugins \
     --data "name=openid-connect" \
     --data "config.issuer=https://your-keycloak-url/realms/myrealm" \
     --data "config.client_id=kong-client" \
     --data "config.client_secret=YOUR_CLIENT_SECRET" \
     --data "config.redirect_uri=http://localhost:8000/callback" \
     --data "config.scopes=openid"
   ```

3. **Protect an API Service with Keycloak**
   - Add a service:
     ```sh
     curl -i -X POST http://localhost:8001/services \
       --data "name=my-api" \
       --data "url=http://my-backend-service"
     ```
   - Add a route:
     ```sh
     curl -i -X POST http://localhost:8001/services/my-api/routes \
       --data "paths[]=/api"
     ```

4. **Test Authentication Flow**
   - Try accessing `/api` without a token; it should fail.
   - Obtain a token from Keycloak:
     ```sh
     curl -X POST "http://localhost:8080/realms/myrealm/protocol/openid-connect/token" \
       -H "Content-Type: application/x-www-form-urlencoded" \
       -d "client_id=kong-client" \
       -d "client_secret=YOUR_CLIENT_SECRET" \
       -d "grant_type=password" \
       -d "username=user" \
       -d "password=password"
     ```
   - Use the token to access the API:
     ```sh
     curl -H "Authorization: Bearer YOUR_ACCESS_TOKEN" http://localhost:8000/api
     ```

---

## **3. Optional Enhancements**
- **Use Role-Based Access Control (RBAC)**  
  Assign roles in Keycloak and enforce them in Kong using a Lua script or Kong’s authorization plugins.
- **Integrate with Kong Gateway Enterprise**  
  If using Kong Enterprise, you can integrate with Keycloak using Kong’s built-in OpenID Connect plugin for a more seamless experience.
- **Refresh Tokens & Single Sign-On (SSO)**  
  Keycloak supports refresh tokens, allowing users to maintain sessions without frequent logins.

---

## **4. Conclusion**
Using Keycloak with Kong provides a scalable authentication and authorization mechanism for APIs. Kong’s OIDC plugin simplifies token validation, making it easy to secure backend services with Keycloak as the identity provider.

Would you like help with setting this up in your specific environment? 🚀