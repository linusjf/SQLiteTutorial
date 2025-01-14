CREATE TABLE t0 (x INTEGER PRIMARY KEY, y TEXT);

INSERT INTO
  t0
VALUES
  (1, 'aaa'),
  (2, 'ccc'),
  (3, 'bbb');

/*
-- The following SELECT statement returns:
--
--   x | y | row_number
-----------------------
--   1 | aaa | 1
--   2 | ccc | 3
--   3 | bbb | 2
--
*/
SELECT
  x,
  y,
  ROW_NUMBER() OVER (
    ORDER BY
      y
  ) AS row_number
FROM
  t0
ORDER BY
  x;

SELECT
x,
y,
ROW_NUMBER() OVER win1 AS `row`,
RANK() OVER win2 AS `rank`
FROM t0
WINDOW win1 AS (
ORDER BY y RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW),
       win2 AS (PARTITION BY y
ORDER BY x)
ORDER BY x;
