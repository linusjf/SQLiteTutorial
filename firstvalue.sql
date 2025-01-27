/*
Introduction to the FIRST_VALUE() function
The FIRST_VALUE() is a window function that allows you to obtain the value of the first row in a specified window frame.

The following shows the syntax of the FIRST_VALUE() function:

FIRST_VALUE(expression) OVER (
PARTITION BY expression1, expression2,...
ORDER BY expression1 [ASC | DESC], expression2,..
frame_clause
)
In this syntax:

expression
is an expression evaluated against the first row in the window frame. The expression must return a single value. It is not possible to use a subquery or another window function in the expression.

PARTITION BY
The PARTITION BY clause distributes rows into partitions by one or more criteria to which the FIRST_VALUE() function applies. The PARTITION BY clause is optional. If you omit it, the FIRST_VALUE() function will treat the whole result set as a single partition.

ORDER BY
The ORDER BY clause specifies the order of the rows in each partition to which the FIRST_VALUE() function applies.

frame_clause
The frame_clause defines the frame of the current partition. For the detailed information on the frame clause, check it out the window frame clause tutorial.

SQLite FIRST_VALUE() function examples
We will use the tracks table from the sample database for the demonstration:


1) Using SQLite FIRST_VALUE() function with ORDER BY clause example
The following statement uses the FIRST_VALUE() function to return the track name, the size in bytes, and the smallest track of the album id 1:
*/
SELECT
  name,
  PRINTF('%,d', bytes) AS size,
  FIRST_VALUE(name) OVER (ORDER BY bytes) AS smallesttrack
FROM tracks
WHERE albumid = 1;

SELECT
  name,
  PRINTF('%,d', bytes) AS size,
  FIRST_VALUE(name) OVER (
    PARTITION BY albumid
    ORDER BY bytes
  ) AS smallesttrack
FROM tracks;

/*
In this example, the ORDER BY clause sorted the tracks by values in the Bytes column and the FIRST_VALUE() function picked the first track from the result set.

Notice that we used the printf() function format the numeric values in the Bytes column with commas (,).

2) Using SQLite FIRST_VALUE() with PARTITION BY clause example
The following example returns all tracks from all albums. It also shows the largest track for each album:
*/
SELECT
  albumid,
  name,
  PRINTF('%,d', bytes) AS size,
  FIRST_VALUE(name) OVER (
    PARTITION BY albumid
    ORDER BY bytes DESC
  ) AS largesttrack
FROM tracks;
/*
In this example:

First, the PARTITION BY clause divided the tracks by album id.
Then, the ORDER BY clause sorted tracks by their sizes from high to low.
Finally, the FIRST_VALUE() picked the track with the largest size in each album.

*/
