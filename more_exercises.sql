SHOW databases;
USE sakila;
SHOW tables;
-- 1. select some columns from actor table
SELECT *
FROM actor
;

SELECT last_name
FROM actor
;

SELECT film_id, title, release_year
FROM film
;

-- 2. DISTINCT operator

SELECT DISTINCT last_name
FROM actor
;

SELECT DISTINCT postal_code
FROM address
;

-- 3. WHERE clause

SELECT title, description, rating, length
FROM film
WHERE length >= 180
;

SELECT payment_id, amount, payment_date
FROM payment
WHERE payment_date >= '2005-05-27'
;

-- 3c next
SHOW CREATE TABLE payment;

SELECT *
FROM payment
;