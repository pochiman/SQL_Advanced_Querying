-- ASSIGNMENT 5: NTILE

-- Calculate the total amount spent by each customer

-- View the data needed from the orders table
SELECT	customer_id, product_id, units
FROM	orders;

-- View the data needed from the products table
SELECT	product_id, unit_price
FROM	products;

-- Combine the two tables and view the columns of interest
SELECT	o.customer_id, o.product_id, o.units, p.unit_price
FROM	orders o LEFT JOIN products p
		ON o.product_id = p.product_id;
        
-- Calculate the total spending by each customer and sort the results from highest to lowest
SELECT	o.customer_id, SUM(o.units * p.unit_price) AS total_spend
FROM	orders o LEFT JOIN products p
		ON o.product_id = p.product_id
GROUP BY o.customer_id
ORDER BY total_spend DESC;

-- Turn the query into a CTE and apply the percentile calculation
WITH ts AS (SELECT	o.customer_id, SUM(o.units * p.unit_price) AS total_spend
			FROM	orders o LEFT JOIN products p
					ON o.product_id = p.product_id
			GROUP BY o.customer_id
			ORDER BY total_spend DESC)
            
SELECT	customer_id, total_spend,
		NTILE(100) OVER(ORDER BY total_spend DESC) AS spend_pct
FROM	ts;

-- Return the top 1% of customers in terms of spending
WITH ts AS (SELECT	o.customer_id, SUM(o.units * p.unit_price) AS total_spend
			FROM	orders o LEFT JOIN products p
					ON o.product_id = p.product_id
			GROUP BY o.customer_id
			ORDER BY total_spend DESC), -- ORDER BY in CTE is not needed and can be omitted
            
	 sp AS (SELECT	customer_id, total_spend,
					NTILE(100) OVER(ORDER BY total_spend DESC) AS spend_pct
			FROM	ts)
            
SELECT	*
FROM	sp
WHERE	spend_pct = 1;