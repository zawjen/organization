# quran

- Type: system
- Url: [None](#)

This document will list various Quran Json that we will serve.

- Quran consists of 114 `Surah` (or Book)
- Each Surah has multiple `Ayat` (or Verse)
- Each Ayah has multiple `Lufz` (or Word)

## Quran Json
For each Quran dataset, store following information:

```json
 {
    "source": "",
    "author": [""],
    "publisher": "",
    "datePublished": "",
    "location": "",
    "lang": "ar|ur|en"
}
```

See complete language codes at [lang codes](./lang.md)

### Surah Json
Each `Surah` will be stored as separate Json.

```json
 {
    "surah": 1,
    "name": ["Al-Fatiha"],
    "totalAyahs": 7,
    "ayahs": [
        {
            "no": 1,
            "text": "بِسْمِ اللّٰهِ الرَّحْمٰنِ الرَّحِیْمِ",
        }
    ]
}
```
Or `Urdu` version: 

```json
 {
    "surah": 1,
    "name": ["Al-Fatiha"],
    "totalAyahs": 7,
    "ayahs": [
        {
            "no": 1,
            "text": "اللہ کے نام سے جو بڑا مہربان نہایت رحم والا ہے",
        }
    ]
}
```

Or `English` version: 

```json
 {
    "surah": 1,
    "name": ["Al-Fatiha"],
    "totalAyahs": 7,
    "ayahs": [
        {
            "no": 1,
            "text": "In the name of Allah, the Most Gracious, the Most Merciful.",
        }
    ]
}
```

### Generic Quran Json
This Json will be stored once containing **common information** in all Quran or its translations ever published.

```json
 {
    "surah": 1,
    "name": ["Al-Fatiha"],
    "totalAyahs": [7],
    "para": 1,
    "ruku": 1,
    "location": ["Makkah"],
    "year": [801]
}
```


### Breakdown of Key Attributes:

1. **surah**: The  of the Surah (e.g., 1 for Al-Fatiha, 2 for Al-Baqarah).
2. **surahName**: The name of the Surah (e.g., Al-Fatiha, Al-Baqarah).
3. **totalAyahs**: The total  of Ayahs (verses) in the Surah.
4. **para**: The  of the Para (division of the Quran, typically the Quran is divided into 30 sections called "Paras").
5. **ruku**: The  of the Ruku (a division within a Surah that breaks the verses into smaller sections).
6. **location**: Whether the Surah is Makki (revealed in Makkah) or Madani (revealed in Madina).
7. **exactLocation**: Provides a more specific location, e.g., "Makkah" or "Madina."
8. **ayat**: The specific  of the Ayah (verse) within the Surah.
9. **ayatText**: The actual text of the Ayah in Arabic.
10. **translation**: Translations of the Ayah in various languages (e.g., English, Urdu).
11. **location (within Ayah)**: The location of the specific Ayah within the overall Surah, indicating whether it is from a Makki or Madani verse.

This structure provides a detailed and comprehensive dataset for the entire Quran, enabling effective indexing and retrieval of Quranic content by Surah, Ayah, and additional metadata such as location and translation. The data can be easily used to create searchable and filterable interfaces.

A Json representing complete quran including ayat , ayat text, Surah , surah name, para , Ruku , location [makki, madani, both], exact location

Links to Quranic text or segmented readings.
3. Translation Resources Page (/translation)
Various translations of the Quran into different languages (e.g., Urdu, English).
Links to specific translated texts of the Quran.
4. Tafseer Resources Page (/tafseer)
Detailed commentaries (Tafseers) of the Quran, including famous Tafseers like Ibn-e-Kaseer, Tafheem-ul-Quran, etc.
Links to Tafseers for each Surah or Ayah.
5. Word by Word Resources Page (/wordbyword)
Tools or resources to see the Quranic words with corresponding translations in different languages, broken down word-by-word.
6. Hadith Resources Page (/hadithchapters)
Hadith collections like Sahih Bukhari, Sahih Muslim, etc.
Links to Hadith chapters categorized by the book.