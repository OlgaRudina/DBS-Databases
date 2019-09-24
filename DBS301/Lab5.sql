-- ***********************
-- Name: Olga Rudina
-- ID: 039949136
-- Date: 08-Oct-2018
-- Purpose: Lab 5 DBS301
-- ***********************

-- Part-A – Simple Joins
--(FROM <table1, table2>)


-- 1. Display the department name, city, street address and postal code for departments sorted by city and department name.

SELECT d.DEPARTMENT_NAME, l.CITY, l.STREET_ADDRESS, l.POSTAL_CODE
FROM DEPARTMENTS d, LOCATIONS l
WHERE l.LOCATION_ID = d.LOCATION_ID
ORDER BY CITY, DEPARTMENT_NAME;

-- 2. Display full name of employees as a single field using format of Last, First, their hire date, salary,
-- department name and city, but only for departments with names starting with an A or S 
-- sorted by department name and employee name. 

SELECT e.LAST_NAME||' '||e.FIRST_NAME  AS "Full Name",
e.HIRE_DATE,
e.SALARY,
d.DEPARTMENT_NAME,
l.CITY
FROM EMPLOYEES e, DEPARTMENTS d, LOCATIONS l
WHERE (UPPER(d.DEPARTMENT_NAME) LIKE 'A%'
OR UPPER(d.DEPARTMENT_NAME) LIKE 'S%')
AND e.DEPARTMENT_ID = d.DEPARTMENT_ID 
AND l.LOCATION_ID = d.LOCATION_ID
ORDER BY DEPARTMENT_NAME, "Full Name";


-- 3. Display the full name of the manager of each department in states/provinces of Ontario, 
-- California and Washington along with the department name, city, postal code and province name.  
-- Sort the output by city and then by department name.

SELECT e.LAST_NAME||' '||e.FIRST_NAME AS "Full Name",
d.DEPARTMENT_NAME,
l.CITY,
l.POSTAL_CODE,
l.STATE_PROVINCE
FROM EMPLOYEES e, DEPARTMENTS d, LOCATIONS l
WHERE (l.STATE_PROVINCE IN('Ontario', 'California','Washington'))
AND (UPPER(e.JOB_ID) LIKE '%MAN' OR UPPER(e.JOB_ID) LIKE '%MGR') 
AND e.DEPARTMENT_ID = d.DEPARTMENT_ID 
AND l.LOCATION_ID = d.LOCATION_ID
ORDER BY CITY, DEPARTMENT_NAME;



-- 4. Display employee’s last name and employee number along with their manager’s last name and manager number. 
-- Label the columns Employee, Emp#, Manager, and Mgr# respectively.

SELECT e.LAST_NAME AS "EMPLOYEE", e.EMPLOYEE_ID AS "EMP#",
m.LAST_NAME AS "MANAGER", m.EMPLOYEE_ID AS "MGR#"
FROM EMPLOYEES e, EMPLOYEES m
WHERE e.MANAGER_ID = m.EMPLOYEE_ID;

--***************************************************************************************************************************

-- Part-B – Non-Simple Joins
-- Using the JOIN statement

-- 5. Display the department name, city, street address, postal code and country name for all Departments. 
-- Use the JOIN and USING form of syntax.  
-- Sort the output by department name descending.

SELECT DEPARTMENT_NAME, CITY, STREET_ADDRESS, POSTAL_CODE, COUNTRY_ID
FROM DEPARTMENTS JOIN LOCATIONS
USING (LOCATION_ID)
ORDER BY DEPARTMENT_NAME DESC;


-- 6. Display full name of the employees, their hire date and salary together with their department name, 
-- but only for departments which names start with A or S.
-- a. Full name should be formatted:  First / Last. 
-- b. Use the JOIN and ON form of syntax.
-- c. Sort the output by department name and then by last name.

SELECT e.FIRST_NAME||' '|| e.LAST_NAME  AS "Full Name", e.HIRE_DATE, e.SALARY, d.DEPARTMENT_NAME
FROM EMPLOYEES e JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID=d.DEPARTMENT_ID
WHERE (UPPER(d.DEPARTMENT_NAME) LIKE 'A%'
OR UPPER(d.DEPARTMENT_NAME) LIKE 'S%')
ORDER BY DEPARTMENT_NAME, LAST_NAME;

-- 7. Display full name of the manager of each department in provinces Ontario, California and 
-- Washington plus department name, city, postal code and province name. 
-- a. Full name should be formatted: Last, First.  
-- b. Use the JOIN and ON form of syntax.
-- c. Sort the output by city and then by department name. 

SELECT e.LAST_NAME||' '||e.FIRST_NAME AS "Full Name",
d.DEPARTMENT_NAME,
l.CITY,
l.POSTAL_CODE,
l.STATE_PROVINCE
FROM EMPLOYEES e 
JOIN DEPARTMENTS d
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID 
JOIN LOCATIONS l
ON  l.LOCATION_ID = d.LOCATION_ID
WHERE (l.STATE_PROVINCE IN('Ontario', 'California','Washington'))
ORDER BY CITY, DEPARTMENT_NAME;


-- 8. Display the department name and Highest, Lowest and Average pay per each department. 
-- Name these results High, Low and Avg.
-- a. Use JOIN and ON form of the syntax.
-- b. Sort the output so that department with highest average salary are shown first.

SELECT d.DEPARTMENT_NAME,
NVL(to_char(MAX(e.SALARY), '$999,999.99'), '-') AS "High",
NVL(to_char(MIN(e.SALARY), '$999,999.99'), '-') AS "Low",
NVL(to_char(AVG(e.SALARY), '$999,999.99'), '-') AS "Avg"
FROM DEPARTMENTS d
LEFT OUTER JOIN EMPLOYEES e
ON d.DEPARTMENT_ID = e.DEPARTMENT_ID
GROUP BY DEPARTMENT_NAME
ORDER BY NVL(AVG(SALARY),0) DESC;

-- 9. Display the employee last name and employee number along with their manager’s last name and manager number. 
-- Label the columns Employee, 
-- a. Emp#, Manager, and Mgr#, respectively. 
-- b. Include also employees who do NOT have a manager and also employees who do NOT supervise anyone 
-- (or you could say managers without employees to supervise).

SELECT 
NVL(e.LAST_NAME, '-') AS "EMPLOYEE", 
NVL(TO_CHAR(e.EMPLOYEE_ID), '-') AS "EMP#",
NVL(m.LAST_NAME, '-') AS "MANAGER", 
NVL(TO_CHAR(m.EMPLOYEE_ID), '-') AS "MGR#"
FROM EMPLOYEES e LEFT OUTER JOIN EMPLOYEES m
ON e.MANAGER_ID = m.EMPLOYEE_ID;


