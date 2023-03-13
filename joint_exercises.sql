-- joint_exercises.sql

USE join_example_db;
show tables;
select * from roles;
select * from users;

-- 2. play with join, left join, right join
SELECT *
FROM users AS u
RIGHT JOIN roles AS r ON u.role_id = r.id;

-- 3. how many users of each role_id are there? 
-- nn_cnt is correct because it does not count the null row where as the 
-- COUNT(*) does count the null row
SELECT r.name, COUNT(*) AS cnt_of_users, SUM(!ISNULL(u.role_id)) AS nn_cnt
FROM users AS u
RIGHT JOIN roles AS r ON u.role_id = r.id
GROUP BY r.id;

-- Employees Database questions

USE employees;
SHOW tables;

-- 2. write a query that shows each dept along with the name of the current
-- manager for that dept
SELECT * FROM dept_manager;

SELECT d.dept_name AS Dept_Name, CONCAT(e.first_name, ' ', e.last_name) AS Dept_Manager
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments as d
  ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01'
ORDER BY Dept_Name
;
-- 3. Find the name of all departments currenty managed by women
SELECT d.dept_name AS Dept_Name, CONCAT(e.first_name, ' ', e.last_name) AS Dept_Manager
FROM employees AS e
JOIN dept_manager AS dm
  ON dm.emp_no = e.emp_no
JOIN departments as d
  ON d.dept_no = dm.dept_no
WHERE dm.to_date = '9999-01-01'
  AND e.gender = 'F'
ORDER BY Dept_Name
;
-- 4. Find current titles of employees currently working in Customer Service
SELECT * FROM departments;

SELECT t.title, COUNT(e.emp_no) AS cnt_of_titles_in_cs
FROM titles as t
JOIN employees as e
  ON t.emp_no = e.emp_no
JOIN dept_emp AS de
  ON de.emp_no = e.emp_no
JOIN departments AS d
  ON de.dept_no = d.dept_no
  WHERE (de.to_date > NOW()) 
    AND t.to_date > NOW()
    AND (d.dept_name = 'Customer Service')
GROUP BY t.title
ORDER BY t.title
;

-- 5. Find the current salary of all current managers
SELECT *
FROM salaries
;
SELECT *
FROM dept_manager
;

SELECT d.dept_name AS Department_Name
  ,  CONCAT(e.first_name, ' ', e.last_name) AS Name
  , s.salary AS Salary
FROM departments AS d
JOIN dept_manager AS dm
  ON d.dept_no = dm.dept_no
JOIN salaries AS s
  ON dm.emp_no = s.emp_no 
JOIN employees as e
  ON dm.emp_no = e.emp_no
WHERE dm.to_date > NOW() 
  AND s.to_date > NOW()
ORDER BY Department_Name
;
-- 6. Find number of current employees in each department
SELECT d.dept_no
 , d.dept_name 
 , COUNT(e.emp_no) as num_employees
FROM dept_emp AS de
JOIN departments AS d
  ON de.dept_no = d.dept_no
JOIN employees AS e
  ON de.emp_no = e.emp_no
WHERE de.to_date > NOW()
GROUP BY d.dept_no
;
-- 7. Which department has the highest average salary (use current, 
-- not historic information

SELECT d.dept_name, AVG(s.salary) AS avg_salary
FROM salaries AS s
  JOIN dept_emp AS de
    ON s.emp_no = de.emp_no
  JOIN departments AS d
    ON d.dept_no = de.dept_no
WHERE de.to_date > NOW()
   AND s.to_date > NOW()    
GROUP BY d.dept_name    
ORDER BY avg_salary DESC
;

-- 8. Who is the highest paid employee in the Marketing department?

SELECT s.salary,
  CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM salaries AS s
  JOIN dept_emp AS de
    ON de.emp_no = s.emp_no
  JOIN departments AS d
    ON d.dept_no = de.dept_no
  JOIN employees AS e
    ON e.emp_no = de.emp_no
WHERE s.to_date > NOW()
  AND d.dept_name = 'Marketing'
ORDER BY s.salary DESC 
;

-- 9. Which current dept manager has the highest salary?

SELECT d.dept_name, e.first_name, e.last_name, dm.emp_no, s.salary
FROM salaries AS s
  JOIN dept_manager AS dm
    ON s.emp_no = dm.emp_no
  JOIN departments AS d
    ON dm.dept_no = d.dept_no
  JOIN employees AS e
    ON dm.emp_no = e.emp_no
WHERE s.to_date > NOW() 
  AND dm.to_date > NOW()
ORDER BY s.salary DESC
;

-- 10. Determine the average salary for each dept. Use all salary info; round.
SELECT de.dept_no, d.dept_name, ROUND(AVG(s.salary),0) AS avg_salary
FROM salaries AS s
  JOIN dept_emp AS de
	ON s.emp_no = de.emp_no
  JOIN departments AS d
    ON de.dept_no = d.dept_no
  GROUP BY de.dept_no  
  ORDER BY avg_salary DESC
;

-- 11. Bonus; Find names of all current employees, dept name, and
-- their current manager's name

SELECT combine.empl_no, combine.full_name, combine.deprt_no
, combine.deprt_name, combine.dm_empl_no
, CONCAT(e.first_name, ' ', e.last_name) AS mngr_name
FROM (

SELECT de.emp_no AS empl_no, CONCAT(e.first_name, ' ', e.last_name) AS full_name
  , de.dept_no AS deprt_no, d.dept_name AS deprt_name, dm.emp_no AS dm_empl_no
FROM employees AS e
  JOIN dept_emp AS de
    ON e.emp_no = de.emp_no
  JOIN departments AS d
    ON de.dept_no = d.dept_no
  JOIN dept_manager AS dm
   ON dm.dept_no = d.dept_no
WHERE de.to_date > NOW()
  AND dm.to_date > NOW()
      ) AS combine

JOIN employees AS e
  ON combine.dm_empl_no = e.emp_no
ORDER BY combine.deprt_name, combine.empl_no
;

-- 12. Bonus, Who is highest paid employee within each dept?

SELECT combine.deprt_name, combine.max_salary 
  , s.emp_no AS empl_no
  , CONCAT(e.first_name, ' ', e.last_name) AS full_name
FROM (
SELECT d.dept_name AS deprt_name, MAX(s.salary) AS max_salary
FROM employees AS e
JOIN salaries AS s
  ON e.emp_no = s.emp_no
JOIN dept_emp AS de
  ON s.emp_no = de.emp_no
JOIN departments AS d
  ON de.dept_no = d.dept_no
WHERE s.to_date > NOW()
GROUP BY d.dept_name
ORDER BY max_salary DESC
      ) AS combine
JOIN salaries AS s
  ON s.salary = combine.max_salary
JOIN employees AS e
  ON s.emp_no = e.emp_no
WHERE s.to_date > NOW()  
ORDER BY combine.max_salary
;
-- Below is a test I used to figure out I had one max salary
-- repeated that was for a non-current employee.
-- Then I fixed it above with a second "WHERE s.to_date > NOW()"
-- outside of the subquery
SELECT *
FROM salaries AS s
JOIN employees AS e
  ON s.emp_no = e.emp_no
WHERE salary = 138273
;