SHOW databases;
use employees;
describe employees;
describe authors;
select database();
show tables;
show create table authors;
describe authors;
describe departments;
SELECT * FROM departments;
select * from dept_emp;

-- creating a table in my personal database to play with indices

use pagel_2179;
show tables;
CREATE TABLE teams (
   id INT NOT NULL AUTO_INCREMENT,
   school_name VARCHAR(100) NOT NULL,
   abbr_name VARCHAR (20) NOT NULL,
   mascot VARCHAR (100) NOT NULL,
   ranking INT NOT NULL,
   PRIMARY KEY (id)
);
DESCRIBE teams;
ALTER TABLE teams 
  ADD UNIQUE (ranking);
SHOW tables;
INSERT INTO teams (school_name, abbr_name, mascot, ranking)
   VALUES ('Kansas', 'KU', 'Jahawks', 1);
describe teams;
select * from teams;
UPDATE teams
   SET mascot = 'Jayhawks'
   WHERE id = 1;
-- Done playing with indices and creating and altering and updating a table

USE employees;
SELECT * FROM quotes;
DESCRIBE quotes;
DESCRIBE titles;

