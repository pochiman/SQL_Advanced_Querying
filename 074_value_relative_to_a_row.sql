-- ASSIGNMENT 4: Lead & Lag

-- View the columns of interest
SELECT	customer_id, order_id, product_id, transaction_id, order_date, units
FROM	orders;

-- For each customer, return the total units within each order
SELECT	 customer_id, order_id, SUM(units) AS total_units
FROM	 orders
GROUP BY customer_id, order_id
ORDER BY customer_id;

-- Add on the transaction id to keep track of the order of the orders
SELECT	 customer_id, order_id, MIN(transaction_id) min_tid, SUM(units) AS total_units
FROM	 orders
GROUP BY customer_id, order_id
ORDER BY customer_id, min_tid;

-- Turn the query into a CTE and view the columns of interest
WITH my_cte AS (SELECT	 customer_id, order_id, MIN(transaction_id) min_tid, SUM(units) AS total_units
				FROM	 orders
				GROUP BY customer_id, order_id
				ORDER BY customer_id, min_tid)
                
SELECT	customer_id, order_id, total_units
FROM	my_cte;

-- Create a prior units column
WITH my_cte AS (SELECT	 customer_id, order_id, MIN(transaction_id) min_tid, SUM(units) AS total_units
				FROM	 orders
				GROUP BY customer_id, order_id
				ORDER BY customer_id, min_tid)
                
SELECT	customer_id, order_id, total_units,
		LAG(total_units) OVER(PARTITION BY customer_id ORDER BY min_tid) AS prior_units
FROM	my_cte;

-- For each customer, find the change in units per order over time

-- APPROACH 1: One CTE - more concise approach
WITH my_cte AS (SELECT	 customer_id, order_id, MIN(transaction_id) AS min_tid, SUM(units) AS total_units
				FROM	 orders
				GROUP BY customer_id, order_id
				ORDER BY customer_id, min_tid) -- ORDER BY in CTE is not needed and can be omitted
                
SELECT	customer_id, order_id, total_units,
		LAG(total_units) OVER(PARTITION BY customer_id ORDER BY min_tid) AS prior_units,
        total_units - LAG(total_units) OVER(PARTITION BY customer_id ORDER BY min_tid)
FROM	my_cte;

-- APPROACH 2: Multiple CTEs - step-by-step approach
WITH my_cte AS (SELECT	 customer_id, order_id, MIN(transaction_id) min_tid, SUM(units) AS total_units
				FROM	 orders
				GROUP BY customer_id, order_id
				ORDER BY customer_id, min_tid), -- ORDER BY in CTE is not needed and can be omitted
                
	 prior_cte AS (SELECT	customer_id, order_id, total_units,
							LAG(total_units) OVER(PARTITION BY customer_id ORDER BY min_tid) AS prior_units
				   FROM		my_cte)
                
SELECT	customer_id, order_id, total_units, prior_units,
		total_units - prior_units AS diff_units
FROM	prior_cte;