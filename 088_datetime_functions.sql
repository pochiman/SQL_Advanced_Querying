-- ASSIGNMENT 2: Datetime functions

-- Extract just the orders from Q2 2024
SELECT	*
FROM	orders
WHERE	YEAR(order_date) = 2024 AND MONTH(order_date) BETWEEN 4 AND 6;

-- Add a column called ship_date that adds 2 days to each order date
SELECT	order_id, order_date,
		DATE_ADD(order_date, INTERVAL 2 DAY) AS ship_date
FROM	orders
WHERE	YEAR(order_date) = 2024 AND MONTH(order_date) BETWEEN 4 AND 6;

/*	This function varies by RDBMS:
- MySQL:	  DATE_ADD(order_date, INTERVAL 2 DAY)
- Oracle: 	  order_date + INTERVAL '2' DAY
- PostgreSQL: order_date + INTERVAL '2 days'
- SQL Server: DATEADD(DAY, 2, order_date)
- SQLite:	  DATE(order_date, '+2 days')
*/