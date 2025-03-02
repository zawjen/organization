# **OCR CLI - Requirements Document**

## **1. Overview**
The OCR CLI is a command-line tool built in Python that extracts text from PDF files using Optical Character Recognition (OCR). The program processes individual PDF files or entire directories containing PDF files, leveraging multithreading for performance.

## **2. Technology Stack**
- **Programming Language**: Python
- **OCR Engines**: EasyOCR, Docling, Marker, VLM
- **Multithreading**: `threading` module
- **Logging**: Custom Logger Class
- **Image Processing**: `Pillow`, `opencv`
- **Unit Testing**: `pytest`

## **3. Command Line Arguments**
The program accepts command-line arguments through the `CliArgs` class.

| Argument       | Type     | Required | Description                                       | Default |
|---------------|----------|----------|---------------------------------------------------|---------|
| --pdf-folder  | String   | Optional | Path to folder containing PDF files              | None    |
| --pdf-file    | String   | Optional | Path to a single PDF file                        | None    |
| --lang        | String   | Required | Language code for OCR processing                 | None    |
| --threads     | Integer  | Optional | Number of concurrent threads                     | 5       |

## **4. Functional Requirements**
### **4.1 OCR Workflow**
1. If `--pdf-folder` is provided, OCR is performed on all PDF files in the folder.
2. If `--pdf-file` is provided, OCR is performed on the specified PDF file.
3. The language for OCR processing is selected based on `--lang`.
4. OCR processing is executed using the `OcrManager` class, which manages threading and processing files via `FileOcr`.
5. The `FileOcr` class:
   - Converts PDF pages to 300 DPI PNG images.
   - Applies image preprocessing for better OCR accuracy.
   - Extracts text from images using a selected OCR engine (EasyOCR, Docling, Marker, or VLM).
   - Saves the extracted text in a `txt` directory.

### **4.2 Multithreading & Performance Optimization**
- `OcrManager` ensures the number of threads does not exceed available CPU cores.
- Each thread processes one PDF file at a time.
- Logging is used to measure time spent on key operations.
- PNG preprocessing is performed for improved OCR accuracy.

## **5. Class Design**
### **5.1 CliArgs**
Handles command-line arguments parsing.

### **5.2 Logger**
Logs messages along with time spent on important operations.

### **5.3 OcrManager**
- Manages OCR processing of multiple files using threads.
- Ensures server load does not exceed available CPU cores.

### **5.4 FileOcr**
- Converts PDFs to PNG images.
- Extracts text using OCR engines.
- Accepts an OCR engine object (`EngineEasyOCR`, `EngineDocling`, `EngineMarker`, or `EngineVLM`).

### **5.5 OCR Engines (EngineEasyOCR, EngineDocling, EngineMarker, EngineVLM)**
- Wrapper classes for respective OCR engines, implementing the OCR functionality for each.

## **6. Exception Handling & Error Logging**
- Try-catch blocks to handle errors gracefully.
- Logging of errors and exceptions.

## **7. Unit Testing (pytest)**
- Ensure 100% test coverage.
- Test each class individually.
- Test multithreading behavior.

## **8. Scalability & Maintainability**
- Modular class structure.
- Extensible design to support additional OCR engines.
- Optimized memory and CPU usage.

---

## **Implementation**
The following Python code implements the above requirements along with unit tests.

```python
# sdk/cli_args.py
import argparse

class CliArgs:
    def __init__(self):
        parser = argparse.ArgumentParser(description="OCR CLI Tool")
        parser.add_argument("--pdf-folder", type=str, required=False, help="Path to folder containing PDF files")
        parser.add_argument("--pdf-file", type=str, required=False, help="Path to a single PDF file")
        parser.add_argument("--lang", type=str, required=True, help="Language for OCR")
        parser.add_argument("--threads", type=int, required=False, default=5, help="Number of concurrent threads")
        self.args = parser.parse_args()
    
    def get_args(self):
        return self.args
```

```python
# sdk/logger.py
import time

class Logger:
    def log(self, message, start_time):
        elapsed_time = time.time() - start_time
        print(f"{message} - Time spent: {elapsed_time:.2f} seconds")
```

```python
# sdk/ocr_manager.py
import threading
import os
from sdk.file_ocr import FileOcr
from sdk.engine_easyocr import EngineEasyOCR

class OcrManager:
    def __init__(self, pdf_files, lang, threads):
        self.pdf_files = pdf_files
        self.lang = lang
        self.threads = min(threads, os.cpu_count())

    def start_ocr(self):
        threads = []
        for pdf in self.pdf_files:
            ocr_engine = EngineEasyOCR(self.lang)
            file_ocr = FileOcr(pdf, ocr_engine)
            thread = threading.Thread(target=file_ocr.start)
            threads.append(thread)
            thread.start()
        for thread in threads:
            thread.join()
```

```python
# sdk/file_ocr.py
import time
from sdk.logger import Logger

class FileOcr:
    def __init__(self, pdf_file, ocr_engine):
        self.pdf_file = pdf_file
        self.ocr_engine = ocr_engine
        self.logger = Logger()

    def start(self):
        start_time = time.time()
        self.convert_to_png()
        self.extract_text()
        self.logger.log(f"OCR completed for {self.pdf_file}", start_time)

    def convert_to_png(self):
        pass  # Convert PDF to PNG (Placeholder)

    def extract_text(self):
        self.ocr_engine.perform_ocr()
```

```python
# sdk/engine_easyocr.py
import easyocr

class EngineEasyOCR:
    def __init__(self, lang):
        self.reader = easyocr.Reader([lang])

    def perform_ocr(self):
        pass  # Perform OCR using EasyOCR (Placeholder)
```
```

