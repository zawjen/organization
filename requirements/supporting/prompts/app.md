# Prompts - app

## Search Feature
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
