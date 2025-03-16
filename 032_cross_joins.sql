-- 6. Cross joins
CREATE TABLE tops (
    id INT,
    item VARCHAR(50)
);

CREATE TABLE sizes (
    id INT,
    size VARCHAR(50)
);

CREATE TABLE outerwear (
    id INT,
    item VARCHAR(50)
);

INSERT INTO tops (id, item) VALUES
	(1, 'T-Shirt'),
	(2, 'Hoodie');

INSERT INTO sizes (id, size) VALUES
	(101, 'Small'),
	(102, 'Medium'),
	(103, 'Large');

INSERT INTO outerwear (id, item) VALUES
	(2, 'Hoodie'),
	(3, 'Jacket'),
	(4, 'Coat');
    
-- View the tables
SELECT * FROM tops;
SELECT * FROM sizes;
SELECT * FROM outerwear;

-- Cross join the tables
SELECT	*
FROM	tops CROSS JOIN sizes;

-- From the self join assignment:
-- Which products are within 25 cents of each other in terms of unit price?
SELECT	p1.product_name, p1.unit_price,
		p2.product_name, p2.unit_price,
        p1.unit_price - p2.unit_price AS price_diff
FROM	products p1 INNER JOIN products p2
		ON p1.product_id <> p2.product_id
WHERE	ABS(p1.unit_price - p2.unit_price) < 0.25
		AND p1.product_name < p2.product_name
ORDER BY price_diff DESC;
        
-- Rewritten with a CROSS JOIN
SELECT	p1.product_name, p1.unit_price,
		p2.product_name, p2.unit_price,
        p1.unit_price - p2.unit_price AS price_diff
FROM	products p1 CROSS JOIN products p2
WHERE	ABS(p1.unit_price - p2.unit_price) < 0.25
		AND p1.product_name < p2.product_name
ORDER BY price_diff DESC;