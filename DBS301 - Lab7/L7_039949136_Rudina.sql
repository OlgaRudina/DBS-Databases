-- ***********************
-- Name: Olga Rudina
-- ID: 039949136
-- Date: 12-Nov-2018
-- Purpose: Lab 7 DBS301
-- ***********************

-- 1.	The HR department needs a list of Department IDs for departments that do not conbtain the job ID of ST_CLERK> 
-- Use a set operator to create this report.

SELECT DEPARTMENT_ID
FROM DEPARTMENTS
MINUS
SELECT DEPARTMENT_ID
FROM EMPLOYEES
WHERE JOB_ID = 'ST_CLERK';

-- 2.	Same department requests a list of countries that have no departments located in them. 
-- Display country ID and the country name. Use SET operators.

SELECT COUNTRY_ID, COUNTRY_NAME
FROM COUNTRIES
MINUS SELECT COUNTRY_ID, COUNTRY_NAME
FROM COUNTRIES
JOIN LOCATIONS USING(COUNTRY_ID)
JOIN DEPARTMENTS USING (LOCATION_ID);


-- 3.	The Vice President needs very quickly a list of departments 10, 50, 20 in that order. 
-- job and department ID are to be displayed.

SELECT DISTINCT JOB_ID, DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 10
UNION ALL
SELECT DISTINCT JOB_ID,DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 50
UNION ALL
SELECT DISTINCT JOB_ID,DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = 20;

-- 4.	Create a statement that lists the employeeIDs and JobIDs of those employees who currently have a job title that is the
-- same as their job title when they were initially hired by the company 
-- (that is, they changed jobs but have now gone back to doing their original job).

SELECT EMPLOYEE_ID, JOB_ID
FROM EMPLOYEES
INTERSECT
SELECT EMPLOYEE_ID, JOB_ID
FROM JOB_HISTORY;


-- 5.	The HR department needs a SINGLE report with the following specifications:
--a.	Last name and department ID of all employees regardless of whether they belong to a department or not.
--b.	Department ID and department name of all departments regardless of whether they have employees in them or not.

SELECT LAST_NAME, DEPARTMENT_ID, to_char(null)
FROM EMPLOYEES
UNION
SELECT to_char(null), DEPARTMENT_ID, DEPARTMENT_NAME
FROM DEPARTMENTS;
