-- 3. FIRST_VALUE, LAST VALUE & NTH_VALUE
CREATE TABLE baby_names (
    gender VARCHAR(10),
    name VARCHAR(50),
    babies INT);

INSERT INTO baby_names (gender, name, babies) VALUES
	('Female', 'Charlotte', 80),
	('Female', 'Emma', 82),
	('Female', 'Olivia', 99),
	('Male', 'James', 85),
	('Male', 'Liam', 110),
	('Male', 'Noah', 95);
    
-- View the table
SELECT * FROM baby_names;
    
-- Return the first name in each window
SELECT	gender, name, babies,
		FIRST_VALUE(name) OVER(PARTITION BY gender ORDER BY babies DESC) AS top_name
FROM	baby_names;
    
-- Return the top name for each gender
SELECT * FROM

(SELECT	gender, name, babies,
		FIRST_VALUE(name) OVER(PARTITION BY gender ORDER BY babies DESC) AS top_name
FROM	baby_names) AS top_name

WHERE name = top_name;

-- CTE alternative
WITH top_name AS
(SELECT	gender, name, babies,
		FIRST_VALUE(name) OVER(PARTITION BY gender ORDER BY babies DESC) AS top_name
FROM	baby_names) 

SELECT * 
FROM top_name
WHERE name = top_name;

-- Return the second name in each window
SELECT	gender, name, babies,
		NTH_VALUE(name, 2) OVER(PARTITION BY gender ORDER BY babies DESC) AS second_name
FROM	baby_names;

-- Return the 2nd most popular name for each gender
SELECT * FROM

(SELECT	gender, name, babies,
		NTH_VALUE(name, 2) OVER(PARTITION BY gender ORDER BY babies DESC) AS second_name
FROM	baby_names) AS second_name

WHERE name = second_name;

-- Alternative using ROW_NUMBER

-- Number all the rows within each window
SELECT	gender, name, babies,
		ROW_NUMBER() OVER(PARTITION BY gender ORDER BY babies DESC) AS popularity
FROM	baby_names;

-- Return the top 2 most popular names for each gender
SELECT * FROM

(SELECT	gender, name, babies,
		ROW_NUMBER() OVER(PARTITION BY gender ORDER BY babies DESC) AS popularity
FROM	baby_names) AS pop

WHERE popularity <= 2;