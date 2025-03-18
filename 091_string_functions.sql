-- ASSIGNMENT 3: String functions

-- View the current factory names and product IDs
SELECT	factory, product_id
FROM	products
ORDER BY factory, product_id;

-- Remove apostrophes and replace spaces with hyphens
SELECT	factory, product_id,
		REPLACE(REPLACE(factory, "'", ""), " ", "-") AS factory_clean
FROM	products
ORDER BY factory, product_id;

-- Create new ID column called factory_product_id
WITH fp AS (SELECT	factory, product_id,
					REPLACE(REPLACE(factory, "'", ""), " ", "-") AS factory_clean
			FROM	products
			ORDER BY factory, product_id) -- ORDER BY in CTE is not needed and can be omitted
            
SELECT	factory_clean, product_id,
		CONCAT(factory_clean, "-", product_id) AS factory_product_id
FROM	fp;

/* 	The CONCAT function will work in MySQL and SQL Server
	In Oracle, PostgreSQL and SQLite, use the following instead:
	factory_clean || '-' || product_id AS factory_product_id
*/