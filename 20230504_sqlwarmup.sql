use pizza;
-- Find the price of each order, given each pizza has varied toppings/crust/size

SELECT *
FROM pizzas AS p
JOIN sizes AS s USING (size_id)
JOIN pizza_toppings AS pt USING (pizza_id)
JOIN toppings AS t USING (topping_id)
JOIN pizza_modifiers AS pm USING (pizza_id)
JOIN modifiers AS m USING (modifier_id)
;

