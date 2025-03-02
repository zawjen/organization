# Prompts - cli

# cli-dataset-tagger
To be documented

## OCR CLI
Write detailed [OCR CLI] requirements document for a developer. Write code for each Python class, complete functionality and its unit tests using pytest mentioned below. Follow all instructions below. Do not skip any requirement below.

The CLI built using following tech stack
1- Python 

Feature Details
- All classes must be under sdk folder
- Program should start from main.py
- A command line argument class CliArgs that accepts following arguments. Create a table in document.
    - --pdf-folder: Optional Location of folder, where PDF for OCR are placed
    - --pdf-file: Optional Location of PDF file for OCR
    - --lang: Required language of PDF
    - --threads: Optional number of concurrent threads to be used for OCR. Default is 5
- Time spend on important or long running steps should be logged using a logger class which will have log(self, message, start_time) to calculate time_spent
- if pdf-folder is specified, use that folder to perform OCR on all PDF files in that folder. 
- if pdf-file is specified, use that file to perform OCR. 
- Use lang to select language of OCR Engine. 
- A OcrManager class to call FileOcr class to perform OCR for specified files in multithreaded. 
- FileOcr should perform actual OCR, by creating a 300 DPI PNG image under png folder and then extracting text and placing it under txt folder. Both PNG and txt file name should be in format PDF-name-page-number.
- OcrManager should only create instance of FileOcr in a separate thread and call start method to perform OCR
- Make sure OcrManager do not to overload the server with thread more than number of CPU cores available. 
- Do not create threads more than CPU cores available on machine
- Perform PNG pre processing to get better OCR results
- FileOcr should be passed class object of EngineEasyOCR, EngineDocling, EngineMarker, EngineVLM which should have actual library specific code to perform OCR from PNG for lang specific in command line parameter
- Follow zawjen.net coding convention and clean coding principals
- Write 100% coverage unit tests
- Solution must be highly performant, low on memory, cpu and battery
- Highly scalable and maintainable
- Use try-catch and log errors
- See Zawjen.net [data dictionary](https://github.com/zawjen/organization/blob/main/requirements/data-dictionary/welcome.md) for further details about the terms used in this document
- write code for each class
- write 100% test coverage using pytest.

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

## Upload Dataset CLI
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
