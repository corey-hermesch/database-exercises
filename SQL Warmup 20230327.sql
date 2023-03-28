# SQL Warmup 20230327
show databases;
/* SQL WARMUP:
--Find all employees who are current managers and make more than one standard deviation 
over the companies salary average.
*/

use employees;
show tables;
SELECT *
FROM employees;

SELECT AVG(salary) as mean, STD(salary) as std_dev
FROM salaries;

SELECT e.first_name, e.last_name, s.salary
FROM employees as e
JOIN dept_manager as dm USING (emp_no)
JOIN salaries as s USING (emp_no)
WHERE dm.to_date > NOW()
AND s.to_date > NOW()
AND s.salary > (63810.75+16904.83)
;


SELECT e.first_name, e.last_name, s.salary 
FROM employees as e
JOIN dept_manager as dm USING (emp_no)
JOIN salaries as s USING (emp_no)
WHERE dm.to_date > NOW()
AND s.to_date > NOW()
AND s.salary > (SELECT avg(salary) + std(salary) FROM salaries)
;


