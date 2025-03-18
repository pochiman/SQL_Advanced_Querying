-- 4. STRING FUNCTIONS

-- Change the case
SELECT	event_name, UPPER(event_name), LOWER(event_name)
FROM	my_events;

-- Clean up event type and find the length of the description
SELECT	event_name, event_type,
        TRIM(REPLACE(event_type, '!', '')) AS event_type_clean,
		event_desc,
        LENGTH(event_desc) AS desc_len
FROM	my_events;

-- Combine the type and description columns
WITH my_events_clean AS (SELECT	event_name, event_type,
								TRIM(REPLACE(event_type, '!', '')) AS event_type_clean,
								event_desc,
								LENGTH(event_desc) AS desc_len
						 FROM	my_events)
                         
SELECT	event_name, event_type_clean, event_desc,
		CONCAT(event_type_clean, ' | ', event_desc) AS full_desc
FROM	my_events_clean;