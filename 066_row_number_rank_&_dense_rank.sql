-- 2. ROW_NUMBER vs RANK vs DENSE_RANK
CREATE TABLE baby_girl_names (
    name VARCHAR(50),
    babies INT);

INSERT INTO baby_girl_names (name, babies) VALUES
	('Olivia', 99),
	('Emma', 80),
	('Charlotte', 80),
	('Amelia', 75),
	('Sophia', 72),
	('Isabella', 70),
	('Ava', 70),
	('Mia', 64);
    
-- View the table
SELECT * FROM baby_girl_names;

-- Compare ROW_NUMBER vs RANK vs DENSE_RANK
SELECT	name, babies,
		ROW_NUMBER() OVER(ORDER BY babies DESC) AS babies_rn,
        RANK() OVER(ORDER BY babies DESC) AS babies_rank,
        DENSE_RANK() OVER(ORDER BY babies DESC) AS babies_drank
FROM	baby_girl_names;