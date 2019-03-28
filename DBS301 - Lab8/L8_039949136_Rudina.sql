-- ***********************
-- Name: Olga Rudina
-- ID: 039949136
-- Date: 08-Nov-2018
-- Purpose: Lab 8 DBS301
-- ***********************


-- 1) Display the names of the employees whose salary is the same as the lowest salaried employee in any department.

SELECT LAST_NAME || ' ' || FIRST_NAME AS "Name",
to_char(SALARY, '$999,999') AS "Salary"
FROM EMPLOYEES
WHERE SALARY = ANY(SELECT MIN(SALARY)
                   FROM EMPLOYEES
                   GROUP BY DEPARTMENT_ID);

-- 2) Display the names of the employee(s) whose salary is the lowest in each department.

SELECT LAST_NAME || ' ' || FIRST_NAME AS "Name", 
to_char(SALARY, '$999,999') AS "Salary"
FROM EMPLOYEES
WHERE (DEPARTMENT_ID, SALARY) IN (SELECT DEPARTMENT_ID, MIN(SALARY)
                                  FROM EMPLOYEES
                                  GROUP BY DEPARTMENT_ID);

-- 3) Give each of the employees in question 2 a $100 bonus.

SELECT LAST_NAME || ' ' || FIRST_NAME AS "Name", 
to_char((SALARY+100), '$999,999') AS "Salary"
FROM EMPLOYEES
WHERE (DEPARTMENT_ID, SALARY) IN (SELECT DEPARTMENT_ID, MIN(SALARY)
                                  FROM EMPLOYEES
                                  GROUP BY DEPARTMENT_ID);

                                                                 
-- 4) Create a view named ALLEMPS that consists of all employees includes employee_id, last_name, salary, 
-- department_id, department_name, city and country (if applicable)


CREATE VIEW ALLEMPS AS
SELECT e.EMPLOYEE_ID, 
       e. LAST_NAME, 
       e.SALARY,
       e.DEPARTMENT_ID,
       d.DEPARTMENT_NAME,
       l.CITY,
       l.COUNTRY_ID
       FROM EMPLOYEES e
       JOIN DEPARTMENTS d ON (e.DEPARTMENT_ID = d.DEPARTMENT_ID)
       JOIN LOCATIONS l ON (d.LOCATION_ID = l.LOCATION_ID);


-- 5) Use the ALLEMPS view to:
-- a.	Display the employee_id, last_name, salary and city for all employees

SELECT EMPLOYEE_ID, LAST_NAME, SALARY, CITY
FROM ALLEMPS;

-- b.	Display the total salary of all employees by city

SELECT SUM(SALARY) AS "TOTAL"
FROM ALLEMPS
GROUP BY CITY;

-- c.	Increase the salary of the lowest paid employee(s) in each department by 100
UPDATE ALLEMPS
SET SALARY= (SALARY+100)
WHERE (DEPARTMENT_ID, SALARY) IN (SELECT DEPARTMENT_ID, MIN(SALARY)
                                  FROM ALLEMPS
                                  GROUP BY DEPARTMENT_ID);

-- d.	What happens if you try to insert an employee by providing values for all columns in this view?

INSERT INTO ALLEMPS
VALUES(222, 'Keehl', 10000, 90, 'IT_PROG', 'Moscow', NULL); 

--Error starting at line : 75 in command -
--INSERT INTO ALLEMPS
--VALUES(222, 'Keehl', 10000, 90, 'IT_PROG', 'Moscow', NULL)
--Error at Command Line : 75 Column : 1
--Error report -
--SQL Error: ORA-01776: cannot modify more than one base table through a join view
--01776. 00000 -  "cannot modify more than one base table through a join view"
--*Cause:    Columns belonging to more than one underlying table were either
--          inserted into or updated.
--*Action:   Phrase the statement as two or more separate statements.

-- e.	Delete the employee named Vargas. Did it work? Show proof.

DELETE FROM ALLEMPS
WHERE LAST_NAME = 'Vargas';

--1 row deleted.

-- 6)	Create a view named ALLDEPTS that consists of all departments and includes department_id, department_name, 
-- city and country (if applicable)

CREATE VIEW ALLDEPTS AS
SELECT 
d.DEPARTMENT_ID,
d.DEPARTMENT_NAME,
l.CITY,
l.COUNTRY_ID
FROM DEPARTMENTS d
JOIN LOCATIONS l ON (l.LOCATION_ID = d.LOCATION_ID);

-- 7)	Use the ALLDEPTS view to:

-- a.	For all departments display the department_id, name and city

SELECT DEPARTMENT_ID, DEPARTMENT_NAME, CITY
FROM ALLDEPTS;

-- b.	For each city that has departments located in it display the number of departments by city

SELECT CITY,
COUNT(DEPARTMENT_ID) 
FROM ALLDEPTS
GROUP BY CITY;

-- 8)	Create a view called ALLDEPTSUMM that consists of all departments and includes for each department: 
-- department_id, department_name, number of employees, number of salaried employees, total salary of all employees. 
-- Number of Salaried must be different from number of employees. The difference is some get commission.

CREATE VIEW ALLDEPTSSUMM AS
SELECT 
d.DEPARTMENT_ID,
d.DEPARTMENT_NAME,
COUNT(e.EMPLOYEE_ID) AS "NUMBER_OF_EMP",
COUNT(s.EMPLOYEE_ID) AS "SALARIED",
SUM(e.SALARY) AS "TOTAL"
FROM DEPARTMENTS d
JOIN EMPLOYEES e
ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
JOIN (DEPARTMENTS d JOIN EMPLOYEES s ON s.DEPARTMENT_ID = d.DEPARTMENT_ID)
ON e.EMPLOYEE_ID = s.EMPLOYEE_ID
WHERE s.EMPLOYEE_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE COMMISSION_PCT IS NULL)
GROUP BY d.DEPARTMENT_ID, d.DEPARTMENT_NAME;

-- 9)	Use the ALLDEPTSUMM view to display department name and number of employees for departments that 
-- have more than the average number of employees 

SELECT DEPARTMENT_NAME, NUMBER_OF_EMP
FROM ALLDEPTSSUMM
WHERE NUMBER_OF_EMP > (SELECT AVG(NUMBER_OF_EMP)
                       FROM ALLDEPTSSUMM);

-- 10)

-- A) Use the GRANT statement to allow another student (Neptune account) to retrieve data for your employees table and 
-- to allow them to retrieve, insert and update data in your departments table. Show proof

GRANT SELECT ON EMPLOYEES TO dbs301_183a56;
GRANT SELECT, INSERT, UPDATE ON DEPARTMENTS TO dbs301_183a56;

--Grant succeeded.

-- B) Use the REVOKE statement to remove permission for that student to insert and update data in your departments table

REVOKE INSERT, UPDATE ON DEPARTMENTS FROM dbs301_183a56;

--Revoke succeeded.

