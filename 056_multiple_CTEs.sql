-- ASSIGNMENT 5: Multiple CTEs

-- Copy over Assignment 2 (Subqueries in the FROM clause) solution
SELECT	fp.factory, fp.product_name, fn.num_products
FROM

(SELECT	factory, product_name
FROM	products) fp

LEFT JOIN

(SELECT	 factory, COUNT(product_id) AS num_products
FROM	 products
GROUP BY factory) fn

ON fp.factory = fn.factory
ORDER BY fp.factory, fp.product_name;

-- Rewrite the Assignment 2 subquery solution using CTEs instead
WITH fp AS (SELECT factory, product_name FROM products),
	 fn AS (SELECT	 factory, COUNT(product_id) AS num_products
			FROM	 products
			GROUP BY factory)

SELECT	fp.factory, fp.product_name, fn.num_products
FROM	fp LEFT JOIN fn
		ON fp.factory = fn.factory
ORDER BY fp.factory, fp.product_name;