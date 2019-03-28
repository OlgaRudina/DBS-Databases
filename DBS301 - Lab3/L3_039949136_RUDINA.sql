-- ***********************
-- Name: Olga Rudina
-- ID: 039949136
-- Date: 20/09/2018
-- Purpose: Lab 3 DBS301
-- ***********************

-- Write a query to display the tomorrow’s date in the following format:
-- September 28th of year 2016
-- Your result will depend on the day when you RUN/EXECUTE this query.  
-- Label the column Tomorrow.

SELECT to_char(SYSDATE+1, 'Month ddth "of year" YYYY') AS "Tomorrow"
from DUAL;

-- For each employee in departments 20, 50 and 60 display last name, first name, 
-- salary, and salary increased by 5% and expressed as a whole number.  
-- Label the column Good Salary.  
-- Also add a column that subtracts the old salary from the new salary and multiplies by 12.
-- Label the column "Annual Pay Increase".

SELECT 
LAST_NAME, 
FIRST_NAME, 
to_char(SALARY, '$999,999'), 
to_char(ROUND(SALARY + (SALARY * 0.5)),'$999,999') AS "Good Salary",
to_char(ROUND(((SALARY + (SALARY * 0.5)) - SALARY) * 12),'$999,999') AS "Annual Pay Increase"
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(20, 50, 60);

-- Write a query that displays the employee’s Full Name and Job Title
-- in the following format: DAVIES, CURTIS is ST_CLERK 
-- Only employees whose last name ends with S and first name starts with C or K.  
-- Give this column an appropriate label like Person and Job.  
-- Sort the result by the employees’ last names.

SELECT 
UPPER(LAST_NAME) ||', ' || UPPER(FIRST_NAME)|| ' is ' || UPPER(JOB_ID) 
AS "Person and Job"
FROM EMPLOYEES
WHERE UPPER(LAST_NAME) LIKE '%S'
AND (UPPER(FIRST_NAME) LIKE 'C%' 
OR UPPER(FIRST_NAME)LIKE 'K%')
ORDER BY LAST_NAME;

-- For each employee hired before 1992, display the employee’s last name, 
-- hire date and calculate the number of YEARS between TODAY
-- and the date the employee was hired.
-- a. Label the column Years worked. 
-- b. Order your results by the number of years employed. 
-- Round the number of years employed up to the closest whole number.

SELECT LAST_NAME, HIRE_DATE,
ROUND(TO_CHAR(SYSDATE-HIRE_DATE)/365) AS "Years worked"
FROM EMPLOYEES
WHERE HIRE_DATE < TO_DATE('01-JAN-1992', 'DD-MON-YYYY') 
ORDER BY "Years worked" DESC;


-- Create a query that displays the city names, country codes and state province names, 
-- but only for those cities that starts with S and has at least 8 characters in their name. 
-- If city does not have a province name assigned, then put Unknown Province.  
-- Be cautious of case sensitivity!

SELECT CITY, COUNTRY_ID, NVL(STATE_PROVINCE,'Unknown Province')
FROM LOCATIONS
WHERE UPPER(CITY) LIKE 'S%'
AND LENGTH(CITY) >=8;


-- Display each employee’s last name, hire date, and salary review date, 
-- which is the first Thursday after a year of service, 
-- but only for those hired after 1997.  
-- a.	Label the column REVIEW DAY. 
-- b.	Format the dates to appear in the format like:
--    THURSDAY, August the Thirty-First of year 1998
-- c.	Sort by review date

SELECT LAST_NAME, HIRE_DATE, 
TO_CHAR((NEXT_DAY(ADD_MONTHS(HIRE_DATE,12), 'THURSDAY')), 'DAY, Month "the" Ddspth "of year" YYYY') 
AS "REVIEW DAY"
FROM EMPLOYEES
WHERE HIRE_DATE >= TO_DATE('01-JAN-1998', 'DD-MON-YYYY') 
ORDER BY "REVIEW DAY";