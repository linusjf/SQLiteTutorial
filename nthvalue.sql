/*
The SQLite NTH_VALUE() function is a window function that allows you to obtain the value of the Nth row in a specified window frame.

Here is the syntax of the NTH_VALUE() function:

NTH_VALUE(expression, N) 
OVER (
PARTITION BY expression1, expression2,...
ORDER BY expression1 [ASC | DESC], expression2,..
frame_clause
)
Code language: SQL (Structured Query Language) (sql)
In this syntax:

expression
It is a valid expression evaluated against the Nth row in the window frame. The expression must return a single value. A subquery or another window function is not allowed in the expression.

N
It specifies the Nth row in the window frame specified by the frame_clause. N must be a positive integer e.g., 1, 2, and 3.

Notice that if the Nth row does not exist, the NTH_VALUE() function will return NULL.

PARTITION BY
The PARTITION BY clause divided the rows into partitions a to which the NTH_VALUE() function applies. The PARTITION BY clause is optional. If you omit it, by default, the NTH_VALUE() function will treat the whole result set as a single partition.

ORDER BY
The ORDER BY clause specifies the order of rows in each partition to which the NTH_VALUE() function applies.

frame_clause
The frame_clause defines the subset (or the frame) of the current partition. For more detailed information on the frame clause, check out the window frame clause tutorial.

The FROM FIRST instructs the NTH_VALUE() function to start calculation at the first row of the window frame.

Notice that SQL standard supports both FROM FIRST and FROM LAST clauses as follows:

NTH_VALUE(expression, N) 
FROM {FIRST | LAST}
OVER (
PARTITION BY expression1, expression2,...
ORDER BY expression1 [ASC | DESC], expression2,..
frame_clause
)

However, SQLite only supports FROM FIRST behavior implicitly. You can achieve the effect of the FROM LAST by reversing the ORDER BY ordering.

In addition, the SQL standard defines a RESPECT NULLS or IGNORE NULLS option for the NTH_VALUE() function. However, this feature is not implemented in SQLite. The default behavior is always the same as the SQ standard’s default which is RESPECT NULLS.

SQLite NTH_VALUE() function examples
See the following tracks table from the sample database:

Using SQLite NTH_VALUE() function over the result set
The following statement uses the NTH_VALUE() function to return all the tracks and also the second-longest track from the tracks table: :
*/
SELECT
  name,
  milliseconds AS length,
  NTH_VALUE(name, 2) OVER (ORDER BY milliseconds DESC) AS secondlongesttrack
FROM tracks;

/*

In this example, the ORDER BY clause sorted the result set derived from the FROM clause by the track’s lengths in ascending order and the NTH_VALUE() function returned the second row from the result set which is the second longest track.

Using SQLite NTH_VALUE() function over the partition
The following example finds the second-longest track in every album:
*/
SELECT
  albumid,
  name,
  milliseconds AS length,
  NTH_VALUE(name, 2) OVER (
    PARTITION BY albumid
    ORDER BY milliseconds DESC
    RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) AS secondlongesttrack
FROM tracks;
/*
In this example:

The PARTITION BY clause divided the tracks by the album id into partitions.
The ORDER BY clause sorted the tracks in each album by their lengths in descending order.
The window frame starts at the first row and ends at the last row in each partition.
Then the NTH_VALUE() function is applied to each partition separately to get the value from the second row in each partition.

*/
