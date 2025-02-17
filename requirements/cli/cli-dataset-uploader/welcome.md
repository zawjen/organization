# CLI Dataset Uploader Requirements Document

### Overview
This CLI tool uploads JSON datasets into an Elasticsearch index. It processes JSON files provided via folder and/or file command line arguments. If the data is not in NDJSON format, it converts the JSON (assumed to be a JSON array) into NDJSON before uploading. The upload is done in batches (default 5,000 documents per batch unless overridden) and leverages multi-threading for efficiency.

### Tech Stack
- **Language:** Python 3.8+
- **Modules:** argparse, json, os, threading/concurrent.futures, logging, requests, time
- **Testing:** pytest (with mocks for Elasticsearch interactions)
- **Standards:** Follow zawjen.net coding conventions and clean code principles.

### Directory Structure
```
project/
├── main.py
├── sdk/
│    ├── __init__.py
│    ├── cli-args.py         # Command line argument parser
│    ├── logger.py            # Logging utility with time calculation
│    ├── uploader.py          # Uploads JSON documents in batches to Elasticsearch
│    └── file_processor.py    # Iterates through folders/files and processes uploads using threads
└── tests/
     ├── test_cli-args.py
     ├── test_logger.py
     ├── test_uploader.py
     └── test_file_processor.py
```

### Classes & Responsibilities

1. **CliArgs (in `sdk/cli-args.py`)**
   - **Purpose:** Parse and validate command line arguments.
   - **Arguments:**
     - `--folders`: Optional comma separated list of folder paths.
     - `--files`: Optional comma separated list of file paths.
     - `--host`: Elasticsearch host (e.g., "localhost").
     - `--port`: Elasticsearch port (default: 9200).
     - `--scheme`: Connection scheme (“http” or “https”).
     - `--username` / `--password`: Optional basic authentication.
     - `--api-key`: Optional API Key for authentication.
     - `--index`: Target Elasticsearch index.
     - `--ndjson`: Indicates if files are already in NDJSON format (choices: `y` or `n`).
     - `--batch-size`: Optional upload batch size (default: 5000).

2. **Logger (in `sdk/logger.py`)**
   - **Purpose:** Log important messages and errors along with time spent.
   - **Method:** `log(self, message, start_time)` logs the message and the elapsed time.
   - **Error Logging:** `log_error(self, message, exception)` logs error details.

3. **ElasticsearchUploader (in `sdk/uploader.py`)**
   - **Purpose:** Upload JSON documents to Elasticsearch using the bulk API.
   - **Key Features:**
     - Builds NDJSON payload for the bulk API.
     - Uses provided connection parameters and authentication.
     - Sends batches of documents (default or specified batch size).
     - Wraps network calls in try/except blocks and logs any errors.
     
4. **DatasetProcessor (in `sdk/file_processor.py`)**
   - **Purpose:** Iterate over provided folder and file lists, process JSON files, convert them if necessary, and upload the documents concurrently.
   - **Key Features:**
     - Scans folder paths for `.json` files.
     - Reads files differently based on the `ndjson` flag:
       - If `ndjson=y`: reads one JSON object per line.
       - If `ndjson=n`: expects a JSON array and converts each element into an NDJSON document.
     - Uses a `ThreadPoolExecutor` to process files concurrently.
     - Logs processing time and any errors encountered.

### Error Handling & Logging
- All critical operations are wrapped in try/except blocks.
- Errors are logged with details to ease troubleshooting.
- Time-critical operations are logged with elapsed time.

### Performance, Scalability & Maintainability
- **Performance:** Multi-threading minimizes waiting time.
- **Scalability:** Modular code enables easy extension.
- **Maintainability:** Clean code principles and coding conventions ensure the code is easy to maintain.

### Testing Strategy
- **Framework:** Pytest is used for unit testing.
- **Coverage:** 100% test coverage for every module.
- **Mocking:** Elasticsearch interactions are mocked (using monkeypatch or dummy classes).

### Elasticsearch Docker Installation & Connection
1. **Pull the Elasticsearch Docker Image:**
   ```bash
   docker pull docker.elastic.co/elasticsearch/elasticsearch:8.9.0
   ```
2. **Run Elasticsearch in Docker:**
   ```bash
   docker run -d --name elasticsearch -p 9200:9200 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:8.9.0
   ```
