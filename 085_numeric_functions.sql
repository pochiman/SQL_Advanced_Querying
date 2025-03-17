-- Connect to database (MySQL)
USE maven_advanced_sql;

-- ASSIGNMENT 1: Numeric functions

-- Calculate the total spend for each customer
SELECT o.customer_id, o.product_id, o.units
FROM orders o;

SELECT p.product_id, p.unit_price
FROM products p;

SELECT	o.customer_id, SUM(o.units * p.unit_price) AS total_spend
FROM	orders o LEFT JOIN products p
		ON o.product_id = p.product_id
GROUP BY o.customer_id;

-- Put the spend into bins of $0-$10, $10-20, etc.
SELECT	o.customer_id,
		SUM(o.units * p.unit_price) AS total_spend,
        FLOOR(SUM(o.units * p.unit_price) / 10) * 10 AS total_spend_bin
FROM	orders o LEFT JOIN products p
		ON o.product_id = p.product_id
GROUP BY o.customer_id;

-- Number of customers in each spend bin
WITH bin AS (SELECT	o.customer_id,
					SUM(o.units * p.unit_price) AS total_spend,
					FLOOR(SUM(o.units * p.unit_price) / 10) * 10 AS total_spend_bin
			 FROM	orders o LEFT JOIN products p
					ON o.product_id = p.product_id
			 GROUP BY o.customer_id)
             
SELECT	 total_spend_bin, COUNT(customer_id) AS num_customers
FROM	 bin
GROUP BY total_spend_bin
ORDER BY total_spend_bin;