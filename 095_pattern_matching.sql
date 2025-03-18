-- ASSIGNMENT 4: Pattern matching

-- View the product names
SELECT	 product_name
FROM	 products
ORDER BY product_name;

-- Only extract text after the hyphen for Wonka Bars
SELECT	 product_name,
		 REPLACE(product_name, 'Wonka Bar - ', '') AS new_product_name
FROM	 products
ORDER BY product_name;

-- Alternative using substrings
SELECT	 product_name,
		 CASE WHEN INSTR(product_name, '-') = 0 THEN product_name
			  ELSE SUBSTR(product_name, INSTR(product_name, '-') + 2) END AS new_product_name
FROM	 products
ORDER BY product_name;

/* The INSTR and SUBSTR functions will work in MySQL, Oracle and SQLite
	
    In PostgreSQL, use:
    POSITION('-' IN product_name) = 0
    SUBSTRING(product_name FROM POSITION('-' IN product_name) + 2)
    
    In SQL Server, use:
    CHARINDEX('-', product_name) = 0
    SUBSTRING(product_name, CHARINDEX('-', product_name) + 2, LEN(product_name)) 
    
*/