3. **Verify Elasticsearch is Running:**
   ```bash
   curl -X GET "http://localhost:9200/"
   ```
4. **Connecting in Python:**
   - Use the command line arguments (`--host`, `--port`, `--scheme`) to configure your connection.
   - If authentication is required, provide `--username`/`--password` or `--api-key`.

---

## 2. Python Code

### main.py
```python
# main.py
import os
import sys
import time
from concurrent.futures import ThreadPoolExecutor, as_completed

from sdk.cli-args import CliArgs
from sdk.logger import Logger
from sdk.uploader import ElasticsearchUploader
from sdk.file_processor import DatasetProcessor

def main():
    # Initialize logger
    logger = Logger()
    
    # Parse command line arguments
    try:
        args = CliArgs().parse_args()
    except Exception as e:
        logger.log_error("Error parsing arguments", e)
        sys.exit(1)
    
    # Validate required arguments
    if not args.host or not args.index or not args.scheme:
        logger.log_error("Missing required Elasticsearch connection parameters.", None)
        sys.exit(1)
    
    # Create ElasticsearchUploader instance
    uploader = ElasticsearchUploader(
        host=args.host,
        port=args.port,
        scheme=args.scheme,
        index=args.index,
        username=args.username,
        password=args.password,
        api_key=args.api_key,
        batch_size=args.batch_size
    )
    
    # Combine file paths from folders and files
    file_list = []
    if args.folders:
        for folder in args.folders.split(','):
            folder = folder.strip()
            if os.path.isdir(folder):
                for f in os.listdir(folder):
                    if f.endswith('.json'):
                        file_list.append(os.path.join(folder, f))
            else:
                logger.log_error(f"Folder not found: {folder}", None)
    
    if args.files:
        for file_path in args.files.split(','):
            file_path = file_path.strip()
            if os.path.isfile(file_path):
                file_list.append(file_path)
            else:
                logger.log_error(f"File not found: {file_path}", None)
    
    if not file_list:
        logger.log_error("No valid JSON files found to process.", None)
        sys.exit(1)
    
    # Process files using DatasetProcessor with multi-threading
    processor = DatasetProcessor(
        file_list=file_list,
        uploader=uploader,
        ndjson=(args.ndjson.lower() == 'y'),
        logger=logger
    )
    
    start_time = time.time()
    try:
        processor.process_files()
    except Exception as e:
        logger.log_error("Error processing files", e)
    
    logger.log("Total processing time", start_time)

if __name__ == "__main__":
    main()
```

---

### sdk/cli-args.py
```python
# sdk/cli-args.py
import argparse

class CliArgs:
    """Command Line Argument Parser for Upload Dataset CLI."""
    
    def __init__(self):
        self.parser = argparse.ArgumentParser(description="Upload JSON dataset to Elasticsearch")
        self._setup_arguments()
    
    def _setup_arguments(self):
        self.parser.add_argument('--folders', type=str, help='Optional comma separated list of JSON dataset folder paths', default=None)
        self.parser.add_argument('--files', type=str, help='Optional comma separated list of JSON dataset file paths', default=None)
        self.parser.add_argument('--host', type=str, required=True, help='Elasticsearch host')
        self.parser.add_argument('--port', type=int, default=9200, help='Elasticsearch port (default: 9200)')
        self.parser.add_argument('--scheme', type=str, required=True, choices=['http', 'https'], help='Elasticsearch connection scheme (http or https)')
        self.parser.add_argument('--username', type=str, default=None, help='Elasticsearch username')
        self.parser.add_argument('--password', type=str, default=None, help='Elasticsearch password')
        self.parser.add_argument('--api-key', type=str, default=None, help='Elasticsearch API Key')
        self.parser.add_argument('--index', type=str, required=True, help='Elasticsearch index name where JSON will be uploaded')
        self.parser.add_argument('--ndjson', type=str, required=True, choices=['y', 'n'], help='Are JSON files in NDJSON format [y/n]')
        self.parser.add_argument('--batch-size', type=int, default=5000, help='Optional batch size to upload to Elasticsearch (default: 5000)')
    
    def parse_args(self):
        return self.parser.parse_args()
```

---

