-- 6. EXISTS
SELECT * FROM happiness_scores;
SELECT * FROM inflation_rates;

/* Return happiness scores of countries
that exist in the inflation rates table */
SELECT	*
FROM 	happiness_scores h
WHERE	EXISTS (
		SELECT	i.country_name
        FROM	inflation_rates i
        WHERE	i.country_name = h.country);

-- Alternative to EXISTS: INNER JOIN
SELECT	*
FROM 	happiness_scores h
		INNER JOIN inflation_rates i
        ON h.country = i.country_name AND h.year = i.year;