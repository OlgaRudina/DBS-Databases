-- ***********************
-- Name: Olga Rudina
-- ID: 039949136
-- Date: 13/09/2018
-- Purpose: Lab 2 DBS301
-- ***********************

-- Q1: Display employee ID, last name, and salary of employees with a salary within the of $9000 to $11000. 
-- Sort by salaries then last name
-- Q2: Modify the query from Q1 so it only displays employees who are Porgrammers or Sales Reps
-- Q3: Modify the Q2 query so that it displays job titles of those outside the Q1 salary range
-- Q4: Display employee last names, job IDs, and salaries for those employed before 1998. List by most recent
-- Q5: Modify Q4 query to show employees earning $10,000. Sort job title alphabetically then by highest paid
-- Q6: Show job titles and full names where the first name contains an 'e'
-- Q7: Display last name, salary, and commission percent for who has commission
-- Q8: Same as Q7, but order of descending salaries
-- Q9: Same as Q8, but sorting with numeric value

SELECT EMPLOYEE_ID, LAST_NAME,  to_char(SALARY, '$999,999.99') FROM employees 
WHERE (SALARY BETWEEN 9000 AND 11000) 
ORDER BY SALARY DESC, LAST_NAME;

SELECT EMPLOYEE_ID, LAST_NAME,  to_char(SALARY, '$999,999.99') FROM employees 
WHERE (SALARY BETWEEN 9000 AND 11000) 
AND (JOB_ID = 'SA_REP' OR JOB_ID = 'IT_PROG')
ORDER BY SALARY DESC, LAST_NAME;

SELECT EMPLOYEE_ID, LAST_NAME,  to_char(SALARY, '$999,999.99') FROM employees 
WHERE (SALARY NOT BETWEEN 9000 AND 11000) 
AND (JOB_ID = 'SA_REP' OR JOB_ID = 'IT_PROG')
ORDER BY  SALARY DESC, LAST_NAME;

SELECT LAST_NAME, JOB_ID,  to_char(SALARY, '$999,999.99') FROM employees 
WHERE HIRE_DATE < TO_DATE('01-JAN-1998', 'DD-MON-YYYY') 
ORDER BY HIRE_DATE DESC;

SELECT LAST_NAME, JOB_ID,  to_char(SALARY, '$999,999.99') FROM employees 
where hire_date < TO_DATE('01-JAN-1998', 'DD-MON-YYYY')
AND SALARY > 10000
ORDER BY JOB_ID, SALARY DESC;

SELECT JOB_ID AS "Job Title",
CONCAT(CONCAT(TRIM(FIRST_NAME), ' '),TRIM(LAST_NAME)) AS "Full Name"
FROM EMPLOYEES 
WHERE FIRST_NAME LIKE '%e%' 
ORDER BY JOB_ID;

--Questions 7-9--

SELECT LAST_NAME AS "Last Name", 
SALARY AS "Salary", 
COMMISSION_PCT AS "Commission Percent"
FROM EMPLOYEES
WHERE COMMISSION_PCT > 0;

SELECT LAST_NAME AS "Last Name", 
SALARY AS "Salary", 
COMMISSION_PCT AS "Commission Percent"
FROM EMPLOYEES
WHERE COMMISSION_PCT > 0
ORDER BY SALARY DESC;

SELECT LAST_NAME AS "Last Name", 
SALARY AS "Salary", 
COMMISSION_PCT AS "Commission Percent"
FROM EMPLOYEES
WHERE COMMISSION_PCT > 0
ORDER BY 2 DESC;
