-- ASSIGNMENT 2: Row Number vs Rank vs Dense Rank

-- View the columns of interest
SELECT	order_id, product_id, units
FROM	orders;

-- Try ROW_NUMBER to rank the units
SELECT	order_id, product_id, units,
		ROW_NUMBER() OVER(PARTITION BY order_id ORDER BY units DESC) AS product_rn
FROM	orders
ORDER BY order_id, product_rn;

-- For each order, rank the products from most units to fewest units
-- If there's a tie, keep the tie and don't skip to the next number after
SELECT	order_id, product_id, units,
		DENSE_RANK() OVER(PARTITION BY order_id ORDER BY units DESC) AS product_rank
FROM	orders
ORDER BY order_id, product_rank;

-- Check the order id that ends with 44262 from the results preview
SELECT	order_id, product_id, units,
		DENSE_RANK() OVER(PARTITION BY order_id ORDER BY units DESC) AS product_rank
FROM	orders
WHERE	order_id LIKE '%44262'
ORDER BY order_id, product_rank;