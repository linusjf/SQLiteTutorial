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
/*
Instead of specifying the names of columns, you can use the column’s position in the ORDER BY clause.

For example, the following statement sorts the tracks by both AlbumId (3rd column) and Milliseconds (2nd column) in ascending order.
*/
SELECT
  name,
  milliseconds,
  albumid
FROM
  tracks
ORDER BY
  3,
  2
LIMIT 5;
/*
In the database world, NULL is special. It denotes that the information is missing or the data is not applicable.

Suppose you want to store the birthday of an artist in a table. At the time of saving the artist’s record, you don’t have the birthday information.

To represent the unknown birthday information in the database, you may use a special date like 01.01.1900 or an '' empty string. However, these values do not clearly show that the birthday is unknown.

NULL was invented to resolve this issue. Instead of using a special value to indicate that the information is missing, NULL is used.

NULL is special because you cannot compare it with another value. Simply put, if the two pieces of information are unknown, you cannot compare them.

NULL is even cannot be compared with itself; NULL is not equal to itself so NULL = NULL always results in false.

When it comes to sorting, SQLite considers NULL to be smaller than any other value.

It means that NULLs will appear at the beginning of the result set if you use ASC or at the end of the result set when you use DESC.

SQLite 3.30.0 added the NULLS FIRST and NULLS LAST options to the ORDER BY clause. The NULLS FIRST option specifies that the NULLs will appear at the beginning of the result set while the NULLS LAST option places NULLs at the end of the result set.
*/
SELECT 
    TrackId, 
    Name, 
    Composer 
FROM 
   tracks
ORDER BY 
   Composer
LIMIT 10;
/*
The following example uses the NULLS LAST option to place NULLs after other values:
*/
SELECT 
    TrackId, 
    Name, 
    Composer 
FROM 
    tracks
ORDER BY 
    Composer NULLS LAST
LIMIT 10 OFFSET (Select COUNT(*)  from tracks) - 10;
