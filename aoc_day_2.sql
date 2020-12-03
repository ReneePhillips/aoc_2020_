aoc_day_2.sql

--load all of the input into one column as data type TEXT. Will split later.
CREATE TABLE text_pass (t TEXT);

\copy text_pass FROM 'aoc_2020_day_2_t.txt'


WITH t1 AS (
 	SELECT
		SPLIT_PART(t, ' ' , 1) as range,
		SPLIT_PART(t, ' ' , 2) as letter,
		SPLIT_PART(t, ' ' , 3) as pass
	FROM text_pass 
	)
SELECT * FROM t1
LIMIT 5
;


--USE split_part (in a CTE?) to create new appropriate columns in intermediary tables


--CREATE TABLE day_2 AS 
--SELECT
--SPLIT_PART(t, ' ' , 1) as range,
--SPLIT_PART(t, ' ' , 2) as letter,
--SPLIT_PART(t, ' ' , 3) as pass
--FROM text_pass
--;



aoc_2020=# CREATE TABLE day_2 AS 
aoc_2020-# SELECT
aoc_2020-# SPLIT_PART(t, ' ' , 1) as range,
aoc_2020-# SPLIT_PART(t, ' ' , 2) as letter,
aoc_2020-# SPLIT_PART(t, ' ' , 3) as pass
aoc_2020-# FROM text_pass
aoc_2020-# ;
SELECT 1000
Time: 114.958 ms
aoc_2020=# select * from day_2 limit 5;
 range | letter |         pass         
-------+--------+----------------------
 1-7   | j:     | vrfjljjwbsv
 1-10  | j:     | jjjjjjjjjjjj
 9-13  | s:     | jfxssvtvssvsbx
 10-12 | d:     | ddvddnmdnlvdddqdcqph
 11-12 | b:     | bbbbbbbbbrbnb
(5 rows)



WITH t1 AS (
 	SELECT
		SPLIT_PART(t, ' ' , 1) as range,
		SPLIT_PART(t, ' ' , 2) as letter,
		SPLIT_PART(t, ' ' , 3) as pass
	FROM text_pass 
	),
	t2 AS (
		SELECT 
			SPLIT_PART(range, '-' , 1)::INTEGER AS min_val,
			SPLIT_PART(range, '-' , 2)::INTEGER AS max_val,
			REPLACE(letter, ':' , '') AS letter,
			pass AS pass
		FROM t1	
			)
SELECT * FROM t2
LIMIT 5
;


--adding the length finder part 

WITH t1 AS (
 	SELECT
		SPLIT_PART(t, ' ' , 1) as range,
		SPLIT_PART(t, ' ' , 2) as letter,
		SPLIT_PART(t, ' ' , 3) as pass
	FROM text_pass 
	),
	t2 AS (
		SELECT 
			SPLIT_PART(t1.range, '-' , 1)::INTEGER AS min_val,
			SPLIT_PART(t1.range, '-' , 2)::INTEGER AS max_val,
			REPLACE(t1.letter, ':' , '') AS letter,
			t1.pass AS pass
		FROM t1	
	),
	t3 AS (
		SELECT 	
			t2.min_val,
			t2.max_val,
			t2.letter,
			t2.pass,
			REPLACE(t2.pass, t2.letter , '') AS shorten,
			length(t2.pass) AS len_1 
		FROM t2
	),
	t4 AS (
		SELECT 
			t3.min_val,
			t3.max_val,
			t3.letter,
			t3.pass,
			t3.len_1 AS len_orig,
			t3.shorten,
			LENGTH(t3.shorten) AS len_short
		FROM t3
	),
	t5 AS (
		SELECT 
			t4.min_val,
			t4.max_val,
			t4.letter,
			t4.pass,
			t4.len_orig AS len_orig,
			t4.shorten,
			t4.len_short,
			t4.len_orig - t4.len_short AS count_letter,
			t4.len_orig - t4.len_short <@ INT4RANGE(t4.min_val , t4.max_val, '[]') AS rule_check
		FROM t4
	)
SELECT count(*) 
FROM t5
WHERE rule_check = TRUE
;


--Second Puzzle of Day 2
--finding characters in specific positions of the password

WITH t1 AS (
 	SELECT
		SPLIT_PART(t, ' ' , 1) as range,
		SPLIT_PART(t, ' ' , 2) as letter,
		SPLIT_PART(t, ' ' , 3) as pass
	FROM text_pass 
	),
	t2 AS (
		SELECT 
			SPLIT_PART(t1.range, '-' , 1)::INTEGER AS min_pos,
			SPLIT_PART(t1.range, '-' , 2)::INTEGER AS max_pos,
			REPLACE(t1.letter, ':' , '') AS letter,
			t1.pass AS pass
		FROM t1	
	),
	t3 AS (
		SELECT 
			t2.pass,
			t2.min_pos,
			t2.max_pos,
			t2.letter,
			substr(t2.pass::TEXT, t2.min_pos::INTEGER, 1) AS letter_in_min_position,
			substr(t2.pass::TEXT, t2.max_pos::INTEGER, 1) AS letter_in_max_position
		FROM t2
	)
	
		SELECT 
			COUNT(*)
		FROM t3
		WHERE (t3.letter_in_max_position = t3.letter AND t3.letter_in_min_position != t3.letter_in_max_position)
		OR (t3.letter_in_min_position = t3.letter AND t3.letter_in_min_position  != t3.letter_in_max_position)
;
611

--
--UPDATE 
--   day_2
--SET 
--   range = REPLACE(day_2.range, '1-', '1,' );
--   UPDATE 
--   day_2
--SET 
--   range = REPLACE(day_2.range, '2-', '2,' );
--   UPDATE 
--   day_2
--SET 
--   range = REPLACE(day_2.range, '3-', '3,' );
--   UPDATE 
--   day_2
--SET 
--   range = REPLACE(day_2.range, '4-', '4,' );
--   UPDATE 
--   day_2
--SET 
--   range = REPLACE(day_2.range, '5-', '5,' );
--   UPDATE 
--   day_2
--SET 
--   range = REPLACE(day_2.range, '6-', '6,' );
--   UPDATE 
--   day_2
--SET 
--   range = REPLACE(day_2.range, '7-', '7,' );
--   UPDATE 
--   day_2
--SET 
--   range = REPLACE(day_2.range, '8-', '8,' );
--   UPDATE 
--   day_2
--SET 
--   range = REPLACE(day_2.range, '9-', '9,' );
--   UPDATE 
--   day_2
--SET 
--   range = REPLACE(day_2.range, '0-', '0,' )
--;
--
--OR YOU COULD BE SMART

--UPDATE 
--   day_2
--SET 
--   range = REPLACE(day_2.range, '-', ',' )
--
--SELECT * 
--FROM day_2 
--LIMIT 5; 
--

-- range | letter |         pass         
---------+--------+----------------------
-- 3-5   | f      | ffffwff
-- 1-7   | j      | vrfjljjwbsv
-- 1-10  | j      | jjjjjjjjjjjj
-- 9-13  | s      | jfxssvtvssvsbx
-- 10-12 | d      | ddvddnmdnlvdddqdcqph
--(5 rows)




