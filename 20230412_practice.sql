use superstore_db;
#investigate the superstore database

select * from departments
order by division
;

# I want to answer two questions:
# First, What are the number of distinct products by category and sub_category?

# Attempting to join up orders with categories
SELECT `Product ID` as product_id
		, Sales as sales
        , Quantity as qty
        , Discount as discount
        , Profit as profit
        , `Category ID` as category_id
FROM orders
JOIN (
		SELECT `Category ID` as category_id
				, Category as category
				, `Sub-Category` as sub_category
		FROM categories
	) as cats ON orders.`Category ID` = cats.`Category_ID`
;

# further attempts to join up orders with categories
SELECT `Product ID` as product_id
		, Sales as sales
        , Quantity as qty
        , Discount as discount
        , Profit as profit
        , orders.`Category ID` as category_id
        , Category as category
        , `Sub-Category` as sub_category
FROM orders
LEFT JOIN categories on orders.`Category ID` = categories.`Category ID`
;

# This query gives me the number of products, but it has repeated product_id's
SELECT category, COUNT(category) as num_products
FROM (
		SELECT `Product ID` as product_id
				, Sales as sales
				, Quantity as qty
				, Discount as discount
				, Profit as profit
				, orders.`Category ID` as category_id
				, Category as category
				, `Sub-Category` as sub_category
		FROM orders
		LEFT JOIN categories on orders.`Category ID` = categories.`Category ID`
	) as q
GROUP BY category
;

# Are any product_id's repeated? -- YES, so we have to modify the query above (copied below)
# Now the query will give me the unique product_ids and the number of times they are repeated
# in orders
SELECT product_id, COUNT(product_id) as cnt_prod_id
FROM (
		SELECT `Product ID` as product_id
				, Sales as sales
				, Quantity as qty
				, Discount as discount
				, Profit as profit
				, orders.`Category ID` as category_id
				, Category as category
				, `Sub-Category` as sub_category
		FROM orders
		LEFT JOIN categories on orders.`Category ID` = categories.`Category ID`
	) as q
GROUP BY product_id
ORDER BY cnt_prod_id DESC
;

# shorter code to get the same thing
### Aside: lots of work figuring out how to deal with column names that have spaces       
SELECT DISTINCT `Product ID` as product_id, COUNT(`Product ID`) AS cnt_prod_id
FROM orders
GROUP BY product_id
ORDER BY cnt_prod_id DESC
;

SELECT DISTINCT `Product ID` as product_id, `Category ID` as category_id
FROM orders
;

# Below gives me the total number of unique product ids (1112)
SELECT COUNT(*) FROM(
SELECT DISTINCT `Product ID` as product_id, `Category ID` as category_id
FROM orders) AS q
;

# Below gives me the total number of product_id's (1734) which is > the num above which makes sense
SELECT count(`Product ID`) FROM orders;

# Query to get unique product ids with their categories and sub categories
SELECT * 
FROM	(
		SELECT DISTINCT `Product ID` as product_id, `Category ID` as category_id
		FROM orders
		) AS q
JOIN categories on q.category_id = `Category ID`
;

# Finally, this is the correct query to display the number of products sold in each sub-category
# (replace Sub-Category with Category to get num of products in each Category
SELECT `Sub-Category`, COUNT(`Sub-Category`) as num_products
FROM 	(
		SELECT * 
		FROM	(
				SELECT DISTINCT `Product ID` as product_id, `Category ID` as category_id
				FROM orders
				) AS q
		JOIN categories on q.category_id = `Category ID`
        ) AS qq
GROUP BY `Sub-Category`
;

# Now to get total sales for each Category

SELECT Sales, Profit, orders.`Category ID` as category_id, Category as category, `Sub-Category` as sub_category
FROM orders
LEFT JOIN categories on orders.`Category ID` = categories.`Category ID`
;

# Here is the query for total sales and total profit by category
SELECT category, SUM(Sales) as total_sales, SUM(Profit) as total_profit
FROM 	(
		SELECT Sales
			, Profit
			, orders.`Category ID` as category_id
			, Category as category
			, `Sub-Category` as sub_category
		FROM orders
		LEFT JOIN categories on orders.`Category ID` = categories.`Category ID`
        ) AS q
GROUP BY category
;

# Here is the query for total sales and total profit by sub_category
SELECT sub_category, ROUND(SUM(Sales)) as total_sales, ROUND(SUM(Profit)) as total_profit
FROM 	(
		SELECT Sales
			, Profit
			, orders.`Category ID` as category_id
			, Category as category
			, `Sub-Category` as sub_category
		FROM orders
		LEFT JOIN categories on orders.`Category ID` = categories.`Category ID`
        ) AS q
GROUP BY sub_category
;

SELECT Category, sub_category, total_sales, total_profit
FROM 	(
		SELECT sub_category, ROUND(SUM(Sales)) as total_sales, ROUND(SUM(Profit)) as total_profit
		FROM 	(
				SELECT Sales
					, Profit
					, orders.`Category ID` as category_id
					, Category as category
					, `Sub-Category` as sub_category
				FROM orders
				LEFT JOIN categories on orders.`Category ID` = categories.`Category ID`
				) AS q
		GROUP BY sub_category
        ) AS qq
LEFT JOIN categories on qq.sub_category = categories.`Sub-Category`
ORDER BY Category
;
