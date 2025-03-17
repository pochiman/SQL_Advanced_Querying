-- ASSIGNMENT 2: Subqueries in the FROM clause

-- Return the factories, product names from the factory
-- and number of products produced by each factory

-- All factories and products
SELECT	factory, product_name
FROM	products;

-- All factories and their total number of products
SELECT	 factory, COUNT(product_id) AS num_products
FROM	 products
GROUP BY factory;

-- Final query with subqueries
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