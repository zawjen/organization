# Introduction

ChatGPT prompts to generate requirements

## Frontend Service

### NextJS Form
To be documented

### ReactNative Form
Write ReactNative and Papper requirements document for mobile app with search textbox with audio button, exact search toggle button and filter button which shows a filter screen with hundreds of filters. Once selected, filter should stay saved during multiple app sessions. When a user types in any text in search textbox and hits Search button, the app should call REST API search-service at zawjen.app.net with JSON of search text, exact match toggle and all filters. The response of REST API search-service will be a JSON containing match found with following data:

- Search text
- Search filters
- Exact match toggle
- Count of matches found
- Number of pages
- Current page
- Array of Dataset 
- Each Dataset will array of Location
- Each Dataset will have following attributes 

Dataset Format: Books, PDFs, Images, Text, Audio, and Videos

Dataset Type: Religion, Politics, Medicine, Law, Sociology, Technology, Education, Economics, History, Ethics, Spirituality etc.

Dataset Classification: 
- Green: Verified as Truth
- Yellow: Doubtful or requires further validation
- Red: Identified as False or Fabricated

Dataset Language
- Arabic
- English
- One of 1000+ other languages 

Dataset Date Created
Dataset Date Updated

Each Location will have following attributes
- Complete text


## Backend Services

### REST Service
We have to build [your-service-name] using NestJS which will be called by NextJs website and ReactNative mobile app. We are using Kong API Gateway which will be used as a gateway to access [your-service-name] from mobile or website. Kong API Gateway or [your-service-name] has to authenticate user using Keycloak.

Write a step by step process document for developer to create [your-service-name], deployed behind Kong API Gateway using Docker and Kubernetes.

Kong API Gateway should be configured to authenticate request using Keycloak.

The [your-service-name] should have a setting 'SERVICE-DOWN', which if set to true will return sample JSON from sample.json file.

Write endpoints for following features:

1- [endpoint 1]: This will return list of datasets
2- [endpoint 2]: This will post a dataset json to save

Create a NextJS and ReactNative forms to call [your-service-name].

[your-service-name] is only be authorized to be called from
1- NextJS website web-zawjen 
2- ReactNative mobile app mob-zawjen 
3- microservices dataset-service 

All other requests must be denied as they are DDoS attacks. 
Add necessary details so [your-service-name] stays highly secure and must be on SSL 

### gRPC Service
