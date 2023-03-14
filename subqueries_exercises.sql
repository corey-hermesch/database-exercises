-- subqueries_exercises.sql

-- 1. Find all current employees with same hire date as employee 101010
-- using a subquery
use employees;
SELECT hire_date
FROM employees
WHERE emp_no = 101010
;
SELECT concat(e.first_name, ' ', e.last_name), e.hire_date
FROM employees as e
JOIN dept_emp as de using(emp_no)
WHERE e.hire_date = (
   SELECT hire_date
   FROM employees
   WHERE emp_no = 101010
   )
 AND de.to_date > NOW()
;

-- 2. Find all titles ever held by all current employees w/ first name 'Aamod'
SELECT *
FROM employees
WHERE first_name = 'Aamod'
;
SELECT *
FROM titles
WHERE to_date > NOW()
;

SELECT cur_titles.title -- , COUNT(cur_titles.title) AS number_of_aamods
FROM (
      SELECT *
      FROM employees
      WHERE first_name = 'Aamod'
      ) AS aa
JOIN (
     SELECT *
     FROM titles
     WHERE to_date > NOW()
     ) AS cur_titles USING (emp_no)
GROUP BY cur_titles.title
;     

-- 3. How many people in the employees table are no longer working for the company?
-- Give the answer in a comment in your code
-- ANSWER: 59,071 people who are in the employees table that are no longer
-- working for the company
SELECT COUNT(DISTINCT(CONCAT(e.first_name, ' ', e.last_name))) -- some names might be duplicates if they had >1 jobs prior to separating
FROM dept_emp AS de
JOIN employees AS e
  ON de.emp_no = e.emp_no
WHERE de.to_date < NOW()         -- counting those whose to_dates are before now 
   AND e.emp_no NOT IN (          -- BUT, we have to exclude those names who promoted/changed jobs
      SELECT emp_no FROM dept_emp WHERE to_date > NOW()
      )
;


-- 4. Find all the current department managers that are female. 
-- List their names in a comment in your code.
-- Four Names:  Isamu Legleitner, Karsten Sigstam, Leon DasSama, Hilary Kambil
-- Seems like there should be a more efficient way of doing that than generating
-- a select statement to get the emp_no's for all females.  Maybe reattack later.
SELECT *
FROM dept_manager AS dm
JOIN employees as e
  ON dm.emp_no = e.emp_no 
WHERE dm.to_date > NOW()
   AND dm.emp_no IN (
      SELECT e.emp_no 
      FROM employees AS e
      JOIN dept_manager AS de USING (emp_no)
      WHERE e.gender = 'F'
      )
;

-- 5. Find all the employees who currently have a higher salary than the 
-- companies overall, historical average salary.

SELECT DISTINCT(CONCAT(e.first_name, ' ', e.last_name)) -- accounting for repeated names (same person with different emp_no's)
FROM salaries AS s
JOIN employees AS e
  ON s.emp_no = e.emp_no
WHERE s.to_date > NOW()
   AND s.salary > (
      SELECT AVG(salary)
      FROM salaries
   ) 
;


-- 6. How many current salaries are within 1 standard deviation of the current highest salary? 
-- Hint: you can use a built in function to calculate the standard deviation.) 
-- What percentage of all salaries is this?
-- Hint You will likely use multiple subqueries in a variety of ways
-- Hint It's a good practice to write out all of the small queries that you can. 
-- Add a comment above the query showing the number of rows returned. 
-- You will use this number (or the query that produced it) in other, larger queries.

SELECT AVG(s.salary), STD(s.salary), MAX(s.salary)
FROM salaries AS s
;

-- 78 salaries are within one std deviation of the max
-- .0027% of all salaries are within 1 std deviation of the max current salary
SELECT COUNT(s.salary), (COUNT(s.salary) / (SELECT COUNT(salary) FROM salaries) * 100) AS percent_of_total
FROM salaries AS s
WHERE s.salary >= (SELECT (MAX(s.salary) - STD(s.salary)) FROM salaries AS s)
  AND s.to_date > NOW()
;

