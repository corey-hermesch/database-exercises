/*
1. Using the example from the lesson, create a temporary table called employees_with_departments 
that contains first_name, last_name, and dept_name for employees currently with that department. 
Be absolutely sure to create this table on your own database. If you see "Access denied for user 
...", it means that the query was attempting to write a new table to a database that you can only read.

    - Add a column named full_name to this table. It should be a VARCHAR whose length is the sum 
    of the lengths of the first name and last name columns.
    - Update the table so that the full_name column contains the correct data.
    - Remove the first_name and last_name columns from the table.
    - What is another way you could have ended up with this same table?
*/ 
USE employees;
SHOW tables;
-- First i'll make the subquery to get the table
SELECT e.first_name, e.last_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de USING (emp_no)
JOIN departments as d USING (dept_no)
WHERE de.to_date > CURDATE()
;
-- Now I'll put it into a 'create temp table'
CREATE TEMPORARY TABLE pagel_2179.employees_with_departments AS
SELECT e.first_name, e.last_name, d.dept_name
FROM employees AS e
JOIN dept_emp AS de USING (emp_no)
JOIN departments as d USING (dept_no)
WHERE de.to_date > CURDATE()
;
USE pagel_2179;
DESCRIBE employees_with_departments;
/*
    - Add a column named full_name to this table. It should be a VARCHAR whose length is the sum 
    of the lengths of the first name and last name columns.
*/
SELECT MAX(LENGTH(first_name) + LENGTH(last_name)) + 1
FROM employees_with_departments
;
-- 30 is the max length; couldn't put the max or length functions into the varchar
ALTER TABLE employees_with_departments 
ADD full_name VARCHAR(30)
;
SELECT * FROM employees_with_departments;

-- Update the table so that the full_name column contains the correct data.
UPDATE employees_with_departments
SET full_name = CONCAT(first_name, ' ', last_name)
;

-- Remove the first_name and last_name columns from the table.
ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

-- What is another way you could have ended up with this same table?
-- Answer: I could have used a different subquery when I created the temp table
 
/*
2. Create a temporary table based on the payment table from the sakila database.

Write the SQL necessary to transform the amount column such that it is stored as an integer 
representing the number of cents of the payment. For example, 1.99 should become 199.
*/
USE sakila;
SELECT * FROM payment;
-- make the query first
SELECT payment_id, customer_id, staff_id, rental_id, 
       CAST((amount*100) AS SIGNED) AS cents_amount, 
       payment_date, last_update
FROM payment
;
-- now create the table
CREATE TEMPORARY TABLE pagel_2179.sakila_payment AS
	SELECT payment_id, customer_id, staff_id, rental_id, 
		   CAST((amount*100) AS SIGNED) AS cents_amount, 
		   payment_date, last_update
	FROM payment
;
USE pagel_2179;
SELECT * FROM sakila_payment;
/*
3. Find out how the current average pay in each department compares to the overall current pay for 
everyone at the company. For this comparison, you will calculate the z-score for each salary. 
In terms of salary, what is the best department right now to work for? The worst?
*/
USE employees;
-- Code below is from the assignment; it calculates zscores for all salaries
SELECT salary,
	(salary - (SELECT AVG(salary) FROM salaries where to_date > now()))
	/
	(SELECT stddev(salary) FROM salaries where to_date > now()) AS zscore
FROM salaries
WHERE to_date > now();

-- test query to get all the data I need into one "table"
SELECT *
FROM salaries AS s
JOIN dept_emp AS de USING(emp_no)
JOIN departments AS d USING(dept_no)
WHERE s.to_date > NOW() AND de.to_date > now()
;
-- Using above work, this is the query to get dept_names and 
-- average salary in each department
SELECT dept_name, AVG(s.salary) AS avg_dept_salary
FROM salaries AS s
JOIN dept_emp AS de USING(emp_no)
JOIN departments AS d USING(dept_no)
WHERE s.to_date > NOW() AND de.to_date > NOW()
GROUP BY dept_name
;
-- create a temp table with the above query
CREATE TEMPORARY TABLE pagel_2179.avg_dept_salaries AS
SELECT dept_name, AVG(s.salary) AS avg_dept_salary
FROM salaries AS s
JOIN dept_emp AS de USING(emp_no)
JOIN departments AS d USING(dept_no)
WHERE s.to_date > NOW() AND de.to_date > NOW()
GROUP BY dept_name
;
SELECT * FROM pagel_2179.avg_dept_salaries;
SELECT *,
	(avg_dept_salary - (SELECT AVG(salary) FROM salaries where to_date > now()))
	/
	(SELECT stddev(salary) FROM salaries where to_date > now()) AS zscore
FROM pagel_2179.avg_dept_salaries
ORDER BY zscore DESC
;
-- The average salary in Sales is almost 1 standard deviation above the overall average salary
-- Human Resources has the lowest average salary, ~.47 standard deviations below the mean