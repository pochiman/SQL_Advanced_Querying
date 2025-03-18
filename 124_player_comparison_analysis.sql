-- PART IV: PLAYER COMPARISON ANALYSIS

-- TASK 1: View the players table
SELECT * FROM players;

-- TASK 2: Which players have the same birthday? Hint: Look into GROUP_CONCAT / LISTAGG / STRING_AGG [String Functions]
WITH bn AS (SELECT	CAST(CONCAT(birthYear, '-', birthMonth, '-', birthDay) AS DATE) AS birthdate,
					nameGiven
			FROM	players)
            
SELECT	birthdate, GROUP_CONCAT(nameGiven SEPARATOR ', ') AS players
FROM	bn
WHERE	YEAR(birthdate) BETWEEN 1980 AND 1990
GROUP BY birthdate
ORDER BY birthdate;

/* These functions vary by RDBMS:

String concatenation:
- MySQL & SQL Server: CONCAT(birthYear, '-', birthMonth, '-', birthDay)
- Oracle, PostgreSQL & SQLite: birthYear || '-' || birthMonth || '-' || birthDay

Group concatenation:
- MySQL:		GROUP_CONCAT(nameGiven SEPARATOR ', ')
- Oracle:		LISTAGG(nameGiven, ', ') WITHIN GROUP (ORDER BY nameGiven)
- PostgreSQL:	STRING_AGG(nameGiven, ', ' ORDER BY nameGiven)
- SQL Server:	STRING_AGG(nameGiven, ', ') WITHIN GROUP (ORDER BY nameGiven)
- SQLite:		GROUP_CONCAT(nameGiven, ', ')

*/

-- TASK 3: Create a summary table that shows for each team, what percent of players bat right, left and both [Pivoting]
-- EDIT: This solution doesn't account for duplicate player rows in the salaries table. The DISTINCT solution below is the more accurate one.
SELECT	s.teamID,
		ROUND(SUM(CASE WHEN p.bats = 'R' THEN 1 ELSE 0 END) / COUNT(s.playerID) * 100, 1) AS bats_right,
        ROUND(SUM(CASE WHEN p.bats = 'L' THEN 1 ELSE 0 END) / COUNT(s.playerID) * 100, 1) AS bats_left,
        ROUND(SUM(CASE WHEN p.bats = 'B' THEN 1 ELSE 0 END) / COUNT(s.playerID) * 100, 1) AS bats_both
FROM	salaries s LEFT JOIN players p
		ON s.playerID = p.playerID
GROUP BY s.teamID;

-- EDIT: This is the more accurate solution, which first removes duplicate playerID-teamID combos from the salaries table before pivoting
-- The duplicates exist because each row in the salaries table represents a player's salary on a particular team for a particular year
WITH up AS (SELECT DISTINCT s.teamID, s.playerID, p.bats
           FROM salaries s LEFT JOIN players p
           ON s.playerID = p.playerID) -- unique players CTE

SELECT teamID,
		ROUND(SUM(CASE WHEN bats = 'R' THEN 1 ELSE 0 END) / COUNT(playerID) * 100, 1) AS bats_right,
        ROUND(SUM(CASE WHEN bats = 'L' THEN 1 ELSE 0 END) / COUNT(playerID) * 100, 1) AS bats_left,
        ROUND(SUM(CASE WHEN bats = 'B' THEN 1 ELSE 0 END) / COUNT(playerID) * 100, 1) AS bats_both
FROM up
GROUP BY teamID;

-- TASK 4: How have average height and weight at debut game changed over the years, and what's the decade-over-decade difference? [Window Functions]
WITH hw AS (SELECT	FLOOR(YEAR(debut) / 10) * 10 AS decade,
					AVG(height) AS avg_height, AVG(weight) AS avg_weight
			FROM	players
			GROUP BY decade)
            
SELECT	decade,
		avg_height - LAG(avg_height) OVER(ORDER BY decade) AS height_diff,
        avg_weight - LAG(avg_weight) OVER(ORDER BY decade) AS weight_diff
FROM	hw
WHERE	decade IS NOT NULL;