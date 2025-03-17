-- ASSIGNMENT 3: First Value vs Last Value vs Nth Value

-- View the rankings from the last assignment
SELECT	order_id, product_id, units,
		DENSE_RANK() OVER(PARTITION BY order_id ORDER BY units DESC) AS product_rank
FROM	orders
ORDER BY order_id, product_rank;

-- Add a column that contains the 2nd most popular product
-- EDIT: This NTH_VALUE solution doesn't account for ties and returns inaccurate values. The DENSE_RANK solution below is the correct one.
SELECT	order_id, product_id, units,
		NTH_VALUE(product_id, 2) OVER(PARTITION BY order_id ORDER BY units DESC) AS second_product
FROM	orders
ORDER BY order_id, second_product;

-- Return the 2nd most popular product for each order
-- EDIT: This NTH_VALUE solution doesn't account for ties and returns inaccurate values. The DENSE_RANK solution below is the correct one.
SELECT * FROM

(SELECT	order_id, product_id, units,
		NTH_VALUE(product_id, 2) OVER(PARTITION BY order_id ORDER BY units DESC) AS second_product
FROM	orders
ORDER BY order_id, second_product) AS sp -- ORDER BY in subquery is not needed and can be omitted

WHERE product_id = second_product;

-- Alternative using DENSE RANK

-- Add a column that contains the rankings (this DENSE_RANK solution 
SELECT	order_id, product_id, units,
		DENSE_RANK() OVER(PARTITION BY order_id ORDER BY units DESC) AS product_rank
FROM	orders
ORDER BY order_id, product_rank;

-- Return the 2nd most popular product for each order
SELECT * FROM

(SELECT	order_id, product_id, units,
		DENSE_RANK() OVER(PARTITION BY order_id ORDER BY units DESC) AS product_rank
FROM	orders
ORDER BY order_id, product_rank) AS pr -- ORDER BY in subquery is not needed and can be omitted

WHERE product_rank = 2;