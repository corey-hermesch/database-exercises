/* Bonus_aggregate_functions_exercises
Bonus: More practice with aggregate functions:
*/

--  Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
SHOW databases;
USE employees;
SHOW tables;
SELECT emp_no, ROUND ( AVG(salary), 0) AS avg_salary
FROM salaries
GROUP BY emp_no
;

--  Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.
SELECT dept_no, COUNT(*) AS emp_count
FROM dept_emp
GROUP BY dept_no
;

-- Determine how many different salaries each employee has had. This includes both historic and current.
SELECT emp_no, COUNT(*) AS emp_count
FROM salaries
GROUP BY emp_no
;

-- Find the maximum salary for each employee.
SELECT emp_no, MAX(salary) AS max_salary
FROM salaries
GROUP BY emp_no
;


-- Find the minimum salary for each employee.
SELECT emp_no, MIN(salary) AS min_salary
FROM salaries
GROUP BY emp_no
;

-- Find the standard deviation of salaries for each employee.
SELECT emp_no
  , MIN(salary) AS min_salary
  , MAX(salary) AS max_salary
  , ROUND (AVG(salary), 0) AS mean_salary
  , ROUND (STD(salary), 0) AS std_deviation_salary
FROM salaries
GROUP BY emp_no
;


/*
    Now find the max salary for each employee where that max salary is greater than $150,000.

    Find the average salary for each employee where that average salary is between $80k and $90k.
*/