-- order_by_exercises.sql, functions_exercises.sql
SHOW databases;
use employees;
show tables;

-- 2. Find all employees w/ first name 'Irena', 'Vidya', or 'Maya'
-- and order results by first name. What is first & last name of first 
-- row and last row?
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name 
;
-- First row: Irena Reutenauer, Last row: Vidya Simmen

-- 3. Find all employees with names I, V, M and order results by first
-- then last name. What is first & last name in first row/last row?
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name
;
-- first row: Irena Acton, last row: Vidya Zweizig

-- 4. Find all employees I, V, M & order by last then first name
-- what is first & last name in first/last row?
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name
;
-- First row: Irena Acton, last row: Maya Zyda

-- 5. query for last name starts and ends with 'e'; sort by emp_no.
-- How many employees are returned?
-- what is emp_no, first, last of the first/last rows?

SELECT *
FROM employees
WHERE last_name LIKE 'e%'
   AND last_name LIKE '%e'
ORDER BY emp_no
;
-- 899 rows
-- First row: 10021 Ramzi Erde, Last row: 499648, Tadahiro Erde

-- 6. Query for all employees, last name start/end with e, sort by hire
-- date so that newest employees listed first. Need number of employees, 
-- name of newest/oldest employees

SELECT COUNT(emp_no) AS all_emps
FROM employees
WHERE last_name LIKE 'e%'
   AND last_name LIKE '%e'
ORDER BY hire_date DESC
;
-- 899 rows
-- Newest employee: Teiji Eldridge, Oldest: Sergi Erde

-- 7. Find all employees hired in 90s & born on Christmas, sort by oldest,
-- hired last
SELECT * 
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
  AND birth_date LIKE '%12-25'
ORDER BY birth_date, hire_date DESC
;
-- 362 rows
-- Oldest employee hired last: Khun Bernini
-- Youngest employee hired first: Douadi Pettis

/* 
Exercise Goals
    Copy the order by exercise and save it as functions_exercises.sql.
*/

--    Write a query to to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.
SHOW databases;
USE employees;
SHOW tables;
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM employees
WHERE last_name LIKE 'e%e'
;

--    Convert the names produced in your last query to all uppercase.
SELECT UPPER (CONCAT(first_name, ' ', last_name)) AS full_name
FROM employees
WHERE last_name LIKE 'e%e'
;

--    Use a function to determine how many results were returned from your previous query.
SELECT COUNT(last_name)
FROM employees
WHERE last_name LIKE 'e%e'
;

--    Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),
SELECT hire_date, DATEDIFF(NOW(), hire_date) AS days_working_at_company
FROM employees
WHERE hire_date LIKE '199%'
   and birth_date LIKE '%12-25'
;

-- Find the smallest and largest current salary from the salaries table.
SHOW tables;
SELECT MIN(salary) AS min_salary, MAX(salary) AS max_salary
FROM salaries
;

/*
    Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:

+------------+------------+-----------+------------+
| username   | first_name | last_name | birth_date |
+------------+------------+-----------+------------+
| gface_0953 | Georgi     | Facello   | 1953-09-02 |
| bsimm_0664 | Bezalel    | Simmel    | 1964-06-02 |
| pbamf_1259 | Parto      | Bamford   | 1959-12-03 |
| ckobl_0554 | Chirstian  | Koblick   | 1954-05-01 |
| kmali_0155 | Kyoichi    | Maliniak  | 1955-01-21 |
| apreu_0453 | Anneke     | Preusig   | 1953-04-20 |
| tziel_0557 | Tzvetan    | Zielinski | 1957-05-23 |
| skall_0258 | Saniya     | Kalloufi  | 1958-02-19 |
| speac_0452 | Sumant     | Peac      | 1952-04-19 |
| dpive_0663 | Duangkaew  | Piveteau  | 1963-06-01 |
+------------+------------+-----------+------------+
10 rows in set (0.05 sec)

*/
SELECT LOWER ( 
         CONCAT (
             SUBSTR(first_name, 1, 1) -- first char of first name
           , SUBSTR(last_name, 1, 4)  -- first 4 chars of last name
           , '_'
           , SUBSTR(birth_date, 6, 2) -- 2-digit month
           , SUBSTR(birth_date, 3, 2) -- 2-digit year
           )
			 ) AS username
   , first_name 
   , last_name
   , birth_date
FROM employees
;
SHOW CREATE TABLE employees;
SELECT MONTH(birth_date)
FROM employees
;