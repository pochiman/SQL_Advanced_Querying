-- Connect to database (MySQL)
USE maven_advanced_sql;

-- ASSIGNMENT 1: Subqueries in the SELECT clause

-- View the products table
SELECT * FROM products;

-- View the average unit price
SELECT AVG(unit_price) FROM products;

-- Return the product id, product name, unit price, average unit price,
-- and the difference between each unit price and the average unit price
SELECT	product_id, product_name, unit_price,
		(SELECT AVG(unit_price) FROM products) AS avg_unit_price,
        unit_price - (SELECT AVG(unit_price) FROM products) AS diff_price
FROM	products;

-- Order the results from most to least expensive
SELECT	 product_id, product_name, unit_price,
		 (SELECT AVG(unit_price) FROM products) AS avg_unit_price,
         unit_price - (SELECT AVG(unit_price) FROM products) AS diff_price
FROM	 products
ORDER BY unit_price DESC;