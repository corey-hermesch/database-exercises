# Investigate telco_churn database
USE telco_churn;
SELECT *
FROM customers;
SELECT *
FROM customer_payments;
SELECT *
FROM contract_types;
SELECT *
FROM customer_contracts;
SELECT *
FROM customer_subscriptions;
SELECT *
FROM internet_service_types;
SELECT *
FROM payment_types;
SELECT *
FROM customer_churn;

# Get the monthly average customers pay
SELECT AVG(monthly_charges) FROM customers;

# Get the number of users who pay more than the monthly average
SELECT c.customer_id, c.monthly_charges 
FROM customers AS c
WHERE c.monthly_charges > (
	SELECT AVG(monthly_charges) FROM customers
    )
;   

# Now get the percentage of customers that pay more than the monthly average
SELECT COUNT(customer_id) / (
	SELECT COUNT(customer_id) FROM customers
    )
FROM customers
WHERE monthly_charges > (
	SELECT AVG(monthly_charges) FROM customers
    )
;
