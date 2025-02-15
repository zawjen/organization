# Data Dictionary

This document is a data dictionary (or DDD Ubiquitous Language) for **Zawjen.net** products.

- It is a shared vocabulary between developers, domain experts, and stakeholders. 
- It ensures alignment between technical experts, domain experts, non-technical staff and end-users.
- It ensures consistent and precise communication across the project.
- It is implemented within Bounded Contexts, meaning different parts of the system may have different definitions for the same term.

--- 
## **Core Concepts**

### **Dataset**
A collection of digital content such as **Books, PDFs, Images, Text, Audio, and Videos**, used in zawjen.net search and filter system.

### **Dataset Language**
Dataset can be in one or more languages. 

### **Dataset Translated Language**
Dataset can be translated from its original language into one or more languages. 

### **Dataset Formats**  
A dataset in Zawjen.net can exist in multiple digital formats, each serving a distinct purpose for knowledge dissemination and research.

- **Books** – Digitized textual content from manuscripts, published books, or scanned copies, available for reading, searching, and referencing.  
- **PDFs** – Portable Document Format files containing structured text, images, and embedded metadata, used for academic research, documentation, and historical records.  
- **Images** – Scanned pages, infographics, handwritten manuscripts, or visual representations of textual content stored in formats such as **JPEG, PNG, and TIFF**.  
- **Text** – Plain or structured digital text extracted from books, manuscripts, or transcriptions, available for full-text search and linguistic analysis.  
- **Audio** – Spoken-word recordings, including **recitations, narrations, podcasts, and lectures**, stored in formats such as **MP3, WAV, and AAC**.  
- **Videos** – Multimedia content combining **visual and audio**, including educational lectures, interviews, and historical documentaries, stored in formats such as **MP4, AVI, and WEBM**.  

Each format is indexed and processed for searchability, classification, and multi-language accessibility within Zawjen.net.

### **Dataset Type**
Categories of datasets covering domains like **Religion, Politics, Medicine, Law, Sociology, Technology, Education, Economics, History, Ethics, Spirituality**, and more.

### **Dataset Filters**  
Dataset filters in **Zawjen.net** allow users to refine searches and locate specific content efficiently. Filters apply across **Books, PDFs, Images, Text, Audio, and Videos**, ensuring precise results based on various criteria.  

These dataset filters enable efficient **search, retrieval, and research** across **Zawjen.net**, ensuring users can find relevant and credible information effortlessly.

### **Search & Filter System**
A mechanism that allows users to find specific words or topics within selected datasets based on **language, topic, era, historical event, person, or source.**

## **Filters**
### **Dataset Language**
Dataset can be in one or more languages. 

### **Dataset Translated Language**
Dataset can be translated from its original language into one or more languages. 

### **Dataset Type**
Categories of datasets covering domains like **Religion, Politics, Medicine, Law, Sociology, Technology, Education, Economics, History, Ethics, Spirituality**, and more.

#### **Content Type**  
- **Books** – Filter by book title, author, publisher, or publication year.  
- **PDFs** – Filter by document title, size, language, or page count.  
- **Images** – Filter by resolution, format (JPEG, PNG, TIFF), or source.  
- **Text** – Filter by keyword, sentence structure, or language.  
- **Audio** – Filter by speaker, duration, topic, or language.  
- **Videos** – Filter by title, speaker, length, or language.  

#### **Language**  
- Supports **1000+ languages**, allowing users to select datasets in their preferred language.  
- Enables **multilingual filtering**, showing results in multiple languages simultaneously.  

#### **Topic & Category**  
- Categorized into **Religion, Politics, Medicine, Law, Sociology, Technology, Education, Economics, History, Ethics, Spirituality,** and more.  
- Users can refine searches based on the **domain of knowledge**.  

#### **Historical Context**  
- Filters based on **Era (Ancient, Medieval, Modern)**.  
- Filters by **Historical Events**, linking datasets to specific occurrences.  
- Filters by **Person**, showing content related to historical figures or scholars.  
- Filters by **Location**, retrieving datasets relevant to specific geographical regions.  

#### **Trustworthiness**  
- **Green** – Verified as **Truth**.  
- **Yellow** – **Doubtful** or requires **further validation**.  
- **Red** – Identified as **False** or **Fabricated**.  

#### **Source**  
- Allows users to search based on **authentic references**.  
- Users can filter by **author, researcher, scholar, or organization** responsible for the dataset.  

