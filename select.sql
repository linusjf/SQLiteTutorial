-- syntax of the SELECT statement:
/* SELECT DISTINCT column_list
FROM table_list
  JOIN table ON join_condition
WHERE row_filter
ORDER BY column
LIMIT count OFFSET offset
GROUP BY column
HAVING group_filter; */
SELECT 1 + 1;
SELECT
   10 / 5,
   2 * 4;
SELECT
  trackid,
  name,
  composer,
  unitprice
FROM
  tracks;
SELECT
  trackid,
  name,
  albumid,
  mediatypeid,
  genreid,
  composer,
  milliseconds,
  bytes,
  unitprice
FROM
  tracks;
-- use select * only for testing purposes
/*
When you develop an application, you should control what SQLite returns to your application. Suppose, a table has 3 columns, and you use the asterisk (*) to retrieve the data from all three columns.

What if someone removes a column, your application would not be working properly, because it assumes that there are three columns returned, and the logic to process those three columns would be broken.

If someone adds more columns, your application may work but it gets more data than needed, which creates more I/O overhead between the database and application.

So try to avoid using the asterisk (*) as a good habit when you use the SELECT statement.
*/
select * from albums;
/*
To sort the rows in a result set, you add the ORDER BY clause to the  SELECT statement as follows:

SELECT
   select_list
FROM
   table
ORDER BY
    column_1 ASC,
    column_2 DESC;
Code language: SQL (Structured Query Language) (sql)
The ORDER BY clause comes after the FROM clause. It allows you to sort the result set based on one or more columns in ascending or descending order.

In this syntax, you place the column name by which you want to sort after the ORDER BY clause followed by the ASC or DESC keyword.

The ASC keyword means ascending.
The DESC keyword means descending.
If you don’t specify the ASC or DESC keyword, SQLite sorts the result set using the ASC option. In other words, it sorts the result set in ascending order by default.

If you want to sort the result set by multiple columns, you use a comma (,) to separate two columns.

The ORDER BY clause sorts rows using columns or expressions from left to right. In other words, the ORDER BY clause sorts the rows using the first column in the list. Then, it sorts the sorted rows using the second column, and so on.

SQLite allows you to sort the result set using columns that do not appear in the select list of the SELECT clause.
*/
/*
Suppose you want to sort the result set based on AlbumId column in ascending order, you use the following statement:
*/
SELECT
  name,
  milliseconds,
  albumid
FROM
  tracks
ORDER BY
  albumid ASC;
/*
SQLite uses ASC by default so you can omit it in the above statement as follows:
*/
SELECT
  name,
  milliseconds,
  albumid
FROM
  tracks
ORDER BY
  albumid;
/*
Suppose you want to sort the sorted result (by AlbumId) above by the Milliseconds column in descending order. In this case, you need to add the Milliseconds column to the ORDER BY clause as follows:
*/
SELECT
  name,
  milliseconds,
  albumid
FROM
  tracks
ORDER BY
  albumid ASC,
  milliseconds DESC;
/*
SQLite sorts rows by AlbumId column in ascending order first. Then, it sorts the sorted result set by the Milliseconds column in descending order.

If you look at the tracks of the album with AlbumId 1, you’ll find that the order of tracks changes between the two statements.*/
SELECT
  name,
  milliseconds,
  albumid
FROM
  tracks
ORDER BY
  albumid ASC,
  milliseconds DESC
LIMIT 5;
