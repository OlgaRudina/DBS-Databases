-- ***********************
-- Name: Olga Rudina
-- ID: 039949136
-- Date: 20-Sep-2018
-- Purpose: Lab 4 DBS301
-- ***********************


-- Display the difference between the Average pay and Lowest pay in the company.  
-- Name this result Real Amount. 
-- Format the output as currency with 2 decimal places.

SELECT to_char(AVG(SALARY) - MIN(SALARY), '$999,999.99') AS "Real Amount"
FROM EMPLOYEES;

--------------------------------------------------------------------------------------------------------------------------------

-- Display the department number and Highest, Lowest and Average pay per each department. 
-- Name these results High, Low and Avg.  
-- Sort the output so that the department with highest average salary is shown first.  
-- Format the output as currency where appropriate.

SELECT DEPARTMENT_ID,
to_char(MAX(SALARY), '$999,999.99') AS "High",
to_char(MIN(SALARY), '$999,999.99') AS "Low",
to_char(AVG(SALARY), '$999,999.99') AS "Avg"
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY MAX(SALARY) DESC;

--------------------------------------------------------------------------------------------------------------------------------

-- Display how many people work the same job in the same department. 
-- Name these results Dept#, Job and How Many. 
-- Include only jobs that involve more than one person.  
-- Sort the output so that jobs with the most people involved are shown first.

SELECT DEPARTMENT_ID AS "Dep#",
       JOB_ID AS "Job",
       COUNT(EMPLOYEE_ID) AS "How Many"
FROM EMPLOYEES
GROUP BY JOB_ID, DEPARTMENT_ID
HAVING COUNT(EMPLOYEE_ID) > 1
ORDER BY "How Many" DESC;

--------------------------------------------------------------------------------------------------------------------------------

-- For each job title display the job title 
-- and total amount paid each month for this type of the job. 
-- Exclude titles AD_PRES and AD_VP and also include only jobs 
-- that require more than $12,000.  
-- Sort the output so that top paid jobs are shown first.

SELECT JOB_ID AS "Job Title",
to_char(SUM(SALARY), '$999,999.99') AS "Total"
FROM EMPLOYEES
WHERE UPPER(JOB_ID) NOT IN('AD_PRES', 'AD_VP')
GROUP BY JOB_ID
HAVING SUM(SALARY) > 12000
ORDER BY SUM(SALARY) DESC;
--------------------------------------------------------------------------------------------------------------------------------

-- For each manager number display how many persons he / she supervises. 
-- Exclude managers with numbers 100, 101 and 102 and also include only
-- those managers that supervise more than 2 persons.  
-- Sort the output so that manager numbers with the most supervised persons are shown first.

SELECT MANAGER_ID, COUNT(EMPLOYEE_ID) 
FROM EMPLOYEES
WHERE MANAGER_ID NOT IN(100, 101, 102)
GROUP BY MANAGER_ID
HAVING COUNT(EMPLOYEE_ID) > 2
ORDER BY COUNT(EMPLOYEE_ID) DESC;

--------------------------------------------------------------------------------------------------------------------------------
    
-- For each department show the latest and earliest hire date, BUT
-- - exclude departments 10 and 20 
-- - exclude those departments where the last person was hired in this century. 
-- - Sort the output so that the most recent, meaning latest hire dates, are shown first.

SELECT DEPARTMENT_ID,
MAX(HIRE_DATE) AS "Latest",
MIN(HIRE_DATE) AS "Earliest"
FROM EMPLOYEES
WHERE DEPARTMENT_ID NOT IN(10,20)
GROUP BY DEPARTMENT_ID
HAVING MAX(HIRE_DATE) < '01-JAN-00'
ORDER BY MAX(HIRE_DATE) DESC;
--------------------------------------------------------------------------------------------------------------------------------