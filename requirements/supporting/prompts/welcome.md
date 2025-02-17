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
- Follow zawjen.net coding convention and clean coding principals
- Write 100% coverage unit tests
- Solution must be highly performant, low on memory, cpu and battery
- Highly scalable and maintainable
- Use try-catch and log errors
- See Zawjen.net [data dictionary](https://github.com/zawjen/organization/blob/main/requirements/data-dictionary/welcome.md) for further details about the terms used in this document
- See [api-contracts](https://github.com/zawjen/api-contracts) repo for microservice request and response JSON
- Design mobile-first UX for better user experience and google ranking

JSON Response
- Search text
- Search filters
- Count of matches found
- Number of pages
- Current page
- Array of Dataset 
- Each Dataset will array of Location
- Each Dataset will have following attributes 
- Dataset Format: Books, PDFs, Images, Text, Audio, and Videos
- Dataset Type: Religion, Politics, Medicine, Law, Sociology, Technology, Education, Economics, History, Ethics, Spirituality etc.
- Dataset Classification: 
    - Green: Verified as Truth
    - Yellow: Doubtful or requires further validation
    - Red: Identified as False or Fabricated
- Dataset Language
    - Arabic
    - English
    - One of 1000+ other languages 
- Dataset Date Created
- Dataset Date Updated
- Each Location will have following attributes
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
- Follow zawjen.net coding convention and clean coding principals
- Write 100% coverage unit tests
- Solution must be highly performant, low on memory, cpu and battery
- Highly scalable and maintainable
- Use try-catch and log errors
- See Zawjen.net [data dictionary](https://github.com/zawjen/organization/blob/main/requirements/data-dictionary/welcome.md) for further details about the terms used in this document
- See [api-contracts](https://github.com/zawjen/api-contracts) repo for microservice request and response JSON
- Design mobile-first UX for better user experience and google ranking

JSON Response
- Search text
- Search filters
- Count of matches found
- Number of pages
- Current page
- Array of Dataset 
- Each Dataset will array of Location
- Each Dataset will have following attributes 
- Dataset Format: Books, PDFs, Images, Text, Audio, and Videos
- Dataset Type: Religion, Politics, Medicine, Law, Sociology, Technology, Education, Economics, History, Ethics, Spirituality etc.
- Dataset Classification: 
    - Green: Verified as Truth
    - Yellow: Doubtful or requires further validation
    - Red: Identified as False or Fabricated
- Dataset Language
    - Arabic
    - English
    - One of 1000+ other languages 
- Dataset Date Created
- Dataset Date Updated
- Each Location will have following attributes
    - text

## Backend Services
---
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
To be documented
---

### CLI
#### Scrapper CLI
Write detailed [Scrapper CLI] requirements document for a developer. Write code for each Python class, complete functionality and its unit tests using pytest mentioned below. Follow all instructions below. Do not skip any requirement below.

The CLI built using following tech stack
1- Python 

Feature Details
- All classes must be under sdk folder
- Program should start from main.py
- A command line argument class CliArgs that accepts following arguments. Create a table in document.
    - --download-folder: Optional Location to download scrapped website
    - --url: Required comma separated list of Url of websites to download
    - --threads: Optional number of concurrent threads to be used for scrapping. Default is 5
- Time spend on important or long running steps should be logged using a logger class which will have log(self, message, start_time) to calculate time_spent
- if download-folder is specified, use that folder to save scrapped files. Create folder if it does not exists
- A Downloader class to download from specified urls in multithreaded way. Respect the website’s robots.txt file and make sure not to overload the server with thread more than specified in robots.txt of website. 
- Each link of every page should be downloaded, possibly in a separate thread as specified in argument --threads. If --threads is not specified, the default should be 5 or less than or equal to specified in robots.txt
- Once the page is downloaded, JsonConverter class should be called. It should find class to call to convert HtmlToJson using switch case on page Url. So, for page url www.xyz.com/page1.html, start a thread of a class and call class JsonXyz with page url.
- Do not create threads more than CPU cores available on machine
- Follow zawjen.net coding convention and clean coding principals
- Write 100% coverage unit tests
- Solution must be highly performant, low on memory, cpu and battery
- Highly scalable and maintainable
- Use try-catch and log errors
- See Zawjen.net [data dictionary](https://github.com/zawjen/organization/blob/main/requirements/data-dictionary/welcome.md) for further details about the terms used in this document
- write code for each class
- write 100% test coverage using pytest.

#### Upload Dataset CLI
Write detailed [Upload Dataset CLI] requirements document for a developer. Write code for each Python class, complete functionality and its unit tests using pytest mentioned below. Follow all instructions below. Do not skip any requirement below.

The CLI built using following tech stack
1- Python 

Feature Details
- All classes must be under sdk folder
- Program should start from main.py
- A command line argument class that accepts following arguments. Create a table in document.
    - --folders: Optional comma separated list of JSON dataset folder paths
    - --files: Optional comma separated list of JSON dataset file paths
    - --host: Elasticsearch host (e.g., "localhost", "192.168.1.100")
    - --port: Elasticsearch port (default is 9200)
    - --scheme: Elasticsearch Connection scheme (http or https)
    - --username: Optional Elasticsearch username
    - --password: Optional Elasticsearch password
    - --api-key: Optional Elasticsearch API Key
    - --index: ElasticSearch index name where JSON will be uploaded
    - --ndjson: Are JSON files in NDJSON format [y/n]
    - --batch-size: Optional Batch size to upload to ElasticSearch 
- A class which iterates over list of folders and files and create threads to upload JSON files in ElasticSearch
- if ndjson=n then convert JSON to NDJSON before batch upload
- A class to upload JSON files to specified index. Send batches of batch-size documents at a time. if batch-size is not specified upload data in batches of 5,000 - 10,000 documents per request.
- Time spend on important or long running steps should be logged using a log class which will have log(self, message, start_time) to calculate time_spent
- if username and password are specified, use them to connect to Elasticsearch. If api-key is specified, use it to connect to Elasticsearch
- Follow zawjen.net coding convention and clean coding principals
- Write 100% coverage unit tests
- Solution must be highly performant, low on memory, cpu and battery
- Highly scalable and maintainable
- Use try-catch and log errors
- See Zawjen.net [data dictionary](https://github.com/zawjen/organization/blob/main/requirements/data-dictionary/welcome.md) for further details about the terms used in this document
- write code for each class
- write 100% test coverage using pytest.
- Mock Elasticsearch for unit testing.
- add detailed steps to install ElasticSearch as docker and connect it using Python

## Datasets
Write a document describing following

- A process to install git and GitHub Desktop
- A process to GitHub repository with name equals a dash separated book name, year of publication, city of publication, publisher name
- Select a checkbox create readme.md during repository creation process
- Edit readme.md and provide a link to original place from where pdfs were downloaded
- A process to download repo using GitHub Desktop
- Create pdf, png, txt and json folders under repository and add .gitkeep file
- A process to Commit and Push repository using GitHub Desktop