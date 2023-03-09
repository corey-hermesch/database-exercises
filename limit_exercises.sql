-- limit_exercises.sql
SHOW databases;
use employees;
show tables;

-- 2. list the first 10 distinct last names sorted in descending order
SELECT DISTINCT last_name
FROM employees
ORDER BY last_name DESC
LIMIT 10
;

-- 3. Find employees hired in 90s and born on christmas. Find 
-- first 5 hired in 90s, sort by hire date. What are the 5 names?
SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
   AND birth_date LIKE '%12-25'
ORDER BY hire_date
LIMIT 5
;
/* Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner,
Petter Stroustrup
*/

-- 4. Query for 10th "page" or 10th set of 5 names from previous query
SELECT *
FROM employees
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'
   AND birth_date LIKE '%12-25'
ORDER BY hire_date
LIMIT 5 OFFSET 45
;
-- 4. cont. What is relationship btwn OFFSET, LIMIT, and the page number
-- page number * LIMIT - LIMIT = OFFSET
-- Example from above asked for the 10th page of 5. I multiplied 10 (page
-- number) x 5 (LIMIT) and then subtracted 5 (the LIMIT) to get my OFFSET.
-- (10 * 5) - 5 = 45.  Then it gave me rows 46-50.

