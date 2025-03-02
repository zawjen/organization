
# cli-dataset-uploader
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
