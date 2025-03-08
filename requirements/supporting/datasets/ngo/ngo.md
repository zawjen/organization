# Requirement Document for Data Collection & Structuring of NGO Data in Karachi

## **1. Project Overview**
The objective of this project is to collect, structure, and maintain a dataset of NGOs operating in Karachi, Pakistan. The dataset will follow a standardized JSON schema to ensure consistency, comprehensiveness, and usability for analytical and application purposes. The focus will be on NGOs involved in **social welfare, education, health, food, environment, legal aid, disaster relief, and human rights**.

## **2. Data Collection Scope**
The data scientist will gather and structure NGO data based on the following key aspects:
- **Legal Information** (Registration number, legal status, founding year)
- **Operational Details** (Mission, services, beneficiaries, funding sources)
- **Impact Metrics** (People helped, projects completed, emergency response capabilities)
- **Governance** (Founders, executive directors, board members)
- **Partnerships** (Collaborations with government, private sector, UN agencies)
- **Contact & Digital Presence** (Address, phone, website, social media, mobile apps)
- **Volunteer & Donation Information** (Opportunities, methods, corporate sponsorships)

## **3. Data Sources**
The data will be collected from the following sources:
1. **Official NGO Websites** – Registration details, mission, and services.
2. **Government Databases** – NGO regulatory bodies in Pakistan (SECP, EAD, PCP, etc.).
3. **Charity Directories & Aggregators** – Pakistan Centre for Philanthropy, Idealist, etc.
4. **Social Media Pages** – Facebook, Twitter, LinkedIn for contact & engagement data.
5. **News & Reports** – Past achievements, impact assessment reports.
6. **Field Surveys & Interviews** – Direct communication with NGO representatives.

## **4. Data Collection & Processing Steps**
1. **Data Identification & Extraction**  
   - Identify relevant NGOs operating in Karachi.
   - Extract key data fields based on schema.
2. **Data Cleaning & Validation**  
   - Verify accuracy (cross-check multiple sources).
   - Standardize formats (remove duplicates, fix missing values).
3. **Data Structuring & Formatting**  
   - Convert extracted data into JSON format following the defined schema.
   - Categorize NGOs based on their primary areas of work.
4. **Data Storage & Accessibility**  
   - Store dataset in a structured database (SQL/NoSQL as required).
   - Provide API access for application integration.

## **5. JSON Schema for NGO Data**
The collected data should follow the structure outlined below:
```json
{
  "ngo": {
    "name": "",
    "registration_number": "",
    "legal_status": "Nonprofit | Charity | Trust | Foundation",
    "year_founded": "",
    "countries_operating_in": ["Pakistan"],
    "languages_supported": ["Urdu", "English"],
    "type": "social_welfare | education | health | food | environment | legal_aid | disaster_relief | human_rights",
    "mission_statement": "",
    "description": "",
    "services": [
      {
        "name": "",
        "description": "",
        "target_beneficiaries": "",
        "location": "Karachi",
        "online_availability": true
      }
    ],
    "beneficiaries": {
      "target_audience": "",
      "annual_reach": "",
      "eligibility_criteria": "",
      "special_needs_support": true
    },
    "funding": {
      "sources": [
        "donations", "grants", "government_funding", "corporate_sponsorships"
      ],
      "annual_budget": "",
      "financial_transparency": {
        "reports_available": true,
        "audit_reports_url": ""
      }
    },
    "impact": {
      "key_achievements": [
        { "year": "", "description": "" }
      ],
      "metrics": {
        "people_helped": "",
        "projects_completed": "",
        "awards_received": []
      }
    },
    "governance": {
      "board_members": [
        { "name": "", "role": "", "background": "" }
      ],
      "founder": "",
      "executive_director": ""
    },
    "partners_and_collaborations": [
      {
        "name": "",
        "type": "government | corporate | other_ngo | UN Agency",
        "description": ""
      }
    ],
    "contact_information": {
      "address": "",
      "phone": "",
      "email": "",
      "website": "",
      "social_media": {
        "facebook": "",
        "twitter": "",
        "linkedin": "",
        "instagram": ""
      },
      "hotline": {
        "number": "",
        "available_hours": ""
      }
    },
    "volunteer_and_donation": {
      "volunteer_opportunities": "",
      "donation_methods": [
        {
          "method": "bank_transfer | online_payment | cash | crypto",
          "details": ""
        }
      ],
      "corporate_social_responsibility_partnerships": true
    },
    "technology_and_digital_services": {
      "e-learning_platforms": true,
      "telemedicine": true,
      "mobile_apps": [],
      "AI-driven_support": true
    }
  }
}
```

## **6. Deliverables**
The data scientist is expected to deliver:
1. **A structured dataset in JSON format** – Containing at least **200 NGOs** from Karachi.
2. **A detailed report** – Explaining data sources, collection methods, and quality checks.
3. **A dashboard (optional)** – For visualizing NGO data analytics.
4. **API or database integration** – For storing and querying NGO information.

## **7. Timeline & Milestones**
- **Week 1-2**: Research & data collection.
- **Week 3**: Data cleaning, validation, and structuring.
- **Week 4**: Final dataset, report submission, and review.

## **8. Success Metrics**
- **Coverage**: At least **200 verified NGOs** from Karachi.
- **Accuracy**: 90%+ data accuracy after verification.
- **Completeness**: At least **80% fields** populated in each NGO record.
- **Usability**: Structured JSON format for easy API integration.

## **9. Notes & Considerations**
- Ensure compliance with **Pakistan’s NGO registration regulations**.
- Verify NGOs for **active operations** (not defunct or fraudulent organizations).
- Use **publicly available data** and avoid collecting sensitive personal information.
