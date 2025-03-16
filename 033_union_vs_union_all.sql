-- 7. Union vs union all
SELECT * FROM tops;
SELECT * FROM outerwear;

-- Union
SELECT * FROM tops
UNION
SELECT * FROM outerwear;

-- Union all
SELECT * FROM tops
UNION ALL
SELECT * FROM outerwear;

-- Union with different column names
SELECT * FROM happiness_scores;
SELECT * FROM happiness_scores_current;

SELECT year, country, happiness_score FROM happiness_scores
UNION ALL
SELECT 2024, country, ladder_score FROM happiness_scores_current;