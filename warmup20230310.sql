-- Friday 10 March AM Warmup
-- using the chipotle database,
-- find how many times someone ordered a chicken or veggie bowl
-- with a quantity greater than 1
SHOW databases;
USE chipotle;
SHOW tables;
SELECT *
FROM orders
WHERE (item_name LIKE '%chicken bowl%' -- forgot the bowl the first time. dangit
    OR item_name LIKE '%veggie bowl%') -- " "
    AND quantity > 1
;

