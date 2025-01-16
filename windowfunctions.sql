DROP TABLE IF EXISTS t0;

CREATE TABLE IF NOT EXISTS t0 (
  x INTEGER PRIMARY KEY,
  y TEXT
);

INSERT INTO t0
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
-- noqa:disable=LT14
SELECT
  x,
  y,
  ROW_NUMBER() OVER (ORDER BY y) AS row_number
FROM t0
ORDER BY x;

-- noqa:enable=LT14

SELECT
  x,
  y,
  ROW_NUMBER() OVER win1 AS `row`,
  RANK() OVER win2 AS `rank`
FROM t0
WINDOW
  win1 AS (
    ORDER BY y
    RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ),
  win2 AS (
    PARTITION BY y
    ORDER BY x
  )
ORDER BY x;

DROP TABLE IF EXISTS t1;

-- noqa:disable=all
CREATE TABLE IF NOT EXISTS t1 (
  a INTEGER PRIMARY KEY,
  b,
  c
);

-- noqa:enable=all

INSERT INTO t1
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
-- -----------------------
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
    ORDER BY a
    ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
  ) AS group_concat
FROM t1;

SELECT
  a,
  c,
  GROUP_CONCAT(c, ',') OVER (
    ORDER BY a
    ROWS BETWEEN 2 PRECEDING AND 1 FOLLOWING
  ) AS group_concat
FROM t1;

-- The following SELECT statement returns:
--
--   c     | a | b | group_concat
-- -------------------------------
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
    PARTITION BY c
    ORDER BY a
    RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
  ) AS group_concat
FROM t1
ORDER BY c, a;

-- The following SELECT statement returns:
--
--   c     | a | b | group_concat
-- -------------------------------
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
    PARTITION BY c
    ORDER BY a
    RANGE BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
  ) AS group_concat
FROM t1
ORDER BY a;

-- The following SELECT statement returns:
--
--   a | b | c | group_concat
-- ---------------------------
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
  GROUP_CONCAT(b, '.') OVER (ORDER BY c) AS group_concat
FROM t1
ORDER BY a;

-- The following SELECT statement returns:
--
-- +---+---+-------+--------------+
-- | a | b |   c   | group_concat |
-- +---+---+-------+--------------+
-- | 1 | A | one   | C.F.B.E      |
-- | 2 | B | two   | A.D.G.C.F    |
-- | 3 | C | three | A.D.G.B.E    |
-- | 4 | D | one   | C.F.B.E      |
-- | 5 | E | two   | A.D.G.C.F    |
-- | 6 | F | three | A.D.G.B.E    |
-- | 7 | G | one   | C.F.B.E      |
-- +---+---+-------+--------------+

SELECT
  a,
  b,
  c,
  GROUP_CONCAT(b, '.') OVER (
    ORDER BY c
    GROUPS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    EXCLUDE GROUP
  ) AS group_concat
FROM t1
ORDER BY a;

-- The following SELECT statement returns:
--
-- +---+---+-------+--------------+
-- | a | b |   c   | group_concat |
-- +---+---+-------+--------------+
-- | 1 | A | one   | A.C.F.B.E    |
-- | 2 | B | two   | A.D.G.C.F.B  |
-- | 3 | C | three | A.D.G.C.B.E  |
-- | 4 | D | one   | D.C.F.B.E    |
-- | 5 | E | two   | A.D.G.C.F.E  |
-- | 6 | F | three | A.D.G.F.B.E  |
-- | 7 | G | one   | G.C.F.B.E    |
-- +---+---+-------+--------------+

SELECT
  a,
  b,
  c,
  GROUP_CONCAT(b, '.') OVER (
    ORDER BY c
    GROUPS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    EXCLUDE TIES
  ) AS group_concat
FROM t1
ORDER BY a;

-- The following SELECT statement returns:
--
-- -- +---+---+-------+--------------+
-- | a | b |   c   | group_concat |
-- +---+---+-------+--------------+
-- | 1 | A | one   | D.G.C.F.B.E  |
-- | 2 | B | two   | A.D.G.C.F.E  |
-- | 3 | C | three | A.D.G.F.B.E  |
-- | 4 | D | one   | A.G.C.F.B.E  |
-- | 5 | E | two   | A.D.G.C.F.B  |
-- | 6 | F | three | A.D.G.C.B.E  |
-- | 7 | G | one   | A.D.C.F.B.E  |
-- +---+---+-------+--------------+

SELECT
  a,
  b,
  c,
  GROUP_CONCAT(b, '.') OVER (
    ORDER BY c
    GROUPS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    EXCLUDE CURRENT ROW
  ) AS group_concat
FROM t1
ORDER BY a;
/*
The following example demonstrates the effect of the various forms of the EXCLUDE clause:
*/
/*
-- The following SELECT statement returns:
--
--   c    | a | b | no_others     | current_row | grp       | ties
--  one   | 1 | A | A.D.G         | D.G         |           | A
--  one   | 4 | D | A.D.G         | A.G         |           | D
--  one   | 7 | G | A.D.G         | A.D         |           | G
--  three | 3 | C | A.D.G.C.F     | A.D.G.F     | A.D.G     | A.D.G.C
--  three | 6 | F | A.D.G.C.F     | A.D.G.C     | A.D.G     | A.D.G.F
--  two   | 2 | B | A.D.G.C.F.B.E | A.D.G.C.F.E | A.D.G.C.F | A.D.G.C.F.B
--  two   | 5 | E | A.D.G.C.F.B.E | A.D.G.C.F.B | A.D.G.C.F | A.D.G.C.F.E
--
*/
SELECT
  c,
  a,
  b,
  group_concat(b, '.') OVER (
    ORDER BY c
    GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    EXCLUDE NO OTHERS
  ) AS no_others,
  group_concat(b, '.') OVER (
    ORDER BY c
    GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    EXCLUDE CURRENT ROW
  ) AS current_row,
  group_concat(b, '.') OVER (
    ORDER BY c
    GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    EXCLUDE GROUP
  ) AS grp,
  group_concat(b, '.') OVER (
    ORDER BY c
    GROUPS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    EXCLUDE TIES
  ) AS `ties`
