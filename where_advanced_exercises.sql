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
