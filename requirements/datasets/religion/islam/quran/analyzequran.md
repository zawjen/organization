# analyzequran

- Type: scrapped
- Url: [https://web.analyzequran.com](https://web.analyzequran.com)

## Other

Below are two sample JSON schema examples—one set for the **Quran Dictionary** section and one set for the **Chapters** section. These examples illustrate both a “main” page (listing entries/chapters) and a “detail” sub‐page for an individual entry or chapter.

---

## 1. Quran Dictionary

### **Main Page JSON**

This JSON dataset represents an overview of the Quran Dictionary with a list of entries. Each entry includes the word, its root, a short definition, number of occurrences in the Quran, and a link to a detailed page.

```json
{
  "page_url": "https://web.analyzequran.com/qurandictionary",
  "title": "Quran Dictionary",
  "description": "A comprehensive dictionary of Quranic terms including meanings, roots, and linguistic analysis.",
  "total_entries": 2000,
  "entries": [
    {
      "word": "كتاب",
      "root": "كتب",
      "definition": "Book, scripture",
      "occurrences": 150,
      "detail_link": "https://web.analyzequran.com/qurandictionary/كتاب"
    },
    {
      "word": "نور",
      "root": "ن و ر",
      "definition": "Light",
      "occurrences": 100,
      "detail_link": "https://web.analyzequran.com/qurandictionary/نور"
    }
    // ... additional entries
  ]
}
```

### **Sub-Page (Detail) JSON**

This JSON dataset represents the detail page for a single dictionary entry. It expands on the word’s definitions, derived forms, and etymology.

```json
{
  "page_url": "https://web.analyzequran.com/qurandictionary/كتاب",
  "word": "كتاب",
  "root": "كتب",
  "definitions": [
    {
      "language": "ar",
      "definition": "كتاب/مصحف أو نص مقدس"
    },
    {
      "language": "en",
      "definition": "Book or document, often referring to the Quran or other holy scriptures."
    }
  ],
  "derived_terms": [
    {
      "term": "كاتب",
      "part_of_speech": "noun",
      "definition": "Writer"
    },
    {
      "term": "مكتوب",
      "part_of_speech": "adjective",
      "definition": "Written"
    }
  ],
  "occurrences": 150,
  "etymology": "Derived from the triliteral root K-T-B meaning 'to write'."
}
```

---

## 2. Chapters

### **Main Page JSON**

This JSON dataset represents the main chapters overview page. It lists all the Quran chapters (Surahs) with basic metadata such as chapter number, Arabic and English names, revelation place, verse count, and a link to a chapter detail page.

```json
{
  "page_url": "https://web.analyzequran.com/chapters",
  "title": "Quran Chapters",
  "description": "A complete listing of Quran chapters with details like chapter number, names, revelation place, and verse count.",
  "total_chapters": 114,
  "chapters": [
    {
      "chapter_number": 1,
      "name_ar": "الفاتحة",
      "name_en": "The Opening",
      "revelation_place": "Mecca",
      "verses_count": 7,
      "detail_link": "https://web.analyzequran.com/chapters/1"
    },
    {
      "chapter_number": 2,
      "name_ar": "البقرة",
      "name_en": "The Cow",
      "revelation_place": "Medina",
      "verses_count": 286,
      "detail_link": "https://web.analyzequran.com/chapters/2"
    }
    // ... additional chapters
  ]
}
```

### **Sub-Page (Detail) JSON**

This JSON dataset represents a detailed page for a specific chapter. It includes a summary, chapter metadata, and an array of verses with their Arabic text and an English translation.

```json
{
  "page_url": "https://web.analyzequran.com/chapters/1",
  "chapter_number": 1,
  "name_ar": "الفاتحة",
  "name_en": "The Opening",
  "revelation_place": "Mecca",
  "verses_count": 7,
  "summary": "The opening chapter of the Quran, recited in every unit of the prayer, emphasizing praise and guidance.",
  "verses": [
    {
      "verse_number": 1,
      "text_ar": "بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ",
      "translation_en": "In the name of Allah, the Most Gracious, the Most Merciful"
    },
    {
      "verse_number": 2,
      "text_ar": "الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ",
      "translation_en": "All praise is due to Allah, the Lord of all the worlds"
    },
    {
      "verse_number": 3,
      "text_ar": "الرَّحْمَٰنِ الرَّحِيمِ",
      "translation_en": "The Most Gracious, the Most Merciful"
    },
    {
      "verse_number": 4,
      "text_ar": "مَالِكِ يَوْمِ الدِّينِ",
      "translation_en": "Master of the Day of Judgment"
    },
    {
      "verse_number": 5,
      "text_ar": "إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ",
      "translation_en": "You alone we worship, and You alone we ask for help"
    },
    {
      "verse_number": 6,
      "text_ar": "اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ",
      "translation_en": "Guide us to the straight path"
    },
    {
      "verse_number": 7,
      "text_ar": "صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ",
      "translation_en": "The path of those upon whom You have bestowed favor"
    }
  ]
}
```

---

### Summary

- **For the Quran Dictionary:**
  - The **main page JSON** lists all dictionary entries with summary details.
  - The **detail page JSON** for an entry provides in-depth definitions, derived terms, occurrence data, and etymology.

- **For the Chapters:**
  - The **main page JSON** lists each chapter with key metadata.
  - The **detail page JSON** for a chapter includes a summary and a breakdown of verses with their texts and translations.

These sample datasets can serve as a blueprint for structuring the scraped data from [web.analyzequran.com](https://web.analyzequran.com).