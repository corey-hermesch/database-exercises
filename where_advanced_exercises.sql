show databases;
use employees;
show tables;
select * 
from employees;

-- 1. Find all employees with Iren, Vidya, Maya
SELECT *
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
;

-- 2. Find all employees as above but use or instead of in. 
-- What is employee number of top 3 results? Does it match above?
SELECT *
FROM employees
WHERE first_name = 'Irena'
  OR first_name = 'Vidya'
  OR first_name = 'Maya'
;
-- The employee numbers DID match (10200, 10397, 10610)

-- 3. Find all employees as above using or & who is male
SELECT *
FROM employees
WHERE (
		first_name = 'Irena'
		OR first_name = 'Vidya'
		OR first_name = 'Maya'
	  )
	AND (
		gender = 'M'
        )
;
-- Top 3 employee numbers: 10200, 10397, 10821

-- 4. Find all unique last names that start with 'E'
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE 'E%'
;

-- 5. Find all unique last names that start or end with 'E'
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE 'E%'
    OR last_name LIKE '%e'
;

-- 6. Find all unique last names that end with E, but does not start with E
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE '%e'
   AND last_name NOT LIKE 'E%'
;

-- 7. Find all unique last names that start and end with 'e'
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE 'E%'
    AND last_name LIKE '%e'
;

-- 8. Find all employees hired in the 90s. What are top 3 emp numbers?
SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
;
-- Top 3 emp_no's: 10008, 10011, 10012

-- 9. Find all employees born on Christmas
SELECT *
FROM employees
WHERE birth_date LIKE '%12-25'
;

-- 10. Find all employees hired in 90s and born on Christmas. List top 3
SELECT *
FROM employees
WHERE birth_date LIKE '%12-25'
    AND hire_date BETWEEN '1990-01-01' AND '1999-12-31'
;
-- Top 3 emp_no's are 10261, 10438, 10681

-- 11. Find all unique last names that hafe a 'q' in their last name
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE '%q%'
;

-- 12. Find all unique last names that have a 'q' but not a 'qu'.
SELECT DISTINCT last_name
FROM employees
WHERE last_name LIKE '%q%'
   AND last_name NOT LIKE '%qu%'
;
