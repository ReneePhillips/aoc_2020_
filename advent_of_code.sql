--2020_12_01
BEGIN;
CREATE TEMPORARY TABLE aoc_2020_1 (expense_amts INTEGER);
\copy aoc_2020_1 FROM 'aoc_2020_12_01_values.txt'
SELECT (a.expense_amts * b.expense_amts) AS product_1
FROM aoc_2020_1 AS a
CROSS JOIN aoc_2020_1 AS b
WHERE a.expense_amts + b.expense_amts = 2020
LIMIT 1;
COMMIT
 63616


BEGIN;
CREATE TEMPORARY TABLE aoc_2020_1 (expense_amts INTEGER);
\copy aoc_2020_1 FROM 'aoc_2020_12_01_values.txt'
SELECT (a.expense_amts * b.expense_amts * c.expense_amts) AS product_2
FROM aoc_2020_1 AS a
CROSS JOIN aoc_2020_1 AS b
CROSS JOIN aoc_2020_1 AS c
WHERE a.expense_amts + b.expense_amts + c.expense_amts = 2020
LIMIT 1;
COMMIT
67877784

--2020_12_02
