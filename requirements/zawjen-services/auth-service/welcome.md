# Auth-Service Development Guide

## Overview
We will build an **Auth-Service** using **NestJS** that will handle user authentication for both a **Next.js website** and a **React Native mobile app**. The authentication will be managed through **Keycloak**, with **Kong API Gateway** acting as the entry point for all authentication requests. This document outlines the step-by-step process to set up **Auth-Service**, **Kong API Gateway**, and **Keycloak** using **Docker** and **Kubernetes**.

---

## Step 1: Setting Up Keycloak

### 1.1 Deploy Keycloak Using Docker
```sh
mkdir keycloak && cd keycloak
docker run -d \
  --name keycloak \
  -p 8080:8080 \
  -e KEYCLOAK_ADMIN=admin \
  -e KEYCLOAK_ADMIN_PASSWORD=admin123 \
  quay.io/keycloak/keycloak:latest start-dev
```

### 1.2 Create a Realm and Client
1. Access Keycloak at `http://localhost:8080`
2. Log in using `admin/admin123`
3. Create a **Realm** (e.g., `MyRealm`)
4. Create a **Client** (e.g., `my-app`) with **OpenID Connect**
5. Set the **Access Type** to `public`
6. Configure **Valid Redirect URIs** to accept requests from `http://localhost:3000/*` (Next.js) and `http://localhost:19006/*` (React Native Expo)
7. Save and generate client credentials

### 1.3 Configure User Authentication Flow
- Enable `Username & Password` login
- Enable `Social Login` (Google, Facebook)
- Enable `MFA` (TOTP, Email-based verification)

---

## Step 2: Setting Up Kong API Gateway

### 2.1 Deploy Kong Using Docker
```sh
docker network create kong-net

docker run -d --name kong-database \
  --network=kong-net \
  -p 5432:5432 \
  -e POSTGRES_USER=kong \
  -e POSTGRES_DB=kong \
  -e POSTGRES_PASSWORD=kongpass \
  postgres:13

export KONG_DATABASE=postgres
export KONG_PG_HOST=kong-database

docker run --rm --network=kong-net \
  -e KONG_DATABASE=$KONG_DATABASE \
  -e KONG_PG_HOST=$KONG_PG_HOST \
  kong:latest kong migrations bootstrap

docker run -d --name kong \
  --network=kong-net \
  -e KONG_DATABASE=$KONG_DATABASE \
  -e KONG_PG_HOST=$KONG_PG_HOST \
  -p 8000:8000 \
  -p 8443:8443 \
  -p 8001:8001 \
  kong:latest
```

### 2.2 Configure Kong to Use Keycloak for Authentication
- Add a new **Service** in Kong that forwards requests to the `auth-service`
- Add a **Route** to expose the service
- Enable **JWT Plugin** to validate Keycloak tokens

---

## Step 3: Setting Up Auth-Service

### 3.1 Initialize a NestJS Project
```sh
mkdir auth-service && cd auth-service
npx @nestjs/cli new auth-service
```

### 3.2 Install Required Packages
```sh
cd auth-service
npm install @nestjs/jwt @nestjs/passport passport passport-jwt passport-local axios bcryptjs dotenv
```

### 3.3 Implement Keycloak Authentication
- Use **OAuth2 with JWT** for authentication.
- Store Keycloak's public key to validate JWT tokens.

```typescript
import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';

@Injectable()
export class AuthService {
  constructor(private jwtService: JwtService) {}

  async validateUser(token: string): Promise<any> {
    const decoded = this.jwtService.verify(token);
    return decoded ? decoded : null;
  }
}
```

### 3.4 Implement Fake Authentication Mode
- Add a **config flag** to always authenticate users without actual Keycloak validation.

```typescript
const AUTH_BYPASS = process.env.AUTH_BYPASS === 'true';

if (AUTH_BYPASS) {
  return { userId: 'test-user', email: 'test@example.com' };
}
```

---

## Step 4: Implementing Security Enhancements

### 4.1 Restrict Access to Authorized Clients Only
Modify `email-service` so only the following can access it:
- `web-zawjen` (Next.js Website)
- `mob-zawjen` (React Native App)
- `dataset-service` (Microservice for dataset processing)

All other requests should be rejected as potential DDoS attacks. This can be done using Kong API Gateway authentication plugins and JWT verification.

### 4.2 Enforce SSL for Secure Communication
- Configure Keycloak, Kong API Gateway, and Auth-Service to enforce HTTPS connections only.
- Reject all HTTP requests to prevent man-in-the-middle attacks.

Example Kong configuration:
```sh
kong config set enforce-ssl=true
```

---

## Step 5: Implementing Forgot Password Workflow
1. User submits email
2. Generate a reset token and store in database
3. Send email with reset link (handled by `email-service`)
4. User submits new password
5. Validate token and update password in Keycloak

---

## Step 6: Implementing MFA Support
- Generate and store OTP secret in database
- Send OTP via email (`email-service`)
- Validate OTP before allowing login

```typescript
const otp = Math.floor(100000 + Math.random() * 900000);
await emailService.sendOtp(user.email, otp);
```

---

## Step 7: Implementing Social Login
- Enable social login in Keycloak
- Obtain access tokens from Google/Facebook
- Verify tokens with Keycloak

```typescript
const googleToken = 'GOOGLE_ACCESS_TOKEN';
const userInfo = await axios.get(`https://oauth2.googleapis.com/tokeninfo?id_token=${googleToken}`);
```

---

## Step 8: Setting Up Next.js & React Native Frontend

### 8.1 Implement Login Form
- Email & Password
- Social Login Buttons
- Forgot Password Link
- MFA Code Input

```jsx
<form>
  <input type="email" placeholder="Enter email" />
  <input type="password" placeholder="Enter password" />
  <button>Login</button>
  <button>Login with Google</button>
  <a href="/forgot-password">Forgot Password?</a>
</form>
```
