-- case_exercises.sql

   -- 1. Write a query that returns all employees, their department number, their start date, their end date, 
   -- and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.
USE employees;
-- Below query has repeated names. Would need to get first from_date and last to_date of
-- name and dept number of last to_date
SELECT e.emp_no, d.dept_no
   , e.first_name
   , e.last_name
   , e.hire_date AS start_date
   , de.to_date AS end_date
   , IF (de.to_date = '9999-01-01', True, False) AS is_current_employee
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
ORDER BY e.emp_no
;
/* Attemptd to remove duplicates (and failed)

-- Below query counts duplicate names. Used to get investigate data.  Result:
-- there are lots of people with the same first name and last name that are ins
-- this database, i.e. the same name can have multiple rows. Sometimes the 
-- emp_no is the same and sometimes it's a different person. The main reason
-- is that some employees have switched departments.
SELECT CONCAT (e.first_name, ' ', e.last_name) AS full_name
   , COUNT(*) AS cnt_dupes
--    , IF (de.to_date = '9999-01-01', True, False) AS is_current_employee
FROM employees AS e
JOIN dept_emp AS de ON e.emp_no = de.emp_no
JOIN departments AS d ON d.dept_no = de.dept_no
GROUP BY full_name
ORDER BY cnt_dupes DESC
;
SELECT * FROM employees JOIN dept_emp USING (emp_no) WHERE first_name = 'Stafford' AND last_name = 'Kopetz';
*/

-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' 
-- that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.
-- Might be some nulls in query below. Can check later
SELECT e.first_name, e.last_name
, CASE
    WHEN SUBSTR(e.last_name, 1, 1) >= 'R' THEN 'R-Z'
    WHEN SUBSTR(e.last_name, 1, 1) >= 'I' THEN 'I-Q'
    WHEN SUBSTR(e.last_name, 1, 1) >= 'A' THEN 'A-H'
  END AS alpha_group
FROM employees AS e
;   
   
-- 3. How many employees (current or previous) were born in each decade?
-- Also has duplicate names to take out. I think I got 'em on this one.

SELECT birth_decade, COUNT(birth_decade) AS cnt_birth_decade
FROM (
	SELECT *
	, CASE
		WHEN SUBSTR(e.bday_plus_name, 1, 10) <= '1959-12-31' THEN '1950s'
		WHEN SUBSTR(e.bday_plus_name, 1, 10) <= '1969-12-31' THEN '1960s'
		ELSE 'Gen X/Y/Millenial'
	  END AS birth_decade
	FROM (
		SELECT bday_plus_name, COUNT(bday_plus_name) AS cnt_bday_plus_name
		FROM (
			SELECT *, CONCAT(e.birth_date, e.first_name, e.last_name) AS bday_plus_name
				, CASE
					WHEN e.birth_date <= '1959-12-31' THEN '1950s'
					WHEN e.birth_date <= '1969-12-31' THEN '1960s'
					ELSE 'Gen X/Y/Millenial'
				  END AS birth_decade
			FROM employees AS e
			) AS bdayname_table
		GROUP BY bday_plus_name
		) AS e
	) AS bd_table
GROUP BY birth_decade
;

SELECT * FROM employees WHERE first_name = 'Pintsang' AND last_name = 'Granlund';

/* -- This code helped me figure out where there were duplicate names by making a 
   column I called bday_plus_name. I grouped by that column. That table then had 
   unique descriptors for unique people rather than having some people counted
   twice.  This became a subquery in the code above.
   */
SELECT bday_plus_name, COUNT(bday_plus_name) AS cnt_bday_plus_name
FROM (
	SELECT *, CONCAT(e.birth_date, e.first_name, e.last_name) AS bday_plus_name
		, CASE
			WHEN e.birth_date <= '1959-12-31' THEN '1950s'
			WHEN e.birth_date <= '1969-12-31' THEN '1960s'
			ELSE 'Gen X/Y/Millenial'
		  END AS birth_decade
		FROM employees AS e
	  ) AS bdayname_table
GROUP BY bday_plus_name
ORDER BY cnt_bday_plus_name DESC
;

-- 4. What is the current average salary for each of the following department groups: 
-- R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT 
  CASE 
     WHEN d.dept_name IN ('Research', 'Development') THEN 'R&D' -- could have used IN to make it shorter
     WHEN d.dept_name = 'Sales' OR d.dept_name = 'Marketing' THEN 'Sales & Marketing'
     WHEN d.dept_name = 'Productiion' OR d.dept_name = 'Quality Management' THEN 'Prod & QM'
     WHEN d.dept_name = 'Finance' OR d.dept_name = 'Human Resources' THEN 'Finance & HR'
     ELSE 'Customer Service'
  END AS dept_group
  , AVG(s.salary) AS avg_salary
FROM salaries AS s
JOIN dept_emp AS de ON s.emp_no = de.emp_no
JOIN departments AS d ON de.dept_no = d.dept_no
WHERE s.to_date > CURDATE()  AND de.to_date > CURDATE()
GROUP BY dept_group
;
