-- 2. MIN / MAX VALUE FILTERING

CREATE TABLE sales (
    id INT PRIMARY KEY,
    sales_rep VARCHAR(50),
    date DATE,
    sales INT
);

INSERT INTO sales (id, sales_rep, date, sales) VALUES 
    (1, 'Emma', '2024-08-01', 6),
    (2, 'Emma', '2024-08-02', 17),
    (3, 'Jack', '2024-08-02', 14),
    (4, 'Emma', '2024-08-04', 20),
    (5, 'Jack', '2024-08-05', 5),
    (6, 'Emma', '2024-08-07', 1);

-- View the sales table
SELECT * FROM sales;

-- Goal: Return the most recent sales amount for each sales rep

-- Return the most recent sales date for each sales rep
SELECT	 sales_rep, MAX(date) AS most_recent_date
FROM	 sales
GROUP BY sales_rep;

-- Return the most recent sales date for each sales rep + attempt to add on the sales
SELECT	 sales_rep, MAX(date) AS most_recent_date, MAX(sales)
FROM	 sales
GROUP BY sales_rep;

-- Number of sales on most recent date: Group by + join approach
WITH rd AS (SELECT	 sales_rep, MAX(date) AS most_recent_date
			FROM	 sales
			GROUP BY sales_rep)
            
SELECT	rd.sales_rep, rd.most_recent_date, s.sales
FROM	rd LEFT JOIN sales s
		ON rd.sales_rep = s.sales_rep
        AND rd.most_recent_date = s.date;
                
-- Number of sales on most recent date: Window function approach
SELECT * FROM

(SELECT	sales_rep, date, sales,
		ROW_NUMBER() OVER (PARTITION BY sales_rep ORDER BY date DESC) AS row_num
FROM	sales) AS rn

WHERE row_num = 1;