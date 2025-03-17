-- 9. Multiple CTEs

-- Step 1: Compare 2023 vs 2024 happiness scores side by side
WITH hs23 AS (SELECT * FROM happiness_scores WHERE year = 2023),
	 hs24 AS (SELECT * FROM happiness_scores_current)
     
SELECT	hs23.country,
		hs23.happiness_score AS hs_2023,
        hs24.ladder_score AS hs_2024
FROM	hs23 LEFT JOIN hs24
		ON hs23.country = hs24.country;

-- Step 2: Return the countries where the score increased
SELECT * FROM

(WITH hs23 AS (SELECT * FROM happiness_scores WHERE year = 2023),
	 hs24 AS (SELECT * FROM happiness_scores_current)
     
SELECT	hs23.country,
		hs23.happiness_score AS hs_2023,
        hs24.ladder_score AS hs_2024
FROM	hs23 LEFT JOIN hs24
		ON hs23.country = hs24.country) AS hs_23_24
        
WHERE hs_2024 > hs_2023;

-- Alternative: CTEs only
WITH hs23 AS (SELECT * FROM happiness_scores WHERE year = 2023),
	 hs24 AS (SELECT * FROM happiness_scores_current),
     hs_23_24 AS (SELECT	hs23.country,
							hs23.happiness_score AS hs_2023,
							hs24.ladder_score AS hs_2024
					FROM	hs23 LEFT JOIN hs24
							ON hs23.country = hs24.country)
SELECT *
FROM hs_23_24
WHERE hs_2024 > hs_2023;