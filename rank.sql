/*
The RANK() function is a window function that assigns a rank to each row in a query’s result set. The rank of a row is calculated by one plus the number of ranks that come before it.

The following shows the syntax of the RANK() function:

RANK() OVER (
PARTITION BY <expression1>[{,<expression2>...}]
ORDER BY <expression1> [ASC|DESC], [{,<expression1>...}]
)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, the PARTITION BY clause divides the rows of the result set into partitions.
Second, the ORDER BY clause specifies the order of the rows in each partition.
Third, the RANK() function is applied to each row in each partition and re-initialized when crossing the partition boundary.
The same column values will receive the same ranks. When multiple rows have the same rank, the rank of the next row is not consecutive. This is like the Olympic medal in which if two athletes share the gold medal, there will be no silver medal.
/*
*/
DROP TABLE IF EXISTS rankdemo;

CREATE TABLE rankdemo (
  val TEXT
);

/*
Second, insert data into the DenseRankDemo table:
*/
INSERT INTO rankdemo
  (val)
VALUES
  ('A'),
  ('B'),
  ('C'),
  ('C'),
  ('D'),
  ('D'),
  ('E');

/*
Third, use the RANK() function to compute a rank for each row:
*/
SELECT
  val,
  RANK() OVER (ORDER BY val) AS valrank
FROM rankdemo;

/*
Rows with the same value receive the same rank.
There are no gaps in rank values.
2) Using RANK() function with partitions
The following statement uses the RANK() function to compute the rank for each track in each album based on the track’s length:
*/
-- noqa:disable=RF02
SELECT
  albumid,
  name,
  milliseconds,
  RANK() OVER (
    PARTITION BY albumid
    ORDER BY milliseconds
  ) AS lengthrank
FROM tracks
WHERE
  albumid IN (
    SELECT albumid
    FROM tracks
    GROUP BY albumid
    HAVING COUNT(trackid) > 8
  )
LIMIT 20 OFFSET 0;
