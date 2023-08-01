-- use the chipotle database
-- 1. find the average price someone spends on a chicken bowl
-- regardless of how many bowls they order

use chipotle;
SELECT *
FROM orders;

SELECT quantity, item_name, CAST(REPLACE(item_price, '$', '') AS FLOAT) as item_price
FROM orders;

SELECT *
FROM orders
WHERE item_name = 'Chicken Bowl';

SELECT item_name, ROUND(AVG(item_price),2) AS avg_item_price
FROM (
	SELECT quantity, item_name, CAST(REPLACE(item_price, '$', '') AS FLOAT) as item_price
	FROM orders
    ) as sq
WHERE item_name = 'Chicken Bowl'
GROUP BY item_name;

-- 2. now find out what the average price for a chicken bowl is,
-- based on the quantity of chicken bowls.
-- round your final answer to two decimals and sort by price.


SELECT quantity, item_name, ROUND(AVG(item_price),2) AS avg_item_price
FROM (
	SELECT quantity, item_name, CAST(REPLACE(item_price, '$', '') AS FLOAT) as item_price
	FROM orders
    ) as sq
WHERE item_name = 'Chicken Bowl'
GROUP BY quantity
ORDER BY quantity
;

-- 3. based on the overall average spent and the average spent by quantity,
-- what can you infer about how many quantities people are typically ordering?

-- Most people are only ordering quantity 1 since the overall average is 10.11
-- which is relatively close to the quantity 1 average of 9.67

SELECT *
FROM orders
WHERE item_name LIKE ('%Chicken%');