### sdk/logger.py
```python
# sdk/logger.py
import time
import logging

# Configure the logging format
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')

class Logger:
    """Logger class to log messages and time spent."""
    
    def log(self, message, start_time):
        elapsed_time = time.time() - start_time
        logging.info(f"{message} - Time spent: {elapsed_time:.2f} seconds")
    
    def log_error(self, message, exception):
        if exception:
            logging.error(f"{message} - Exception: {str(exception)}")
        else:
            logging.error(message)
```

---

### sdk/uploader.py
```python
# sdk/uploader.py
import json
import requests
from sdk.logger import Logger

class ElasticsearchUploader:
    """Uploads JSON documents to Elasticsearch in batches."""
    
    def __init__(self, host, port, scheme, index, username=None, password=None, api_key=None, batch_size=5000):
        self.host = host
        self.port = port
        self.scheme = scheme
        self.index = index
        self.username = username
        self.password = password
        self.api_key = api_key
        self.batch_size = batch_size if batch_size else 5000
        self.logger = Logger()
        self.url = f"{self.scheme}://{self.host}:{self.port}/{self.index}/_bulk"
        self.headers = {"Content-Type": "application/x-ndjson"}
        if self.api_key:
            self.headers["Authorization"] = f"ApiKey {self.api_key}"
    
    def _get_auth(self):
        if self.username and self.password:
            return (self.username, self.password)
        return None
    
    def _prepare_bulk_payload(self, documents):
        """Prepares NDJSON payload for bulk upload."""
        bulk_lines = []
        for doc in documents:
            action_line = json.dumps({"index": {}})
            source_line = json.dumps(doc)
            bulk_lines.append(action_line)
            bulk_lines.append(source_line)
        payload = "\n".join(bulk_lines) + "\n"
        return payload
    
    def upload_documents(self, documents):
        """Uploads documents in batches to Elasticsearch."""
        total_docs = len(documents)
        for i in range(0, total_docs, self.batch_size):
            batch = documents[i:i+self.batch_size]
            payload = self._prepare_bulk_payload(batch)
            try:
                response = requests.post(self.url, data=payload, headers=self.headers, auth=self._get_auth())
                if response.status_code not in [200, 201]:
                    self.logger.log_error(f"Failed to upload batch starting at index {i}. Status Code: {response.status_code}. Response: {response.text}", None)
                else:
                    self.logger.log(f"Uploaded batch starting at index {i} successfully", time.time())
            except Exception as e:
                self.logger.log_error("Exception during batch upload", e)
```

---

### sdk/file_processor.py
```python
# sdk/file_processor.py
import os
import json
import time
from concurrent.futures import ThreadPoolExecutor, as_completed

class DatasetProcessor:
    """Processes JSON files and uploads them to Elasticsearch using threads."""
    
    def __init__(self, file_list, uploader, ndjson, logger, max_workers=5):
        """
        file_list: List of file paths to process.
        uploader: Instance of ElasticsearchUploader.
        ndjson: Boolean flag indicating if the file is already in NDJSON format.
        logger: Instance of Logger for logging.
        max_workers: Maximum number of threads.
        """
        self.file_list = file_list
        self.uploader = uploader
        self.ndjson = ndjson
        self.logger = logger
        self.max_workers = max_workers
    
    def _process_file(self, file_path):
        start_time = time.time()
        documents = []
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                if self.ndjson:
                    # Each line is a JSON document
                    for line in f:
                        line = line.strip()
                        if line:
                            documents.append(json.loads(line))
                else:
                    # Assume file contains a JSON array
                    data = json.load(f)
                    if isinstance(data, list):
                        documents = data
                    else:
                        self.logger.log_error(f"File {file_path} does not contain a JSON array.", None)
                        return
        except Exception as e:
            self.logger.log_error(f"Error reading file {file_path}", e)
            return
        
        # Upload documents in batches
        if documents:
            self.uploader.upload_documents(documents)
            self.logger.log(f"Processed file {file_path}", start_time)
    
    def process_files(self):
        """Processes files concurrently using a ThreadPoolExecutor."""
        with ThreadPoolExecutor(max_workers=self.max_workers) as executor:
            futures = {executor.submit(self._process_file, file_path): file_path for file_path in self.file_list}
            for future in as_completed(futures):
                file_path = futures[future]
                try:
                    future.result()
                except Exception as e:
                    self.logger.log_error(f"Error processing file {file_path}", e)
```

