/*
The PERCENT_RANK() is a window function that calculates the percent rank of a given row using the following formula:

(r - 1) / (the number of rows in the window or partition - r)
Code language: SQL (Structured Query Language) (sql)
where r is the rank of the current row.

The PERCENT_RANK() function returns a value that ranges from 0 to 1. The first row in any set has the percent rank of 0.

Here is the syntax of the PERCENT_RANK() function:

PERCENT_RANK()  
OVER ( 
[PARTITION BY partition_expression]
[ORDER BY order_list]
)
In this syntax:

()
The PERCENT_RANK() function takes no argument. However, empty parentheses are required.

PARTITION BY
The PARTITION BY clause divides the rows into partitions to which the function applies. The PARTITION BY clause is optional. If you omit the PARTITION BY clause, the function will treat the whole result set as a single partition.

ORDER BY
The ORDER BY clause specifies the order of rows in each partition to which the function applies. The ORDER BY clause is also optional. If you skip it, the function will return zero for all rows.

SQLite PERCENT_RANK() function example
We will use the following tracks table from the sample database for the demonstration.


1) Using PERCENT_RANK() function over the query result set
The following statement uses the PERCENT_RANK()function to find the percent rank of each track’s length within the album id 1:
*/
SELECT
  name,
  milliseconds,
  ROUND(PERCENT_RANK() OVER (ORDER BY milliseconds), 2) AS lengthpercentrank
FROM tracks
WHERE albumid = 1;

/*

To make the output more readable, you can use the printf() function to format the percent ranks:
*/
SELECT
  name,
  milliseconds,
  PRINTF(
    '%.2f',
    PERCENT_RANK() OVER (ORDER BY milliseconds)
  ) AS lengthpercentrank
FROM tracks
WHERE albumid = 1;

/*
2) Using PERCENT_RANK() function over the partitions
The following statement uses the PERCENT_RANK() function to calculate the percent rank of the track’s size in each album:
*/
-- noqa:disable=RF02
SELECT
  albumid,
  name,
  bytes,
  PRINTF(
    '%.2f',
    PERCENT_RANK() OVER (
      PARTITION BY albumid
      ORDER BY bytes
    )
  ) AS sizepercentrank
FROM tracks
WHERE
  albumid IN (
    SELECT albumid
    FROM tracks
    GROUP BY albumid
    HAVING COUNT(trackid) > 5
  )
LIMIT 50 OFFSET 10;
