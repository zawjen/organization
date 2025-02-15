# Introduction

ChatGPT prompts to generate requirements

## Frontend Service

### Web
Write detailed Search Feature requirements document for a developer. Write code for each NextJs/Shadcn UI, complete functionality and its unit tests using Jest mentioned below

The website is using following tech stack
1- NextJs 
2- Shadcn

Feature Details
- A screen with search textbox, audio button and a search button
- A clear text button will appear if textbox is not empty
- A rectangle filter button which shows a filter screen with hundreds of filters with filter name and controls.
- All filters can be obtained by making a REST API call to filter-service. The response of this service will be JSON containing all the filters mentioned in [data dictionary](https://github.com/zawjen/organization/blob/main/requirements/data-dictionary/welcome.md) 
- A filter screen will have all the filters mentioned in [data dictionary](https://github.com/zawjen/organization/blob/main/requirements/data-dictionary/welcome.md) 
- Once filters are selected, they should stay saved during multiple user sessions. 
- When a user types in any text in search textbox and hits Search button, the app should call REST API search-service at zawjen.app.net with JSON of search text and all filters array. The response of REST API search-service will be a JSON containing match found with following response mentioned under Response.
- The response should be shown in a clean way in the form or article. With all read, green and yellow content background having lightly colored with same color
- All response attributes should be cleanly displayed as a link, taking user to its detail page
- User should be allowed to download article as pdf, word or png.
- User should be allowed to copy a url along with search text, filters and all the details
- User can share article on social media
- All user searches will be stored in history using REST API call to user-history service
- User can clean history or turn off history using REST API call to user-history service
- Write each Request and its Response JSON for all the services and endpoints called in this document at the end of document
- All microservice endpoints are available at zawjen.app.net

Write sections about following general requirements:
1- Follow zawjen.net coding convention
2- Write 100% coverage unit tests
3- Solution must be highly performant, low on memory, cpu and battery
4. Highly scalable and maintainable
5. Following zawjen.net clean coding principals
6. Use try-catch and log errors
7. See Zawjen.net [data dictionary](https://github.com/zawjen/organization/blob/main/requirements/data-dictionary/welcome.md) for further details about the terms used in this document
8. See [api-contracts](https://github.com/zawjen/api-contracts) repo for microservice request and response JSON
9. Design mobile-first UX for better user experience and google ranking

JSON Response
- Search text
- Search filters
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
- text








### App
Write detailed Search Feature requirements document for a developer. Write code for each ReactNative/Papper UI, complete functionality and its unit tests using Jest mentioned below

The website is using following tech stack
1- ReactNative 
2- Papper

Feature Details
- A screen with search textbox, audio button and a search button
- A clear text button will appear if textbox is not empty
- A rectangle filter button which shows a filter screen with hundreds of filters with filter name and controls.
- All filters can be obtained by making a REST API call to filter-service. The response of this service will be JSON containing all the filters mentioned in [data dictionary](https://github.com/zawjen/organization/blob/main/requirements/data-dictionary/welcome.md) 
- A filter screen will have all the filters mentioned in [data dictionary](https://github.com/zawjen/organization/blob/main/requirements/data-dictionary/welcome.md) 
- Once filters are selected, they should stay saved during multiple user sessions. 
- When a user types in any text in search textbox and hits Search button, the app should call REST API search-service at zawjen.app.net with JSON of search text and all filters array. The response of REST API search-service will be a JSON containing match found with following response mentioned under Response.
- The response should be shown in a clean way in the form or article. With all read, green and yellow content background having lightly colored with same color
- All response attributes should be cleanly displayed as a link, taking user to its detail page
- User should be allowed to download article as pdf, word or png.
- User should be allowed to copy a url along with search text, filters and all the details
- User can share article on social media
- All user searches will be stored in history using REST API call to user-history service
- User can clean history or turn off history using REST API call to user-history service
- Write each Request and its Response JSON for all the services and endpoints called in this document at the end of document
- All microservice endpoints are available at zawjen.app.net

Write sections about following general requirements:
1- Follow zawjen.net coding convention
2- Write 100% coverage unit tests
3- Solution must be highly performant, low on memory, cpu and battery
4. Highly scalable and maintainable
5. Following zawjen.net clean coding principals
6. Use try-catch and log errors
7. See Zawjen.net [data dictionary](https://github.com/zawjen/organization/blob/main/requirements/data-dictionary/welcome.md) for further details about the terms used in this document
8. See [api-contracts](https://github.com/zawjen/api-contracts) repo for microservice request and response JSON
9. Design mobile-first UX for better user experience and google ranking

JSON Response
- Search text
- Search filters
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
- text




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
