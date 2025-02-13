# Tech Stack

Following Tech Stack will be used:

1. Zawjen.net will be developed using NextJs and Shadcn due to data, search, filter, SEO, content heavy website with billions of pages like medium.com or wikipedia.com
2. For zawjen admin website we will use same NextJs and Shadcn
3. For zawjen mobile app we will use React native and papper
4. TypeScript everywhere
5. Jest for unit test
6. NestJs Node for backend APIs
7. GitHub api-contract repo for Postman REST API request response JSON, QA automation, frontend testing, backend testing, API documentation, automatic authentication 
8. Kuberneets for service clustering
9. GitHub project for tickets assignment 
10. Markdown to write requirements 
11. OKR and Scrum as process
12. Google Meet for screen sharing calls
13. GitHub organization repo to define engineering and non engineering processes
14. GitHub project to report bugs

## NextJs Rational

- NextJs now seems very natural and logical choice because of SEO, SSR, CSR

## Shadcn Rational

- We will be using Shadcn due to its performance and minimalist design.

## NestJS Rational

For our use case of billions of requests, performance and testibility we have to consider a few things.

When comparing Express.js and NestJS for REST API development, considering performance, scalability, and testability is crucial. Express.js is a lightweight, unopinionated framework that offers maximum flexibility and is ideal for small to medium projects where simplicity and speed matter. However, as applications grow, managing scalability, structure, and maintainability becomes challenging. NestJS, built on top of Express (or Fastify for better performance), provides a modular and opinionated architecture, built-in dependency injection, TypeScript support, and native microservices compatibility, making it better suited for large-scale applications.

From a performance standpoint, Express has lower overhead and is slightly faster for simple APIs, but NestJS with Fastify can outperform it while retaining a well-structured framework. In terms of testability, NestJS has a significant advantage—it comes with built-in support for unit testing, integration testing, and dependency injection, making it easier to mock dependencies and write isolated, maintainable tests using Jest or other testing frameworks. Express, being unopinionated, requires additional setup and third-party libraries for proper test coverage.

Overall, if you need a quick and flexible solution, Express is great, but for scalability, maintainability, built-in testability, and enterprise-grade APIs, NestJS is the better choice.

# Reusability

Create folders and reusable classes in such a way under sdk folder or as npm packages so that they can be unit tested independently and can be reused in

1. Zawjen
2. Zawjen admin 
3. Zawjen mobile app
4. More apps and websites in future

# Unit Test
We will heavily write unit tests using Jest and integration tests using playwright. We will test everywhere web, mobile, frontend and backend.

PR without 100% coverage will not be accepted.

# Lint

- Typescript liniting using ESlint