#### **File Properties**  
- **Date Added** – Search for the most **recently uploaded** datasets.  
- **File Size** – Filter datasets by **small, medium, or large file sizes**.  
- **Format** – Choose from text-based, image-based, or multimedia datasets.  

### **Search Type**
1. **Exact Match** – "Search for the exact word or phrase"  
2. **Contains** – "Search for results that contain these words anywhere"  
3. **Starts With** – "Search for words that start with this phrase"  
4. **Ends With** – "Search for words that end with this phrase"  
5. **Fuzzy Match** – "Search for similar words or misspellings"  
6. **Wildcard Search** – "Use * or ? to replace letters (e.g., ‘te*t’ finds ‘test’ and ‘text’)"  
7. **Boolean Search** – "Use AND, OR, NOT (e.g., ‘Hadith AND Arabic’)"  
8. **Proximity Search** – "Find words near each other (e.g., ‘Hadith NEAR Arabic’)"  
9. **Phrase Search** – "Search for an exact phrase using quotes (e.g., ‘golden words’)"  
10. **Synonym Search** – "Find results with synonyms of the searched word"  
11. **Case-Sensitive Search** – "Match results exactly as typed, including uppercase/lowercase"  
12. **Language-Based Search** – "Filter results by language (Arabic, Urdu, English, etc.)"  
13. **Date-Based Search** – "Filter results by publication or historical date"  
14. **Topic-Based Search** – "Search within specific topics or categories"  
15. **Author Search** – "Find content written by a specific author"  
16. **Book-Based Search** – "Limit results to a specific book or collection"  
17. **Advanced Search** – "Combine multiple filters for refined results"  

### **Content Classification**
Datasets and research outputs are marked based on trustworthiness:
- **Green**: Verified as Truth
- **Yellow**: Doubtful or requires further validation
- **Red**: Identified as False or Fabricated

### **Language**
Referring to spoken languages. There are approximately **7,168** spoken languages in the world today. However, about **40%** of these languages are endangered, with fewer than 1,000 speakers each. The most widely spoken languages include English, Mandarin Chinese, Hindi, Spanish, French, and Arabic. 

## **User Roles & Permissions**

### **General Users**
- Can **search** and **filter** datasets.
- Can **select** their mother tongue from **1000+ languages**.
- Can **read, listen, or watch** dataset content.
- Can **request** content verification.

### **Super User**
- Has **full control** over the entire system.
- Can **manage user roles** and assign permissions.
- Can **approve or reject datasets** before activation.

### **Admins**
- Can **upload new datasets** and manage existing ones.
- Can **activate or deactivate datasets**, making them available or hidden on the main site.

### **Editors**
- Can **edit dataset metadata** (title, description, tags, classification).
- Can **correct and refine dataset content**.

### **Proofreaders**
- Can **review and correct datasets** for errors, accuracy, and classification.

### **Analytics Users**
- Can **generate insights and reports** based on dataset usage, trends, and engagement.
- Can **identify high-demand datasets** for prioritization.

## **Functional Modules**

### **Dataset Management System**
- Allows **upload, edit, classify, and activate/deactivate datasets**.
- Ensures datasets are **accessible to the right audience** based on admin settings.

### **Search Engine**
- Enables users to **search for specific words** within datasets.
- Provides **filters based on language, dataset type, and historical significance**.

### **Language Management**
- Supports **1000+ languages**.
- Allows users to **select their preferred language** for content viewing.
- Provides **automatic translation** where applicable.

### **Classification & Verification**
- Uses **proofreaders and AI-assisted verification** to classify content.
- Ensures content aligns with **Green (Truth), Yellow (Doubtful), or Red (Falsehood)** classifications.

### **AI-Powered Truth Verification (Righteous AI – 1.0)**
- A system designed to ensure the **elimination of deception**.
- Provides **evidence-backed knowledge** for users.
- Helps classify datasets based on **ethical and factual correctness**.

## **Vision Alignment**

### **Knowledge & Truth**
- Providing **authentic and verified knowledge** to users worldwide.
- Helping people **distinguish between Truth, Lies, and Doubtful information**.

### **Global Accessibility**
- Ensuring that users from **all linguistic and cultural backgrounds** can access the platform.
- Promoting **multilingual engagement** through translations and localized datasets.

### **Ethical AI & Technology**
- Using **AI-powered analytics and verification** to ensure dataset integrity.
- Supporting **evidence-based research and content classification**.


