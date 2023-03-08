SHOW DATABASES;
USE albums_db;
select database();
show tables;
use employees;
show tables;
show create table employees;
/* 
CREATE TABLE `employees` (
  `emp_no` int NOT NULL,
  `birth_date` date NOT NULL,
  `first_name` varchar(14) NOT NULL,
  `last_name` varchar(16) NOT NULL,
  `gender` enum('M','F') NOT NULL,
  `hire_date` date NOT NULL,
  PRIMARY KEY (`emp_no`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1
*/
/*
Which table(s) do you think contain a numeric type column?
- emp_no
Which table(s) do you think contain a string type column? 
- first_name, last_name, gender?
Which table(s) do you think contain a date type column?
- birth_date, hire_date
What is the relationship between the employees and the departments tables?
- It looks like the dept_emp table combines the emp_no from 
- employees and the dept_no from departments (probably 
- assigning a dept_no to each emp_no).
*/
show tables;
show create table dept_manager;
/*
CREATE TABLE `dept_manager` (
  `emp_no` int NOT NULL,
  `dept_no` char(4) NOT NULL,
  `from_date` date NOT NULL,
  `to_date` date NOT NULL,
  PRIMARY KEY (`emp_no`,`dept_no`),
  KEY `dept_no` (`dept_no`),
  CONSTRAINT `dept_manager_ibfk_1` FOREIGN KEY (`emp_no`) REFERENCES `employees` (`emp_no`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `dept_manager_ibfk_2` FOREIGN KEY (`dept_no`) REFERENCES `departments` (`dept_no`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=latin1
*/
