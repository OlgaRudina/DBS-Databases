-- ***********************
-- Name: Olga Rudina
-- ID: 039949136
-- Date: 08-Oct-2018
-- Purpose: Lab 6 DBS301
-- ***********************
-- 1.	SET AUTOCOMMIT ON (do this each time you log on) so any updates, 
-- deletes and inserts are automatically committed before you exit from Oracle.

-- 2.	Create an INSERT statement to do this.  Add yourself as an employee with a NULL salary,
-- 0.2 commission_pct, in department 90, and Manager 100.  You started TODAY.  

INSERT INTO EMPLOYEES
VALUES(111, 'Olga', 'Rudina', 'orudina@myseneca.ca', NULL, SYSDATE, 'IT_PROG', NULL, 0.2, 100, 90); 

-- 3.	Create an Update statement to: Change the salary of the employees with a last name of Matos and Whalen to be 2500.
-- You must use subqueries for these questions (must minimize the number of tables being used in the main query)

UPDATE EMPLOYEES 
SET SALARY = 2500
WHERE UPPER(LAST_NAME) = 'MATOS'
OR UPPER(LAST_NAME) = 'WHALEN';

-- 4.	Display the last names of all employees who are in the same department as the employee named Abel.

SELECT LAST_NAME FROM EMPLOYEES
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID 
                       FROM EMPLOYEES 
                       WHERE UPPER(LAST_NAME) = 'ABEL');


-- 5.	Display the last name of the lowest paid employee(s)

SELECT LAST_NAME FROM EMPLOYEES
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES);

-- 6.	Display the city that the lowest paid employee(s) are located in.

SELECT DISTINCT CITY 
FROM LOCATIONS l, DEPARTMENTS d, EMPLOYEES e
WHERE 
SALARY = (SELECT MIN(SALARY) FROM EMPLOYEES)
AND l.LOCATION_ID = d.LOCATION_ID
AND d.DEPARTMENT_ID = e.DEPARTMENT_ID;

-- 7.	Display the last name, department_id, and salary of the lowest paid employee(s) in each department.  
-- Sort by Department_ID. (HINT: careful with department 60)

SELECT LAST_NAME, DEPARTMENT_ID, to_char(SALARY, '$999,999.99') AS SALARY
FROM EMPLOYEES
WHERE (DEPARTMENT_ID, SALARY) IN (SELECT DEPARTMENT_ID, MIN(SALARY) 
                                 FROM EMPLOYEES
                                 GROUP BY DEPARTMENT_ID)
ORDER BY DEPARTMENT_ID;
                 
-- 8.	Display the last name of the lowest paid employee(s) in each city

SELECT LAST_NAME
FROM EMPLOYEES
WHERE SALARY IN (SELECT MIN(SALARY) 
                 FROM EMPLOYEES
                 WHERE DEPARTMENT_ID IN(
                 SELECT DEPARTMENT_ID FROM DEPARTMENTS
                 WHERE LOCATION_ID IN (
                 SELECT LOCATION_ID FROM LOCATIONS)));
        

-- 9.	Display last name and salary for all employees who earn less than the lowest salary in ANY department. 
-- Sort the output by top salaries first and then by last name.

SELECT LAST_NAME, 
       to_char(SALARY, '$999,999.99') AS SALARY
       FROM EMPLOYEES
WHERE SALARY < ANY(SELECT MIN(SALARY)
                   FROM EMPLOYEES
                   GROUP BY DEPARTMENT_ID)
ORDER BY SALARY DESC, LAST_NAME;

-- 10.	Display last name, job title and salary for all employees whose salary matches any 
-- of the salaries from the IT Department. Do NOT use Join method.
-- Sort the output by salary ascending first and then by last_name

SELECT LAST_NAME, 
       JOB_ID,  
       to_char(SALARY, '$999,999.99') AS SALARY
FROM EMPLOYEES
WHERE SALARY IN (SELECT SALARY 
FROM EMPLOYEES
WHERE JOB_ID = 'IT_PROG')
ORDER BY SALARY DESC;

