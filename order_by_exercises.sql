-- order_by_exercises.sql
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
-- first row: Irena Ancton, last row: Vidya Zweizig

-- 4. Find all employees I, V, M & order by last then first name
-- what is first & last name in first/last row?
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name
;
-- First row: Irena Acton, last row: Maya Zydia

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