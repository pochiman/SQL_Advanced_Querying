-- 2. Join types
SELECT	hs.year, hs.country, hs.happiness_score,
		cs.country, cs.continent
FROM	happiness_scores hs
		INNER JOIN country_stats cs
        ON hs.country = cs.country;
        
SELECT	hs.year, hs.country, hs.happiness_score,
		cs.country, cs.continent
FROM	happiness_scores hs
		LEFT JOIN country_stats cs
        ON hs.country = cs.country
WHERE	cs.country IS NULL;

SELECT	hs.year, hs.country, hs.happiness_score,
		cs.country, cs.continent
FROM	happiness_scores hs
		RIGHT JOIN country_stats cs
        ON hs.country = cs.country
WHERE	hs.country IS NULL;

SELECT	DISTINCT hs.country
FROM	happiness_scores hs
		LEFT JOIN country_stats cs
        ON hs.country = cs.country
WHERE	cs.country IS NULL;

SELECT	DISTINCT cs.country
FROM	happiness_scores hs
		RIGHT JOIN country_stats cs
        ON hs.country = cs.country
WHERE	hs.country IS NULL;