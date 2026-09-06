DROP TABLE loan_application;

CREATE TABLE loan_applications (
    application_id          SERIAL PRIMARY KEY,
    person_age               INTEGER,
    person_income            NUMERIC(12,2),
    person_home_ownership    VARCHAR(20),
    person_emp_length        NUMERIC(5,2),
    loan_intent               VARCHAR(30),
    loan_grade                VARCHAR(5),
    loan_amnt                 NUMERIC(12,2),
    loan_int_rate              NUMERIC(6,3),
    loan_status                 SMALLINT,
    loan_percent_income        NUMERIC(6,4),
    cb_person_default_on_file  CHAR(1),
    cb_person_cred_hist_length INTEGER
);

SELECT COUNT(*) FROM loan_applications;
SELECT * FROM loan_applications LIMIT 5;

CREATE TABLE loan_applications_clean (
    person_age                 INTEGER,
    person_income              NUMERIC(12,2),
    person_home_ownership      VARCHAR(20),
    person_emp_length          NUMERIC(5,2),
    loan_intent                 VARCHAR(30),
    loan_grade                  VARCHAR(5),
    loan_amnt                   NUMERIC(12,2),
    loan_int_rate                NUMERIC(6,3),
    loan_status                   SMALLINT,
    loan_percent_income          NUMERIC(6,4),
    cb_person_default_on_file    CHAR(1),
    cb_person_cred_hist_length   INTEGER,
    income_group                  VARCHAR(10),
    debt_to_income_ratio          NUMERIC(10,6),
    age_group                      VARCHAR(10)
);

SELECT COUNT(*) FROM loan_applications_clean;

CREATE OR REPLACE VIEW high_risk_customers AS
SELECT * FROM loan_applications_clean
WHERE loan_status = 1 OR loan_grade IN ('E','F','G') OR loan_percent_income > 0.4;

CREATE OR REPLACE VIEW default_rate_by_group AS
SELECT income_group, COUNT(*) AS total, ROUND(AVG(loan_status)::numeric,4) AS default_rate
FROM loan_applications_clean
GROUP BY income_group;

-- Overall default rate
SELECT ROUND(AVG(loan_status)::numeric,4) AS default_rate FROM loan_applications_clean;

-- Default rate by loan purpose
SELECT loan_intent, COUNT(*) AS total, ROUND(AVG(loan_status)::numeric,4) AS default_rate
FROM loan_applications_clean GROUP BY loan_intent ORDER BY default_rate DESC;

-- Default rate by loan grade
SELECT loan_grade, COUNT(*) AS total, ROUND(AVG(loan_status)::numeric,4) AS default_rate
FROM loan_applications_clean GROUP BY loan_grade ORDER BY loan_grade;

-- DTI buckets
SELECT
  CASE WHEN loan_percent_income < 0.2 THEN '0-20%'
       WHEN loan_percent_income < 0.4 THEN '20-40%'
       WHEN loan_percent_income < 0.6 THEN '40-60%'
       ELSE '60%+' END AS dti_bucket,
  COUNT(*) AS total, ROUND(AVG(loan_status)::numeric,4) AS default_rate
FROM loan_applications_clean GROUP BY dti_bucket ORDER BY dti_bucket;

