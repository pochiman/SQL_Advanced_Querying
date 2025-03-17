-- 8. CTEs: Reusability
        
-- SUBQUERY: Compare the happiness scores within each region in 2023
SELECT * FROM happiness_scores WHERE year = 2023;

SELECT	hs1.region, hs1.country, hs1.happiness_score,
		hs2.country, hs2.happiness_score
FROM	happiness_scores hs1 INNER JOIN happiness_scores hs2
		ON hs1.region = hs2.region;
        
SELECT	hs1.region, hs1.country, hs1.happiness_score,
		hs2.country, hs2.happiness_score
FROM	(SELECT * FROM happiness_scores WHERE year = 2023) hs1
		INNER JOIN
        (SELECT * FROM happiness_scores WHERE year = 2023) hs2
		ON hs1.region = hs2.region;

-- CTE: Compare the happiness scores within each region in 2023
WITH hs AS (SELECT * FROM happiness_scores WHERE year = 2023)

SELECT	hs1.region, hs1.country, hs1.happiness_score,
		hs2.country, hs2.happiness_score
FROM	hs hs1 INNER JOIN hs hs2
		ON hs1.region = hs2.region
WHERE	hs1.country < hs2.country;