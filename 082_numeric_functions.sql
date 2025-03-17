-- Connect to database (MySQL)
USE maven_advanced_sql;

-- 1. NUMERIC FUNCTIONS

-- Math and rounding functions
SELECT	country, population,
		LOG(population) AS log_pop,
        ROUND(LOG(population), 2) AS log_pop_2
FROM	country_stats;

-- Pro tip: FLOOR function for binning
WITH pm AS (SELECT	country, population,
					FLOOR(population / 1000000) AS pop_m
			FROM	country_stats)
            
SELECT	pop_m, COUNT(country) AS num_countries
FROM	pm
GROUP BY pop_m
ORDER BY pop_m;

-- Max of a column vs max of a row: Least & greatest

-- Create a miles run table
CREATE TABLE miles_run (
    name VARCHAR(50),
    q1 INT,
    q2 INT,
    q3 INT,
    q4 INT
);

INSERT INTO miles_run (name, q1, q2, q3, q4) VALUES
	('Ali', 100, 200, 150, NULL),
	('Bolt', 350, 400, 380, 300),
	('Jordan', 200, 250, 300, 320);

SELECT * FROM miles_run;

-- Return the greatest value of each column
SELECT	MAX(q1), MAX(q2), MAX(q3), MAX(q4)
FROM	miles_run;

-- Return the greatest value of each row
SELECT	GREATEST(q1, q2, q3, q4) AS most_miles
FROM	miles_run;

-- Lookahead: Deal with the NULL values
SELECT	GREATEST(q1, q2, q3, COALESCE(q4, 0)) AS most_miles
FROM	miles_run;