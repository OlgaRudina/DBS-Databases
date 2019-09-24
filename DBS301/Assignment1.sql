-- ***********************
-- Name: Olga Rudina
-- ID: 039949136
-- Date: 08-Oct-2018
-- Purpose: Assignment 1 - DBS301
-- ***********************

--1.	Display the employee number, full employee name, job and hire date of all employees hired in May or November
-- of any year, with the most recently hired employees displayed first. 
-- •	Also, exclude people hired in 1994 and 1995.  
-- •	Full name should be in the form Lastname,  Firstname  with an alias called Full Name.
-- •	Hire date should point to the last day in May or November of that year (NOT to the exact day) and be in the
-- form of [May 31<st,nd,rd,th> of 1996] with the heading Start Date. Do NOT use LIKE operator. 
-- •	<st,nd,rd,th> means days that end in a 1, should have “st”, days that end in a 2 should have “nd”, 
-- days that end in a 3 should have “rd” and all others should have “th”
-- •	You should display ONE row per output line by limiting the width of the Full Name to 25 characters.

SELECT EMPLOYEE_ID, 
LAST_NAME|| ', ' || FIRST_NAME  AS "FULL NAME", 
JOB_ID,
TO_CHAR(HIRE_DATE, 'fm[Month ddth "of" yyyy]') AS "HIRE DATE"
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE, 'fmMonth') IN ('May', 'November') 
AND TO_CHAR(HIRE_DATE, 'yyyy') NOT IN (1994, 1995)
ORDER BY HIRE_DATE DESC;


-- 2.	List the employee number, full name, job and the modified salary for all employees whose monthly earning
-- (without this increase) is outside the range $6,000 – $11,000 and who are employed as Vice Presidents or Managers
-- (President is not counted here).  
-- •	You should use Wild Card characters for this. 
-- •	VP’s will get 30% and managers 20% salary increase.  
-- •	Sort the output by the top salaries (before this increase) firstly.
-- •	Heading will be like Employees with increased Pay
-- •	The output lines should look like this sample line:
-- Emp# 124 named Kevin Mourgos who is ST_MAN will have a new salary of $6960

SELECT 'Emp# '|| EMPLOYEE_ID ||  ' named ' || FIRST_NAME || ' ' || LAST_NAME || ' who is ' || JOB_ID ||
' will have a new salary of $ ' ||
CASE
WHEN JOB_ID LIKE '%VP%'
THEN SALARY * 1.3
ELSE SALARY * 1.2
END "Employees with increased Pay"
FROM EMPLOYEES
WHERE (SALARY NOT BETWEEN 6000 AND 11000)
AND (JOB_ID LIKE '%VP' 
OR JOB_ID LIKE '%MGR'
OR JOB_ID LIKE '%MAN')
ORDER BY SALARY DESC;


-- 3.	Display the employee last name, salary, job title and manager# of all employees not earning a commission 
-- OR if they work in the SALES department, but only  if their total monthly salary with $1000 included bonus 
-- and  commission (if  earned) is  greater  than  $15,000.  
-- •	Let’s assume that all employees receive this bonus.
-- •	If an employee does not have a manager, then display the word NONE 
-- •	instead. This column should have an alias Manager#.
-- •	Display the Total annual salary as well in the form of $135,600.00 with the 
-- •	heading Total Income. Sort the result so that best paid employees are shown first.

SELECT LAST_NAME AS "Last Name", 
to_char(SALARY, '$999,999') AS "Salary", 
JOB_ID AS "Job Title", 
NVL(TO_CHAR(MANAGER_ID),'NONE') AS "Manager#",
TO_CHAR(((SALARY+1000) * 12),'$999,999.99') AS "Total Income"
FROM EMPLOYEES
WHERE (NVL(COMMISSION_PCT,0) = 0
OR DEPARTMENT_ID = 80)
AND (SALARY + 1000 + (SALARY * NVL(COMMISSION_PCT,0))) > 15000
ORDER BY "Total Income" DESC;

-- 4.	Display Department_id, Job_id and the Lowest salary for this combination under the alias Lowest Dept/Job Pay, 
-- but only if that Lowest Pay falls in the range $6000 - $18000. 
-- Exclude people who work as some kind of Representative job from this query and departments IT and SALES as well.
-- •	Sort the output according to the Department_id and then by Job_id.
-- •	You MUST NOT use the Subquery method.

