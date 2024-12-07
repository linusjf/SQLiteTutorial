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

SELECT 
    TrackId, 
    Name, 
    Composer 
FROM 
    tracks
ORDER BY 
    Composer DESC NULLS FIRST
LIMIT 10;

/*
The DISTINCT clause is an optional clause of the  SELECT statement. The DISTINCT clause allows you to remove the duplicate rows in the result set.

The following statement illustrates the syntax of the DISTINCT clause:

SELECT DISTINCT	select_list
FROM table;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

First, the DISTINCT clause must appear immediately after the SELECT keyword.
Second, you place a column or a list of columns after the DISTINCT keyword. If you use one column, SQLite uses values in that column to evaluate the duplicate. In case you use multiple columns, SQLite uses the combination of values in these columns to evaluate the duplicate.
SQLite considers NULL values as duplicates. If you use theDISTINCT clause with a column that has NULL values, SQLite will keep one row of a NULL value.

In database theory, if a column contains NULL values, it means that we do not have the information about that column of particular records or the information is not applicable.

For example, if a customer has a phone number with a NULL value, it means we don’t have information about the phone number of the customer at the time of recording customer information or the customer may not have a phone number at all.
*/

/*
Suppose you want to know the cities where the customers are located, you can use the SELECT statement to get data from the city column of the customers table as follows:
*/
SELECT city
FROM customers
ORDER BY city;

/*
It returns 59 rows. There are a few duplicate rows such as Berlin London, and Mountain View To remove these duplicate rows, you use the DISTINCT clause as follows:
*/
SELECT DISTINCT city
FROM customers
ORDER BY city;

/*
The following statement finds cities and countries of all customers.
*/
SELECT
	city,
	country
FROM
	customers
ORDER BY
	country;

/*
The result set contains duplicate cities and countries e.g., Sao Paulo in Brazil as shown in the screenshot above.

To remove duplicate the city and country, you apply the DISTINCT clause to both city and country columns as shown in the following query:
*/
SELECT DISTINCT
  city,
  country
FROM
  customers
ORDER BY
  country;
/*
This statement returns the names of companies of customers from the customers table.
*/
SELECT
  company
FROM
  customers;
/*
It returns 59 rows with many NULL values.

Now, if you apply the DISTINCT clause to the statement, it will keep only one row with a NULL value.
*/
/*
See the following statement:
*/
SELECT DISTINCT
  company
FROM
  customers;
/*
The WHERE clause is an optional clause of the SELECT statement. It appears after the FROM clause as the following statement:

SELECT
  column_list
FROM
  TABLE
WHERE
  search_condition;
*/

/*
In this example, you add a WHERE clause to the SELECT statement to filter rows returned by the query. When evaluating a SELECT statement with a WHERE clause, SQLite uses the following steps:

First, check the table in the FROM clause.
Second, evaluate the conditions in the WHERE clause to get the rows that met these conditions.
Third, make the final result set based on the rows in the previous step with columns in the SELECT clause.
The search condition in the WHERE has the following form:

left_expression COMPARISON_OPERATOR right_expression
Code language: SQL (Structured Query Language) (sql)
For example, you can form a search condition as follows:

WHERE column_1 = 100;

WHERE column_2 IN (1,2,3);

WHERE column_3 LIKE 'An%';

WHERE column_4 BETWEEN 10 AND 20;

Besides the SELECT statement, you can use the WHERE clause in the UPDATE and DELETE statements.*/

/*
A comparison operator tests if two expressions are the same. The following table illustrates the comparison operators that you can use to construct expressions:

Operator	Meaning
=	Equal to
<> or !=	Not equal to
<	Less than
>	Greater than
<=	Less than or equal to
>=	Greater than or equal to
SQLite logical operators
Logical operators allow you to test the truth of some expressions. A logical operator returns 1, 0, or a NULL value.

Notice that SQLite does not provide Boolean data type therefore 1 means TRUE, and 0 means FALSE.

The following table illustrates the SQLite logical operators:

Operator	Meaning
ALL	returns 1 if all expressions are 1.
AND	returns 1 if both expressions are 1, and 0 if one of the expressions is 0.
ANY	returns 1 if any one of a set of comparisons is 1.
BETWEEN	returns 1 if a value is within a range.
EXISTS	returns 1 if a subquery contains any rows.
IN	returns 1 if a value is in a list of values.
LIKE	returns 1 if a value matches a pattern
NOT	reverses the value of other operators such as NOT EXISTS, NOT IN, NOT BETWEEN, etc.
OR	returns true if either expression is 1
*/
/*
The equality operator (=) is the most commonly used operator. For example, the following query uses the WHERE clause the equality operator to find all the tracks in the album id 1:
*/
SELECT
   name,
   milliseconds,
   bytes,
   albumid
FROM
   tracks
WHERE
   albumid = 1;

/*
SQLite compares the values stored in the AlbumId column with a literal value 1 to test if they are equal. Only the rows that satisfy the condition are returned.

When comparing two values, you need to ensure they are the same data type. You should compare numbers with numbers, string with strings, and so on.

In case you compare values in different data types e.g., a string with a number, SQLite has to perform implicit data type conversions, but in general, you should avoid doing this.

You use the logical operator to combine expressions. For example, to get tracks of the album 1 that have the length greater than 200,000 milliseconds, you use the following statement:
*/

SELECT
  name,
  milliseconds,
  bytes,
  albumid
FROM
  tracks
WHERE
  albumid = 1
  AND milliseconds > 250000;

/*
Using WHERE clause with LIKE operator example
Sometimes, you may not remember exactly the data you want to search. In this case, you perform an inexact search using the LIKE operator.

For example, to find which tracks were composed by Smith, you use the LIKE operator as follows:
*/
SELECT
  name,
  albumid,
  composer
FROM
  tracks
WHERE
  composer LIKE '%Smith%'
ORDER BY
  albumid;
/*
Using SQLite WHERE clause with the IN operator example
The IN operator allows you to check whether a value is in a list of a comma-separated list of values. For example, to find tracks that have media type id is 2 or 3, you use the IN operator as shown in the following statement:
*/
SELECT
	name,
	albumid,
	mediatypeid
FROM
	tracks
WHERE
	mediatypeid IN (2, 3);

/*
In SQLite, the AND operator allows you to combine two conditions in a WHERE clause to filter rows if all conditions are true.

Here’s the syntax of the AND operator:

A AND B
Code language: SQL (Structured Query Language) (sql)
In this syntax:

A and B are boolean expressions that evaluate a value of true, false, and null.
The AND operator returns true only if A and B are true.

The following table illustrates the result of the AND operator when combining two conditions A and B:

A	B	A AND B
false	false	false
false	true	false
true	false	false
true	true	true
false	NULL	false
true	NULL	NULL
NULL	false	false
NULL	true	NULL
NULL	NULL	NULL
*/
/*
The following statement uses the AND operator in the WHERE clause to get the invoices whose billing city is New York and Total is greater than 5:
*/
SELECT
  BillingAddress,
  BillingCity,
  Total
FROM
  invoices
WHERE
  BillingCity = 'New York'
  AND Total > 5
ORDER BY
  Total;

/*
The following example uses the AND operator with the OR operator to retrieve the invoices with the billing city as either New York or Chicago and the Total greater than 5.
*/

SELECT
  BillingAddress,
  BillingCity,
  Total
FROM
  invoices
WHERE
  Total > 5 AND
  (BillingCity = 'New York' OR BillingCity = 'Chicago')
ORDER BY
  Total;
