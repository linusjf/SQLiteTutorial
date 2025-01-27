/*
Introduction to SQLite DENSE_RANK() function
The DENSE_RANK() is a window function that computes the rank of a row in an ordered set of rows and returns the rank as an integer. The ranks are consecutive integers starting from 1. Rows with equal values receive the same rank. And rank values are not skipped in case of ties.

Here is the syntax of the DENSE_RANK() function:

DENSE_RANK() OVER (
PARTITION BY expression1, expression2,...
ORDER BY expression1 [ASC | DESC], expression2,..
)
In this syntax:

The PARTITION BY clause divides the result set into partitions to which the function applies. If you omit the PARTITION BY clause, the function treats the whole result set as a single partition.
The ORDER BY specifies the order of rows in each partition to which the function applies.
The DENSE_RANK() function applies to each partition separately and recomputes the rank for each partition.
The DENSE_RANK() function is useful in case you want to create top-N and bottom-N reports.

SQLite DENSE_RANK() function examples
Let’s take some examples of using theDENSE_RANK() function to understand it better.

1) Using SQLite DENSE_RANK() function over the result set example
First, create a new table named DenseRankDemo for demonstration:
*/
DROP TABLE IF EXISTS denserankdemo;

CREATE TABLE denserankdemo (
  val TEXT
);

/*
Second, insert data into the DenseRankDemo table:
*/
INSERT INTO denserankdemo
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
Third, use the DENSE_RANK() function to compute a rank for each row:
*/
SELECT
  val,
  DENSE_RANK() OVER (ORDER BY val) AS valrank
FROM denserankdemo;

/*
Rows with the same value receive the same rank.
There are no gaps in rank values.
2) Using DENSE_RANK() function with partitions
The following statement uses the DENSE_RANK() function to compute the rank for each track in each album based on the track’s length:
*/
SELECT
  albumid,
  name,
  milliseconds,
  DENSE_RANK() OVER (
    PARTITION BY albumid
    ORDER BY milliseconds
  ) AS lengthrank
FROM tracks;