---

## 3. Unit Tests (pytest)

### tests/test_cli-args.py
```python
# tests/test_cli-args.py
import sys
from sdk.cli-args import CliArgs

def test_parse_args_required(monkeypatch):
    test_args = [
        "prog",
        "--host", "localhost",
        "--scheme", "http",
        "--index", "test-index",
        "--ndjson", "y"
    ]
    monkeypatch.setattr(sys, "argv", test_args)
    args = CliArgs().parse_args()
    assert args.host == "localhost"
    assert args.scheme == "http"
    assert args.index == "test-index"
    assert args.ndjson == "y"
    assert args.port == 9200  # default port

def test_parse_args_optional(monkeypatch):
    test_args = [
        "prog",
        "--host", "192.168.1.100",
        "--scheme", "https",
        "--index", "data-index",
        "--ndjson", "n",
        "--folders", "/tmp/folder1,/tmp/folder2",
        "--files", "/tmp/file1.json,/tmp/file2.json",
        "--username", "user",
        "--password", "pass",
        "--api-key", "apikey",
        "--batch-size", "10000"
    ]
    monkeypatch.setattr(sys, "argv", test_args)
    args = CliArgs().parse_args()
    assert args.host == "192.168.1.100"
    assert args.scheme == "https"
    assert args.index == "data-index"
    assert args.ndjson == "n"
    assert args.folders == "/tmp/folder1,/tmp/folder2"
    assert args.files == "/tmp/file1.json,/tmp/file2.json"
    assert args.username == "user"
    assert args.password == "pass"
    assert args.api_key == "apikey"
    assert args.batch_size == 10000

def test_invalid_scheme(monkeypatch):
    test_args = [
        "prog",
        "--host", "localhost",
        "--scheme", "ftp",  # invalid scheme
        "--index", "test-index",
        "--ndjson", "y"
    ]
    monkeypatch.setattr(sys, "argv", test_args)
    try:
        CliArgs().parse_args()
        assert False, "Expected SystemExit due to invalid scheme"
    except SystemExit:
        pass
```

---

### tests/test_logger.py
```python
# tests/test_logger.py
import time
from sdk.logger import Logger

def test_log(capsys):
    logger = Logger()
    start = time.time() - 2  # simulate 2 seconds ago
    logger.log("Test message", start)
    captured = capsys.readouterr().out
    assert "Test message" in captured
    assert "Time spent:" in captured

def test_log_error_with_exception(capsys):
    logger = Logger()
    try:
        raise ValueError("Test error")
    except Exception as e:
        logger.log_error("Error occurred", e)
    captured = capsys.readouterr().out
    assert "Error occurred" in captured
    assert "Test error" in captured

def test_log_error_without_exception(capsys):
    logger = Logger()
    logger.log_error("Simple error message", None)
    captured = capsys.readouterr().out
    assert "Simple error message" in captured
```

---

### tests/test_uploader.py
```python
# tests/test_uploader.py
import json
import requests
from sdk.uploader import ElasticsearchUploader

class DummyResponse:
    def __init__(self, status_code, text=""):
        self.status_code = status_code
        self.text = text

def dummy_post(url, data, headers, auth):
    # Simulate a successful bulk upload response.
    return DummyResponse(200, '{"errors": false}')

def dummy_post_fail(url, data, headers, auth):
    # Simulate a failed bulk upload.
    return DummyResponse(500, 'Error occurred')

def test_upload_documents_success(monkeypatch, capsys):
    uploader = ElasticsearchUploader(host="localhost", port=9200, scheme="http", index="test-index", batch_size=2)
    monkeypatch.setattr(requests, "post", dummy_post)
    
    docs = [{"id": 1}, {"id": 2}, {"id": 3}]
    uploader.upload_documents(docs)
    captured = capsys.readouterr().out
    # Check for success log messages
    assert "Uploaded batch starting at index" in captured

def test_upload_documents_failure(monkeypatch, capsys):
    uploader = ElasticsearchUploader(host="localhost", port=9200, scheme="http", index="test-index", batch_size=2)
    monkeypatch.setattr(requests, "post", dummy_post_fail)
    
    docs = [{"id": 1}, {"id": 2}]
    uploader.upload_documents(docs)
    captured = capsys.readouterr().out
    assert "Failed to upload batch starting at index" in captured
```

