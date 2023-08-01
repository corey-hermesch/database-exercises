use mall_customers;

SELECT * 
FROM customers
ORDER BY spending_score
;

SELECT avg(spending_score)
FROM customers
;

SELECT gender, COUNT(gender)
FROM customers
WHERE spending_score > (SELECT avg(spending_score) FROM customers)
GROUP BY gender;

SELECT gender, COUNT(gender)
FROM customers
GROUP BY gender;
