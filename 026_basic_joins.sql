-- Connect to database (MySQL)
USE maven_advanced_sql;

-- ASSIGNMENT 1: Basic Joins
-- Looking at the orders and products tables, which products exist in one table, but not the other?


-- View the orders and products tables
SELECT * FROM orders;
SELECT * FROM products;

SELECT COUNT(DISTINCT product_id) FROM orders;
SELECT COUNT(DISTINCT product_id) FROM products;

-- Join the tables using various join types & note the number of rows in the output
SELECT	COUNT(*)
FROM	orders o LEFT JOIN products p
		ON o.product_id = p.product_id; -- 8549
        
SELECT	COUNT(*)
FROM	orders o RIGHT JOIN products p
		ON o.product_id = p.product_id; -- 8552
        
-- View the products that exist in one table, but not the other
SELECT	*
FROM	orders o LEFT JOIN products p
		ON o.product_id = p.product_id
WHERE	p.product_id IS NULL;
        
SELECT	*
FROM	orders o RIGHT JOIN products p
		ON o.product_id = p.product_id
WHERE	o.product_id IS NULL; -- Customers haven't ordered these products yet

-- Use a LEFT JOIN to join products and orders
SELECT	p.product_id, p.product_name,
		o.product_id AS product_id_in_orders
FROM	products p LEFT JOIN orders o
		ON p.product_id = o.product_id
WHERE	o.product_id IS NULL;