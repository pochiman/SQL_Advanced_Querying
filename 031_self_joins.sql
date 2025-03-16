-- ASSIGNMENT 2: Self Joins
-- Which products are within 25 cents of each other in terms of unit price?


-- View the products table
SELECT * FROM products;

-- Join the products table with itself so each candy is paired with a different candy
SELECT	p1.product_name, p1.unit_price,
		p2.product_name, p2.unit_price
FROM	products p1 INNER JOIN products p2
		ON p1.product_id <> p2.product_id;
        
-- Calculate the price difference, do a self join, and then return only price differences under 25 cents
SELECT	p1.product_name, p1.unit_price,
		p2.product_name, p2.unit_price,
        p1.unit_price - p2.unit_price AS price_diff
FROM	products p1 INNER JOIN products p2
		ON p1.product_id <> p2.product_id
WHERE	ABS(p1.unit_price - p2.unit_price) < 0.25
		AND p1.product_name < p2.product_name
ORDER BY price_diff DESC;