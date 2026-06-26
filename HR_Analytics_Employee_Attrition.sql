-- Query 1: Find Total Number of Employees in the Organization

SELECT COUNT(*) AS Total_Employees
FROM `wa_fn-usec_-hr-employee-attrition`;

-- Query 2: Find Total Number of Employees Who Left the Company

SELECT COUNT(*) AS Attrition_Count
FROM `wa_fn-usec_-hr-employee-attrition`
WHERE Attrition = 'Yes';

-- Query 3: Calculate Overall Employee Attrition Rate Percentage

SELECT
ROUND(
(COUNT(CASE WHEN Attrition='Yes' THEN 1 END) * 100.0)
/ COUNT(*), 2
) AS Attrition_Rate
FROM `wa_fn-usec_-hr-employee-attrition`;

-- Query 4: Count Number of Employees in Each Department

SELECT
Department,
COUNT(*) AS Employee_Count
FROM `wa_fn-usec_-hr-employee-attrition`
GROUP BY Department
ORDER BY Employee_Count DESC;

-- Query 5: Analyze Attrition Count by Department

SELECT
Department,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM `wa_fn-usec_-hr-employee-attrition`
GROUP BY Department
ORDER BY Attrition_Count DESC;

-- Query 6: Count Employees by Gender

SELECT
Gender,
COUNT(*) AS Employee_Count
FROM `wa_fn-usec_-hr-employee-attrition`
GROUP BY Gender;

-- Query 7: Analyze Attrition Based on Gender

SELECT
Gender,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM `wa_fn-usec_-hr-employee-attrition`
GROUP BY Gender;

-- Query 8: Calculate Average Monthly Income by Department

SELECT
Department,
ROUND(AVG(MonthlyIncome),2) AS Average_Income
FROM `wa_fn-usec_-hr-employee-attrition`
GROUP BY Department
ORDER BY Average_Income DESC;

-- Query 9: Identify Job Roles with Highest Attrition

SELECT
JobRole,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM `wa_fn-usec_-hr-employee-attrition`
GROUP BY JobRole
ORDER BY Attrition_Count DESC;

-- Query 10: Display Top 10 Highest Paid Employees

SELECT
EmployeeNumber,
JobRole,
MonthlyIncome
FROM `wa_fn-usec_-hr-employee-attrition`
ORDER BY MonthlyIncome DESC
LIMIT 10;

-- Query 11: Count Employees Working Overtime

SELECT
OverTime,
COUNT(*) AS Employee_Count
FROM `wa_fn-usec_-hr-employee-attrition`
GROUP BY OverTime;

-- Query 12: Analyze Relationship Between Overtime and Attrition

SELECT
OverTime,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM `wa_fn-usec_-hr-employee-attrition`
GROUP BY OverTime;

-- Query 13: Calculate Average Years Employees Stay in the Company

SELECT
ROUND(AVG(YearsAtCompany),2) AS Avg_Years_At_Company
FROM `wa_fn-usec_-hr-employee-attrition`;

-- Query 14: Create a Summary View for Department-wise Employee Analysis

CREATE VIEW employee_summary_view AS
SELECT Department,
COUNT(*) AS Total_Employees
FROM `wa_fn-usec_-hr-employee-attrition` 
GROUP BY Department;

-- Query 15: Display Data from HR Summary View

SELECT * FROM `wa_fn-usec_-hr-employee-attrition`;

-- Query 16: Find Employees Earning Above Average Salary Using Subquery

SELECT
EmployeeNumber,
JobRole,
MonthlyIncome
FROM `wa_fn-usec_-hr-employee-attrition`
WHERE MonthlyIncome >
(
SELECT AVG(MonthlyIncome)
FROM `wa_fn-usec_-hr-employee-attrition`
);

-- Query 17: Create Index on Department Column for Query Optimization

CREATE INDEX idx_department
ON `wa_fn-usec_-hr-employee-attrition`(Department(50));

-- Query 18: Advanced HR Analysis - Department-wise Employee Count,
-- Average Salary and Attrition Analysis

SELECT
Department,
COUNT(*) AS Total_Employees,
ROUND(AVG(MonthlyIncome),2) AS Avg_Salary,
SUM(CASE WHEN Attrition='Yes' THEN 1 ELSE 0 END) AS Attrition_Count
FROM `wa_fn-usec_-hr-employee-attrition`
GROUP BY Department
ORDER BY Attrition_Count DESC;
