# email-service

## Overview
We will build an **Email-Service** using **NestJS** for bulk sending of billions of transactional emails. The service will use **Postal** as the email server and will be deployed using **Docker**, **Kubernetes**, and **Kong API Gateway** for high scalability and performance. This document outlines the step-by-step process to set up **Email-Service**, **Postal**, and integrate them with **Next.js** and **React Native** applications with **SSL/TLS encryption at all levels**.

---

## Step 1: Setting Up Postal (Mail Server)

### 1.1 Deploy Postal Using Docker with SSL
```sh
mkdir postal && cd postal
docker run -d --name postal \
  -p 25:25 -p 2525:2525 -p 8080:8080 \
  -e POSTAL_SMTP_USER=admin \
  -e POSTAL_SMTP_PASSWORD=admin123 \
  -e POSTAL_DOMAIN=myemailservice.com \
  -e POSTAL_SSL=true \
  ghcr.io/postalserver/postal:latest
```

### 1.2 Configure Postal with SSL
1. Access Postal UI at `https://localhost:8080`
2. Create a new organization
3. Add a mail server and configure DKIM, SPF, and DMARC records
4. Generate an API key for authentication

---

## Step 2: Setting Up Kong API Gateway with SSL

### 2.1 Deploy Kong Using Docker with SSL
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

# Bootstrap Kong with SSL enabled
docker run --rm --network=kong-net \
  -e KONG_DATABASE=$KONG_DATABASE \
  -e KONG_PG_HOST=$KONG_PG_HOST \
  -e KONG_SSL=true \
  kong:latest kong migrations bootstrap

docker run -d --name kong \
  --network=kong-net \
  -e KONG_DATABASE=$KONG_DATABASE \
  -e KONG_PG_HOST=$KONG_PG_HOST \
  -p 8443:8443 \
  -p 8001:8001 \
  kong:latest
```

### 2.2 Secure Kong Routes for Email-Service with SSL
- Add a **Service** in Kong that forwards requests to the `email-service` securely
- Add a **Route** that only allows requests from:
  - **web-zawjen** (Next.js website)
  - **mob-zawjen** (React Native mobile app)
  - **auth-service** (microservice handling authentication)
- Deny all other requests to prevent DDoS attacks
- Enable **Rate Limiting**, **JWT Authentication**, and **SSL Termination** for additional security

```sh
kong service create --name email-service --url https://email-service:3000
kong route create --service email-service --hosts web-zawjen.com,mob-zawjen.com,auth-service.local
kong plugin enable --name jwt --service email-service
kong plugin enable --name rate-limiting --service email-service --config.minute=100
kong plugin enable --name ssl-termination --service email-service
```

---

## Step 3: Setting Up Email-Service with SSL

### 3.1 Initialize a NestJS Project
```sh
mkdir email-service && cd email-service
npx @nestjs/cli new email-service
```

### 3.2 Install Required Packages
```sh
cd email-service
npm install axios @nestjs/config @nestjs/common @nestjs/jwt
```

### 3.3 Implement Secure Email Sending via Postal with SSL

```typescript
import { Injectable, UnauthorizedException } from '@nestjs/common';
import axios from 'axios';
import * as jwt from 'jsonwebtoken';

@Injectable()
export class EmailService {
  private postalApiUrl = 'https://localhost:8080/api/v1/send/email';
  private postalApiKey = 'YOUR_POSTAL_API_KEY';
  private allowedClients = ['web-zawjen', 'mob-zawjen', 'auth-service'];

  async sendEmail(to: string, subject: string, body: string, token: string) {
    try {
      const decoded = jwt.verify(token, 'YOUR_SECRET_KEY');
      if (!this.allowedClients.includes(decoded.iss)) {
        throw new UnauthorizedException('Unauthorized client');
      }
      return axios.post(
        this.postalApiUrl,
        { to, subject, body, from: 'no-reply@myemailservice.com' },
        { headers: { Authorization: `Bearer ${this.postalApiKey}` } }
      );
    } catch (error) {
      throw new UnauthorizedException('Invalid authentication');
    }
  }
}
```

---

## Step 4: Deploying Email-Service with Kubernetes and SSL

### 4.1 Deploy Email-Service Securely
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: email-service
template:
  spec:
    containers:
    - name: email-service
      image: myemailservice/email-service:latest
      env:
      - name: JWT_SECRET
        value: "YOUR_SECRET_KEY"
      ports:
      - containerPort: 3000
      volumeMounts:
      - mountPath: /etc/ssl/certs
        name: ssl-certificates
volumes:
  - name: ssl-certificates
    secret:
      secretName: email-service-tls
```

### 4.2 Deploy Postal with SSL
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postal
template:
  spec:
    containers:
    - name: postal
      image: ghcr.io/postalserver/postal:latest
      ports:
      - containerPort: 8080
      env:
      - name: POSTAL_SSL
        value: "true"
```