SELECT DEPARTMENT_ID AS "Department#",
JOB_ID "Job Title",
MIN(SALARY) AS "Lowest Dept/Job Pay"
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID,JOB_ID
HAVING MIN(SALARY) BETWEEN 6000 AND 18000
AND JOB_ID NOT LIKE '%REP'
AND DEPARTMENT_ID NOT IN(60,80)
ORDER BY DEPARTMENT_ID, JOB_ID;

-- 5.	Display last_name, salary and job for all employees who earn more than all lowest paid
-- employees per department outside the US locations.
-- •	Exclude President and Vice Presidents from this query.
-- •	Sort the output by job title ascending.
-- •	You need to use a Subquery and Joining with the NEW (Oracle9i) method.

SELECT LAST_NAME AS "Last Name",
SALARY AS "Salary",
JOB_ID AS "Job Id"
FROM    EMPLOYEES 
WHERE   SALARY > ALL (SELECT MIN(SALARY)
                      FROM EMPLOYEES JOIN DEPARTMENTS USING (DEPARTMENT_ID)
                      JOIN LOCATIONS USING (LOCATION_ID)
                      WHERE COUNTRY_ID NOT LIKE  'US'
                      GROUP BY DEPARTMENT_ID)
AND JOB_ID NOT IN ('AD_PRES','AD_VP')
ORDER BY JOB_ID;


-- 6.	Who are the employees (show last_name, salary and job) who work either in IT or 
-- MARKETING department and earn more than the worst paid person in the ACCOUNTING department. 
-- •	Sort the output by the last name alphabetically.
-- •	You need to use ONLY the Subquery method (NO joins allowed).

SELECT LAST_NAME AS "Last Name",
SALARY AS "Salary",
JOB_ID AS "Job Id"
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (20,60)
AND SALARY > (SELECT MIN(SALARY)
                FROM EMPLOYEES 
                WHERE DEPARTMENT_ID = 110)
ORDER BY LAST_NAME;    

-- 7.	Display alphabetically the full name, job, salary (formatted as a currency amount incl. 
-- thousand separator, but no decimals) and department number for each employee who earns less than 
-- the best paid unionized employee (i.e. not the president nor any manager nor any VP), 
-- and who work in either SALES or MARKETING department.  
-- •	Full name should be displayed as Firstname  Lastname and should have the heading Employee. 
-- •	Salary should be left-padded with the = symbol till the width of 12 characters. It should have an alias Salary.
-- •	You should display ONE row per output line by limiting the width of the Employee to 25 characters.


SELECT SUBSTR((FIRST_NAME ||' '|| LAST_NAME), 1,25) AS "Employee",
JOB_ID AS "Job Id",
LPAD(TO_CHAR(SALARY,'99,999'),12,'=') AS "Salary",
DEPARTMENT_ID AS "Department#"
FROM EMPLOYEES
WHERE SALARY < (SELECT MAX(SALARY)
                FROM EMPLOYEES
                WHERE JOB_ID NOT LIKE '%MAN'
                AND  JOB_ID NOT LIKE '%MGR'
                AND  JOB_ID NOT LIKE '%VP'
                AND  JOB_ID NOT LIKE '%PRES') 
AND DEPARTMENT_ID IN (80,20)
ORDER BY "Employee" ASC;


-- 8.	“Tricky One”
-- Display department name, city and number of different jobs in each department. 
-- If city is null, you should print Not Assigned Yet.
-- •	This column should have alias City.
-- •	Column that shows # of different jobs in a department should have the heading # of Jobs
-- •	You should display ONE row per output line by limiting the width of the City to 25 characters.
-- •	You need to show complete situation from the EMPLOYEE point of view, meaning include also employees 
-- who work for NO department (but do NOT display empty departments) and 
-- from the CITY point of view meaning you need to display all cities without departments as well.
-- •	You need to use Outer Joining with the NEW (Oracle9i) method.

SELECT 
NVL(DEPARTMENT_NAME, 'No Department') AS "Deparmtent Name",
SUBSTR(NVL(CITY,'Not Assigned Yet'),1,25) AS "City",
COUNT(DISTINCT(JOB_ID)) AS "# of Jobs"
FROM LOCATIONS LEFT JOIN DEPARTMENTS USING(LOCATION_ID)
FULL OUTER JOIN EMPLOYEES USING(DEPARTMENT_ID)
GROUP BY CITY, DEPARTMENT_NAME;


