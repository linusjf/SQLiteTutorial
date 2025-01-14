DROP TABLE IF EXISTS t0;

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
FROM
  t0
WINDOW
  win1 AS (
    ORDER BY
      y RANGE BETWEEN UNBOUNDED PRECEDING
      AND CURRENT ROW
  ),
  win2 AS (
    PARTITION BY
      y
    ORDER BY
      x
  )
ORDER BY
  x;

DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (a INTEGER PRIMARY KEY, b, c);

INSERT INTO
  t1
VALUES
  (1, 'A', 'one'),
  (2, 'B', 'two'),
  (3, 'C', 'three'),
  (4, 'D', 'one'),
  (5, 'E', 'two'),
  (6, 'F', 'three'),
  (7, 'G', 'one');

-- The following SELECT statement returns:
--
--   a | b | group_concat
-------------------------
--   1 | A | A.B
--   2 | B | A.B.C
--   3 | C | B.C.D
--   4 | D | C.D.E
--   5 | E | D.E.F
--   6 | F | E.F.G
--   7 | G | F.G
--
SELECT
  a,
  b,
  GROUP_CONCAT(b, '.') OVER (
    ORDER BY
      a ROWS BETWEEN 1 PRECEDING
      AND 1 FOLLOWING
  ) AS group_concat
FROM
  t1;

SELECT
  a,
  c,
  GROUP_CONCAT(c, ',') OVER (
    ORDER BY
      a ROWS BETWEEN 2 PRECEDING
      AND 1 FOLLOWING
  ) AS group_concat
FROM
  t1;

-- The following SELECT statement returns:
--
--   c     | a | b | group_concat
---------------------------------
--   one   | 1 | A | A.D.G
--   one   | 4 | D | D.G
--   one   | 7 | G | G
--   three | 3 | C | C.F
--   three | 6 | F | F
--   two   | 2 | B | B.E
--   two   | 5 | E | E
--
SELECT
  c,
  a,
  b,
  GROUP_CONCAT(b, '.') OVER (
    PARTITION BY
      c
    ORDER BY
      a RANGE BETWEEN CURRENT ROW
      AND UNBOUNDED FOLLOWING
  ) AS group_concat
FROM
  t1
ORDER BY
  c,
  a;

-- The following SELECT statement returns:
--
--   c     | a | b | group_concat
---------------------------------
--   one   | 1 | A | A.D.G
--   two   | 2 | B | B.E
--   three | 3 | C | C.F
--   one   | 4 | D | D.G
--   two   | 5 | E | E
--   three | 6 | F | F
--   one   | 7 | G | G
--
SELECT
  c,
  a,
  b,
  GROUP_CONCAT(b, '.') OVER (
    PARTITION BY
      c
    ORDER BY
      a RANGE BETWEEN CURRENT ROW
      AND UNBOUNDED FOLLOWING
  ) AS group_concat
FROM
  t1
ORDER BY
  a;

-- The following SELECT statement returns:
--
--   a | b | c | group_concat
-----------------------------
--   1 | A | one   | A.D.G
--   2 | B | two   | A.D.G.C.F.B.E
--   3 | C | three | A.D.G.C.F
--   4 | D | one   | A.D.G
--   5 | E | two   | A.D.G.C.F.B.E
--   6 | F | three | A.D.G.C.F
--   7 | G | one   | A.D.G
--
SELECT
  a,
  b,
  c,
  GROUP_CONCAT(b, '.') OVER (
    ORDER BY
      c
  ) AS group_concat
FROM
  t1
ORDER BY
  a;

SELECT
  a,
  b,
  c,
  GROUP_CONCAT(b, '.') OVER (
    ORDER BY
      c GROUPS BETWEEN UNBOUNDED PRECEDING
      AND UNBOUNDED FOLLOWING EXCLUDE GROUP
  ) AS group_concat
FROM
  t1
ORDER BY
  a;
