-- 10. Recursive CTEs

-- Create a stock prices table
CREATE TABLE IF NOT EXISTS stock_prices (
    date DATE PRIMARY KEY,
    price DECIMAL(10, 2)
);

INSERT INTO stock_prices (date, price) VALUES
	('2024-11-01', 678.27),
	('2024-11-03', 688.83),
	('2024-11-04', 645.40),
	('2024-11-06', 591.01);
    
/* Employee table was created in prior section:
   This is the code if you need to create it again */
    
/*
CREATE TABLE IF NOT EXISTS employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    salary INT,
    manager_id INT
);

INSERT INTO employees (employee_id, employee_name, salary, manager_id) VALUES
	(1, 'Ava', 85000, NULL),
	(2, 'Bob', 72000, 1),
	(3, 'Cat', 59000, 1),
	(4, 'Dan', 85000, 2);
*/

-- Example 1: Generating sequences
SELECT * FROM stock_prices;

-- Generate a column of dates
WITH RECURSIVE my_dates(dt) AS
	(SELECT '2024-11-01'
     UNION ALL
     SELECT dt + INTERVAL 1 DAY
     FROM my_dates
     WHERE dt < '2024-11-06')
     
SELECT * FROM my_dates;

-- Include the original prices
WITH RECURSIVE my_dates(dt) AS
	(SELECT '2024-11-01'
     UNION ALL
     SELECT dt + INTERVAL 1 DAY
     FROM my_dates
     WHERE dt < '2024-11-06')
     
SELECT	md.dt, sp.price
FROM	my_dates md
		LEFT JOIN stock_prices sp
        ON md.dt = sp.date;

-- Example 2: Working with hierachical data
SELECT * FROM employees;

-- Return the reporting chain for each employee
WITH RECURSIVE employee_hierarchy AS (
    SELECT	employee_id, employee_name, manager_id,
			employee_name AS hierarchy
    FROM	employees
    WHERE	manager_id IS NULL
    
    UNION ALL
    
    SELECT	e.employee_id, e.employee_name, e.manager_id,
			CONCAT(eh.hierarchy, ' > ', e.employee_name) AS hierarchy
    FROM	employees e INNER JOIN employee_hierarchy eh
			ON e.manager_id = eh.employee_id
)

SELECT	employee_id, employee_name,
		manager_id, hierarchy
FROM	employee_hierarchy
ORDER BY employee_id;