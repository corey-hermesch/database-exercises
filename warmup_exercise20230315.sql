-- warmup SQL exercise for the Ides of March
-- Using the customer table from sakila database,
-- find the number of active and inactive users

USE sakila;
SELECT *
FROM customer
;
DESCRIBE customer;

SELECT COUNT(c.active) AS num_users, 
   IF (c.active, 'Active', 'Inactive') AS is_active 
FROM customer AS c
GROUP BY is_active
;

