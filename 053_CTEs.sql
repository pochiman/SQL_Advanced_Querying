-- ASSIGNMENT 4: CTEs

-- View the orders and products tables
SELECT * FROM orders;
SELECT * FROM products;

-- Calculate the amount spent on each product, within each order
SELECT	o.order_id, o.product_id, o.units, p.unit_price,
		o.units * p.unit_price AS amount_spent
FROM	orders o LEFT JOIN products p
		ON o.product_id = p.product_id;

-- Return all orders over $200
SELECT	 o.order_id,
		 SUM(o.units * p.unit_price) AS total_amount_spent
FROM	 orders o LEFT JOIN products p
		 ON o.product_id = p.product_id
GROUP BY o.order_id
HAVING   total_amount_spent > 200
ORDER BY total_amount_spent DESC;

-- Return the number of orders over $200
WITH tas AS (SELECT	 o.order_id,
					 SUM(o.units * p.unit_price) AS total_amount_spent
			 FROM	 orders o LEFT JOIN products p
					 ON o.product_id = p.product_id
			 GROUP BY o.order_id
			 HAVING   total_amount_spent > 200
			 ORDER BY total_amount_spent DESC)
			
			/* This ORDER BY clause in the CTE doesn't affect the final output
			   and can be removed to make the code run more efficiently */
             
SELECT	COUNT(*)
FROM	tas;