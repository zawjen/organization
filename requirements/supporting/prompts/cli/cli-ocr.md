# cli-ocr
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
