
## Scrapper CLI
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
- Time spend on important or long running steps should be logged using a Logger class which will have log(self, message, start_time) to calculate time_spent
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