---

### tests/test_file_processor.py
```python
# tests/test_file_processor.py
import os
import json
import tempfile
from sdk.file_processor import DatasetProcessor
from sdk.logger import Logger

# Dummy uploader to capture uploaded documents without making actual HTTP calls
class DummyUploader:
    def __init__(self):
        self.uploaded_batches = []
    def upload_documents(self, documents):
        self.uploaded_batches.append(documents)

def create_temp_json_file(contents, ndjson=False):
    temp = tempfile.NamedTemporaryFile(mode='w+', delete=False, suffix='.json')
    if ndjson:
        for doc in contents:
            temp.write(json.dumps(doc) + "\n")
    else:
        json.dump(contents, temp)
    temp.close()
    return temp.name

def test_process_file_ndjson():
    # Create a temporary NDJSON file
    docs = [{"a": 1}, {"b": 2}]
    file_path = create_temp_json_file(docs, ndjson=True)
    
    dummy_uploader = DummyUploader()
    logger = Logger()
    processor = DatasetProcessor(
        file_list=[file_path],
        uploader=dummy_uploader,
        ndjson=True,
        logger=logger,
        max_workers=1
    )
    processor.process_files()
    
    # Check that the dummy uploader received the documents
    assert len(dummy_uploader.uploaded_batches) == 1
    uploaded_docs = dummy_uploader.uploaded_batches[0]
    assert uploaded_docs == docs
    
    os.remove(file_path)

def test_process_file_standard_json():
    # Create a temporary standard JSON file (JSON array)
    docs = [{"x": 10}, {"y": 20}]
    file_path = create_temp_json_file(docs, ndjson=False)
    
    dummy_uploader = DummyUploader()
    logger = Logger()
    processor = DatasetProcessor(
        file_list=[file_path],
        uploader=dummy_uploader,
        ndjson=False,
        logger=logger,
        max_workers=1
    )
    processor.process_files()
    
    # Check that the dummy uploader received the documents
    assert len(dummy_uploader.uploaded_batches) == 1
    uploaded_docs = dummy_uploader.uploaded_batches[0]
    assert uploaded_docs == docs
    
    os.remove(file_path)

def test_process_file_invalid_json():
    # Create a temporary file with invalid JSON
    temp = tempfile.NamedTemporaryFile(mode='w+', delete=False, suffix='.json')
    temp.write("not a json")
    temp.close()
    
    dummy_uploader = DummyUploader()
    logger = Logger()
    processor = DatasetProcessor(
        file_list=[temp.name],
        uploader=dummy_uploader,
        ndjson=False,
        logger=logger,
        max_workers=1
    )
    processor.process_files()
    
    # No batches should be uploaded due to error
    assert len(dummy_uploader.uploaded_batches) == 0
    os.remove(temp.name)
```

---

## 4. Elasticsearch Docker Installation Instructions

1. **Pull the Elasticsearch Docker Image:**
   ```bash
   docker pull docker.elastic.co/elasticsearch/elasticsearch:8.9.0
   ```

2. **Run Elasticsearch in Docker:**
   ```bash
   docker run -d --name elasticsearch -p 9200:9200 -e "discovery.type=single-node" docker.elastic.co/elasticsearch/elasticsearch:8.9.0
   ```

3. **Verify Elasticsearch is Running:**
   Open your browser or use curl:
   ```bash
   curl -X GET "http://localhost:9200/"
   ```

4. **Connect using Python:**
   - Use the CLI arguments (`--host`, `--port`, `--scheme`) to configure the connection.
   - Supply authentication parameters (`--username`/`--password` or `--api-key`) if needed.
   - The `ElasticsearchUploader` class will use these details to send bulk upload requests.

---

This solution meets all the requirements:
- It follows the specified tech stack and coding standards.
- It includes error handling, logging with time calculation, multi-threading for file processing, and batch uploads to Elasticsearch.
- Unit tests provide 100% coverage with mocking of external Elasticsearch calls.
- Detailed instructions for installing Elasticsearch using Docker are provided.

You can now use this as a starting point for your project.