FROM t1
ORDER BY c, a;

/*
In the following example, the window frame for each row consists of all rows from the current row to the end of the set, where rows are sorted according to "ORDER BY a".
*/
-- The following SELECT statement returns:
--
--   c     | a | b | group_concat
-- -------------------------------
--   one   | 1 | A | A.D.G.C.F.B.E
--   one   | 4 | D | D.G.C.F.B.E
--   one   | 7 | G | G.C.F.B.E
--   three | 3 | C | C.F.B.E
--   three | 6 | F | F.B.E
--   two   | 2 | B | B.E
--   two   | 5 | E | E
--
SELECT
  c,
  a,
  b,
  group_concat(b, '.') OVER (
    ORDER BY c, a
    ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING
  ) AS group_concat
FROM t1
ORDER BY c, a;

/*
If a FILTER clause is provided, then only rows for which the expr is true are included in the window frame. The aggregate window still returns a value for every row, but those for which the FILTER expression evaluates to other than true are not included in the window frame for any row. For example:
*/
-- The following SELECT statement returns:
--
--   c     | a | b | group_concat
-- -------------------------------
--   one   | 1 | A | A
--   two   | 2 | B | A
--   three | 3 | C | A.C
--   one   | 4 | D | A.C.D
--   two   | 5 | E | A.C.D
--   three | 6 | F | A.C.D.F
--   one   | 7 | G | A.C.D.F.G
--
SELECT
  c,
  a,
  b,
  group_concat(b, '.')
    FILTER (WHERE c != 'two')
    OVER (ORDER BY a) AS group_concat
FROM t1
ORDER BY a;

DROP TABLE IF EXISTS t2;
CREATE TABLE t2 (
  a,
  b
);
INSERT INTO t2
VALUES
  ('a', 'one'),
  ('a', 'two'),
  ('a', 'three'),
  ('b', 'four'),
  ('c', 'five'),
  ('c', 'six');

/*
The following example illustrates the behaviour of the five ranking functions - row_number(), rank(), dense_rank(), percent_rank() and cume_dist().

-- The following SELECT statement returns:
--
--   a | row_number | rank | dense_rank | percent_rank | cume_dist
------------------------------------------------------------------
--   a |          1 |    1 |          1 |          0.0 |       0.5
--   a |          2 |    1 |          1 |          0.0 |       0.5
--   a |          3 |    1 |          1 |          0.0 |       0.5
--   b |          4 |    4 |          2 |          0.6 |       0.66
--   c |          5 |    5 |          3 |          0.8 |       1.0
--   c |          6 |    5 |          3 |          0.8 |       1.0
--
*/
SELECT
  a AS a,
  row_number() OVER win AS row_number,
  rank() OVER win AS rank,
  dense_rank() OVER win AS dense_rank,
  percent_rank() OVER win AS percent_rank,
  round(cume_dist() OVER win, 2) AS cume_dist
FROM t2
WINDOW win AS (ORDER BY a);

/*
The example below uses ntile() to divide the six rows into two groups (the ntile(2) call) and into four groups (the ntile(4) call). For ntile(2), there are three rows assigned to each group. For ntile(4), there are two groups of two and two groups of one. The larger groups of two appear first.

-- The following SELECT statement returns:
--
--   a | b     | ntile_2 | ntile_4
----------------------------------
--   a | one   |       1 |       1
--   a | two   |       1 |       1
--   a | three |       1 |       2
--   b | four  |       2 |       2
--   c | five  |       2 |       3
--   c | six   |       2 |       4
--
*/
SELECT
  a AS a,
  b AS b,
  ntile(2) OVER win AS ntile_2,
  ntile(4) OVER win AS ntile_4
FROM t2
WINDOW win AS (ORDER BY a);

/*
 The next example demonstrates lag(), lead(), first_value(), last_value() and nth_value(). The frame-spec is ignored by both lag() and lead(), but respected by first_value(), last_value() and nth_value().

-- The following SELECT statement returns:
--
--   b | lead | lag  | first_value | last_value | nth_value_3
-------------------------------------------------------------
--   A | C    | NULL | A           | A          | NULL
--   B | D    | A    | A           | B          | NULL
--   C | E    | B    | A           | C          | C
--   D | F    | C    | A           | D          | C
--   E | G    | D    | A           | E          | C
--   F | n/a  | E    | A           | F          | C
--   G | n/a  | F    | A           | G          | C
--
*/
SELECT
  b AS b,
  lead(b, 2, 'n/a') OVER win AS lead,
  lag(b) OVER win AS lag,
  first_value(b) OVER win AS first_value,
  last_value(b) OVER win AS last_value,
  nth_value(b, 3) OVER win AS nth_value_3
FROM t1
WINDOW
  win AS (
    ORDER BY b
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  );
