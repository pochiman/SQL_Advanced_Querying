-- ASSIGNMENT 5: Null functions

-- View the columns of interest
SELECT	product_name, factory, division
FROM	products
ORDER BY factory, division;

-- Replace NULL values with Other
SELECT	product_name, factory, division,
		COALESCE(division, 'Other') AS division_other
FROM	products
ORDER BY factory, division;

-- Find the most common division for each factory
SELECT	factory, division, COUNT(product_name) AS num_products
FROM	products
WHERE	division IS NOT NULL
GROUP BY factory, division
ORDER BY factory, division;

-- Replace NULL values with top division for each factory
WITH np AS (SELECT	factory, division, COUNT(product_name) AS num_products
			FROM	products
			WHERE	division IS NOT NULL
			GROUP BY factory, division
			ORDER BY factory, division),
            
	 np_rank AS (SELECT	factory, division, num_products,
						ROW_NUMBER() OVER(PARTITION BY factory ORDER BY num_products DESC) AS np_rank
				 FROM	np)
                 
SELECT	factory, division
FROM	np_rank
WHERE	np_rank = 1;

-- Replace division with Other value and top division
WITH np AS (SELECT	factory, division, COUNT(product_name) AS num_products
			FROM	products
			WHERE	division IS NOT NULL
			GROUP BY factory, division
			ORDER BY factory, division), -- ORDER BY in CTE is not needed and can be omitted
            
	 np_rank AS (SELECT	factory, division, num_products,
						ROW_NUMBER() OVER(PARTITION BY factory ORDER BY num_products DESC) AS np_rank
				 FROM	np),
                 
	 top_div AS (SELECT	factory, division
				 FROM	np_rank
				 WHERE	np_rank = 1)

SELECT	 p.product_name, p.factory, p.division,
		 COALESCE(p.division, 'Other') AS division_other,
         COALESCE(p.division, td.division) AS division_top
FROM	 products p LEFT JOIN top_div td
		 ON p.factory = td.factory
ORDER BY p.factory, p.division;