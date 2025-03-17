-- ASSIGNMENT 3: Subqueries in the WHERE clause

-- View all products from Wicked Choccy's
SELECT	*
FROM	products
WHERE	factory = "Wicked Choccy's";

-- Return products where the unit price is less than
-- the unit price of all products from Wicked Choccy's
SELECT	*
FROM	products
WHERE	unit_price <
		ALL (SELECT	unit_price
			 FROM	products
			 WHERE	factory = "Wicked Choccy's");