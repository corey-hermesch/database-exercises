/*
Exercise Goals

    Use the GROUP BY clause to create more complex queries

    Create a new file named group_by_exercises.sql
*/

--  In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
SHOW databases;
USE employees;
SHOW tables;
SELECT DISTINCT title
FROM titles
;
-- 7 unique titles


-- 3.  Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
SELECT last_name
FROM employees
GROUP BY last_name
HAVING last_name LIKE 'e%e'
;

-- 4.   Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT first_name, last_name
FROM employees
GROUP BY first_name, last_name
HAVING last_name LIKE 'e%e'
;

-- 5.  Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
SELECT last_name
FROM employees
GROUP BY last_name
HAVING last_name LIKE '%q%'
   AND last_name NOT LIKE '%qu%'
;
-- Chleq, Lindqvist, Qiwen

-- 6.   Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
SELECT last_name, COUNT(*) AS count_of_last_name
FROM employees
GROUP BY last_name
HAVING last_name LIKE '%q%'
   AND last_name NOT LIKE '%qu%'
;

-- 7.   Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.
SELECT first_name, gender, COUNT(*) AS cnt_of_M_F
FROM employees
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
GROUP BY first_name, gender
ORDER BY first_name
;


-- 8.  Using your query that generates a username for all of the employees, generate a count employees for each unique username.
SELECT LOWER ( 
         CONCAT (
             SUBSTR(first_name, 1, 1) -- first char of first name
           , SUBSTR(last_name, 1, 4)  -- first 4 chars of last name
           , '_'
           , SUBSTR(birth_date, 6, 2) -- 2-digit month
           , SUBSTR(birth_date, 3, 2) -- 2-digit year
                )
                         ) AS username
   , COUNT(*) AS u_username_count
   , first_name 
   , last_name
   , birth_date
FROM employees
GROUP BY username, first_name, last_name, birth_date
;

-- 9.  From your previous query, are there any duplicate usernames? What is the higest number of times a username shows up? Bonus: How many duplicate usernames are there from your previous query?

SELECT LOWER ( 
         CONCAT (
             SUBSTR(first_name, 1, 1) -- first char of first name
           , SUBSTR(last_name, 1, 4)  -- first 4 chars of last name
           , '_'
           , SUBSTR(birth_date, 6, 2) -- 2-digit month
           , SUBSTR(birth_date, 3, 2) -- 2-digit year
                )
			) AS username
   , COUNT(*) AS username_count
--   , first_name 
--   , last_name
--   , birth_date
FROM employees
GROUP BY username -- , first_name, last_name, birth_date
HAVING username_count > 1
ORDER BY username_count DESC
;
-- YES, more than 1000 usernames are not distinct
-- Bonus below (with subquery), 13251 non-unique usernames
SELECT COUNT(username) 
FROM (
SELECT LOWER ( 
         CONCAT (
             SUBSTR(first_name, 1, 1) -- first char of first name
           , SUBSTR(last_name, 1, 4)  -- first 4 chars of last name
           , '_'
           , SUBSTR(birth_date, 6, 2) -- 2-digit month
           , SUBSTR(birth_date, 3, 2) -- 2-digit year
                )
			) AS username
   , COUNT(*) AS username_count
--   , first_name 
--   , last_name
--   , birth_date
FROM employees
GROUP BY username -- , first_name, last_name, birth_date
HAVING username_count > 1
ORDER BY username_count DESC
  ) AS count_non_unique
;
