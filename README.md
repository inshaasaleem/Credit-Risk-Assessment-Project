Credit Risk Assessment Project

A full end-to-end credit risk analytics pipeline — from raw loan data to a scoring model, portfolio risk metrics, stress testing, and an interactive Power BI dashboard.

🎯 Project Overview

Loan defaults are one of the costliest risks a financial institution faces. This project builds a complete risk assessment pipeline to identify risky borrowers before loan approval — using SQL for data storage and querying, Python for cleaning and modeling, and Power BI for an interactive executive dashboard.

🗂️ Dataset

Source: Kaggle — Credit Risk Dataset Size: 32,581 raw records → 32,407 after cleaning


🛠️ Tools & Stack

PostgreSQL — database design, storage, EDA queries, and views

Python (Pandas + NumPy) — data cleaning, feature engineering, credit scoring model, portfolio risk & stress testing

Power BI — interactive dashboard with KPI cards, charts, and slicers (DAX measures)

🔍 Methodology

1. Data Cleaning — handled missing values, removed duplicates, filtered impossible values

2. Feature Engineering — income_group (Low/Medium/High), debt_to_income_ratio, age_group

3. SQL Analysis — loaded clean data into PostgreSQL, built views (high_risk_customers, default_rate_by_group), ran  EDA queries

4. Credit Scoring Model — built a 0–100 point scorecard from loan grade, income, DTI, employment stability, mapping to Low/Medium/High risk categories

5. Loan Approval Engine — business rules translating risk category into Approve / Review / Reject decisions

6. Portfolio Risk & Stress Testing — calculated Expected under Normal, Mild Recession (-15% income), and Severe Recession (-30% income) scenarios
  
7. Power BI Dashboard — KPI cards, breakdowns by loan purpose/grade/income group, and interactive slicers


📈 Key Findings

1. Overall default rate: 21.87%

2. Loan grade is the strongest predictor of default — default rate rises almost monotonically from Grade A (~5-8%) to Grade G (60-70%+)

3. Debt-to-income ratio and income group are also major drivers — borrowers in the "Low" income group default at roughly 4x the rate of the "High" income group

4. Scoring model validates well: Low Risk category → 4.5% actual default rate; Medium Risk → 22%; High Risk → 67% — a strong, monotonic separation

5. Stress testing shows escalating portfolio risk: Expected Loss as % of exposure rises from ~15.7% (normal economy) to ~21.9% (severe recession, -30% income shock)

