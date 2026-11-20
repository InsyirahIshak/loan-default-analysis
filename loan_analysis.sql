USE LoanDB;
SELECT COUNT(*) FROM loans;

SELECT COUNT(*) AS total_loans,
       SUM(loan_amnt) AS total_loan_amount,
       ROUND(AVG(int_rate), 2) AS avg_interest_rate,
       ROUND(100.0 * SUM([default]) / COUNT(*), 1) AS default_rate_pct
FROM loans;

ALTER TABLE loans ALTER COLUMN [default] INT;

--Overall numbers (your KPI cards)--

SELECT COUNT(*) AS total_loans,
       SUM(loan_amnt) AS total_loan_amount,
       ROUND(AVG(int_rate), 2) AS avg_interest_rate,
       ROUND(100.0 * SUM([default]) / COUNT(*), 1) AS default_rate_pct
FROM loans;

--Default rate by grade--
SELECT grade, COUNT(*) AS total_loans,
       ROUND(100.0 * SUM([default]) / COUNT(*), 1) AS default_rate_pct
FROM loans
GROUP BY grade
ORDER BY grade;

--Default rate by loan purpose--
SELECT purpose, COUNT(*) AS total_loans,
       ROUND(100.0 * SUM([default]) / COUNT(*), 1) AS default_rate_pct
FROM loans
GROUP BY purpose
ORDER BY default_rate_pct DESC;

--Default rate by income band--
SELECT income_band, COUNT(*) AS total_loans,
       ROUND(100.0 * SUM([default]) / COUNT(*), 1) AS default_rate_pct
FROM loans
GROUP BY income_band
ORDER BY MIN(annual_inc);

--Trend over time--
SELECT issue_year, COUNT(*) AS total_loans,
       ROUND(100.0 * SUM([default]) / COUNT(*), 1) AS default_rate_pct
FROM loans
GROUP BY issue_year
ORDER BY issue_year;

--36 vs 60 month loans--
SELECT term, COUNT(*) AS total_loans,
       ROUND(100.0 * SUM([default]) / COUNT(*), 1) AS default_rate_pct
FROM loans
GROUP BY term;

--Riskiest groups--
SELECT grade, purpose, COUNT(*) AS total_loans,
       ROUND(100.0 * SUM([default]) / COUNT(*), 1) AS default_rate_pct
FROM loans
GROUP BY grade, purpose
HAVING COUNT(*) >= 500
ORDER BY default_rate_pct DESC;

SELECT COUNT(*) AS total_loans,
       SUM(CAST([default] AS INT)) AS total_defaults,
       ROUND(100.0 * SUM(CAST([default] AS INT)) / COUNT(*), 1) AS default_rate_pct
FROM loans;

SELECT term, COUNT(*) AS total_loans,
       ROUND(100.0 * SUM(CAST([default] AS INT)) / COUNT(*), 1) AS default_rate_pct
FROM loans
WHERE grade IN ('E','F','G') AND purpose = 'Debt Consolidation'
AND issue_year BETWEEN 2008 AND 2016
GROUP BY term;

SELECT purpose, COUNT(*) AS total_loans
FROM loans
WHERE issue_year BETWEEN 2008 AND 2016
GROUP BY purpose
ORDER BY total_loans;