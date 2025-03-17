-- 2. CAST & CONVERT FUNCTIONS

-- Create a sample table
CREATE TABLE sample_table (
    id INT,
    str_value CHAR(50)
);

INSERT INTO sample_table (id, str_value) VALUES
	(1, '100.2'),
	(2, '200.4'),
	(3, '300.6');

SELECT * FROM sample_table;

-- Try to do a math calculation on the string column
SELECT	id, str_value*2
FROM	sample_table;

-- Turn the string to a decimal
SELECT	id, CAST(str_value AS DECIMAL(5, 2))*2
FROM	sample_table;

-- Turn an integer into a float
SELECT	country, population / 5.0
FROM	country_stats;