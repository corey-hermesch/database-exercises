USE employees;
SELECT *
FROM employees
;

USE chipotle;
show tables;
SELECT count(id)
FROM orders

;
SELECT *
FROM orders;
#     Write the code necessary to create a cross tabulation of the number of titles by department. 
# (Hint: this will involve a combination of SQL code to pull the necessary data and python/pandas code 
# to perform the manipulations.)

use employees
;
SELECT *
FROM salaries
WHERE to_date > NOW()
;
# warmup
# -- Using the customer, address, city, and country table in the sakila db
# -- find all customers that live in Poland.
# -- Output two columns titled: full_name, email

use sakila;
show tables;

SELECT concat(c.first_name, ' ', c.last_name) as full_name, c.email #, cntry.country 
FROM customer AS c
   JOIN address AS a ON c.address_id = a.address_id 
   JOIN city as cty on a.city_id = cty.city_id
   JOIN country as cntry on cty.country_id = cntry.country_id
WHERE cntry.country = "Poland"
;

USE telco_churn;
SELECT * 
FROM customers
JOIN customer_churn USING (customer_id)
JOIN internet_service_types USING (internet_service_type_id)
;

use employees;
SELECT emp_no, COUNT(title)
FROM titles
GROUP BY emp_no
;
SELECT *
FROM employees
JOIN salaries USING (emp_no)
JOIN titles USING (emp_no)
;
SELECT emp_no, hire_date, title, from_date, to_date
FROM employees
JOIN titles USING (emp_no)
;
SELECT emp_no, hire_date, salary, from_date, to_date
FROM employees
JOIN salaries USING (emp_no)
;

SELECT COUNT(emp_no)
FROM employees;