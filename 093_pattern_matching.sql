-- Return the first word of each event
SELECT	event_name,
		SUBSTR(event_name, 1, 3)
FROM	my_events;

SELECT	event_name,
		INSTR(event_name, ' ')
FROM	my_events;

SELECT	event_name,
		SUBSTR(event_name, 1, INSTR(event_name, ' ') - 1) AS first_word
FROM	my_events;

-- Update to handle single word events
SELECT	event_name,
		CASE WHEN INSTR(event_name, ' ') = 0 THEN event_name
			 ELSE SUBSTR(event_name, 1, INSTR(event_name, ' ') - 1) END AS first_word
FROM	my_events;

-- Return descriptions that contain 'family'
SELECT	*
FROM	my_events
WHERE	event_desc LIKE '%family%';

-- Return descriptions that start with 'A'
SELECT	*
FROM	my_events
WHERE	event_desc LIKE 'A %';

-- Return students with three letter first names
SELECT	*
FROM	students
WHERE	student_name LIKE '___ %';

-- Note any celebration word in the sentence
SELECT	event_desc,
		REGEXP_SUBSTR(event_desc, 'celebration|festival|holiday') AS celebration_word
FROM	my_events
WHERE	event_desc LIKE '%celebration%'
		OR event_desc LIKE '%festival%'
        OR event_desc LIKE '%holiday%';

-- Return words with hyphens in them
SELECT	event_desc,
		REGEXP_SUBSTR(event_desc, '[A-Z][a-z]+(-[A-Za-z]+)+') AS hyphen_phrase
FROM	my_events;