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
/*
In SQLite, the OR operator allows you to combine multiple conditions in a WHERE clause to filter rows based on at least one condition being true.

Here’s the syntax of the OR operator:

A OR B

In this syntax:

A and B are boolean expressions that evaluate to a value of true, false, or null.
If A and B are non-null, the OR operator returns true if either A or B is true.

The following table illustrates the result of the OR operator when combining two conditions A and B:

A	B	A OR B
false	false	false
false	true	true
true	false	true
true	true	true
false	NULL	NULL
true	NULL	true
NULL	false	NULL
NULL	true	true
NULL	NULL	NULL
*/

/*
The following example uses the OR operator to retrieve the invoices with the billing city is New York or Chicago:
*/

SELECT
  BillingAddress,
  BillingCity,
  Total
FROM
  invoices
WHERE
  BillingCity = 'New York'
  OR BillingCity = 'Chicago'
ORDER BY 
  BillingCity;

/*
The following statement uses the OR operator with the AND operator to retrieve the invoices with the billing city is either New York or Chicago and the Total is greater than 10:
*/

SELECT
  BillingAddress,
  BillingCity,
  Total
FROM
  invoices
WHERE
  (BillingCity = 'New York' OR BillingCity = 'Chicago') AND
  Total > 10
ORDER BY
  Total;

/*
The LIMIT clause is an optional part of the  SELECT statement. You use the LIMIT clause to constrain the number of rows returned by the query.

For example, a SELECT statement may return one million rows. However, if you just need the first 10 rows in the result set, you can add the LIMIT clause to the SELECT statement to retrieve 10 rows.

The following illustrates the syntax of the LIMIT clause.

SELECT
	column_list
FROM
	table
LIMIT row_count;
*/
/*
The row_count is a positive integer that specifies the number of rows returned.

For example, to get the first 10 rows in the tracks table, you use the following statement:
*/

SELECT
	trackId,
	name
FROM
	tracks
LIMIT 10;

/*
If you want to get the first 10 rows starting from the 10th row of the result set, you use OFFSET keyword as the following:

SELECT
	column_list
FROM
	table
LIMIT row_count OFFSET offset;

Or you can use the following shorthand syntax of the LIMIT OFFSET clause:

SELECT
	column_list
FROM
	table
LIMIT offset, row_count;

For example, to get 10 rows starting from the 11th row in the tracks table, you use the following statement:
*/
SELECT
	trackId,
	name
FROM
	tracks
LIMIT 10 OFFSET 10;

/*
You often find the uses of OFFSET in web applications for paginating result sets.

You should always use the LIMIT clause with the  ORDER BY clause. Because you want to get a number of rows in a specified order, not in an unspecified order.

The ORDER BY clause appears before the LIMIT clause in the SELECT statement. SQLite sorts the result set before getting the number of rows specified in the LIMIT clause.

SELECT
   column_list
FROM
   table
ORDER BY column_1
LIMIT row_count;

For example, to get the top 10 biggest tracks by size, you use the following query:
*/

SELECT
	trackid,
	name,
	bytes
FROM
	tracks
ORDER BY
	bytes DESC
LIMIT 10;

/*
To get the 5 shortest tracks, you sort the tracks by the length specified by milliseconds column using ORDER BY clause and get the first 5 rows using LIMIT clause.
*/

SELECT
	trackid,
	name,
	milliseconds
FROM
	tracks
ORDER BY
	milliseconds ASC
LIMIT 5;

/*
Getting the nth highest and the lowest value
You can use the ORDER BY and LIMIT clauses to get the nth highest or lowest value rows. For example, you may want to know the second-longest track, the third smallest track, etc.

To do this, you use the following steps:

First, use ORDER BY to sort the result set in ascending order in case you want to get the nth lowest value, or descending order if you want to get the nth highest value.
Second, use the LIMIT OFFSET clause to get the nth highest or the nth lowest row.
The following statement returns the second-longest track in the tracks table.
*/

SELECT
	trackid,
	name,
	milliseconds
FROM
	tracks
ORDER BY
	milliseconds DESC
LIMIT 1 OFFSET 1;

/*
The following statement gets the third smallest track on the tracks table.
*/
SELECT
	trackid,
	name,
	bytes
FROM
	tracks
ORDER BY
	bytes
LIMIT 1 OFFSET 2;

/*

The BETWEEN operator is a logical operator that tests whether a value is in range of values. If the value is in the specified range, the BETWEEN operator returns true. The BETWEEN operator can be used in the WHERE clause of the SELECT, DELETE, UPDATE, and REPLACE statements.

The following illustrates the syntax of the SQLite BETWEEN operator:

test_expression BETWEEN low_expression AND high_expression

In this syntax:

test_expression is an expression to test for in the range defined by low_expression and high_expression.
low_expression and high_expression is any valid expression that specify the low and high values of the range. The low_expression should be less than or equal to high_expression, or the BETWEEN is always returns false.
The AND keyword is a placeholder which indicates the test_expression should be within the range specified by low_expression and high_expression.
Note that the BETWEEN operator is inclusive. It returns true when the test_expression is less than or equal to high_expression and greater than or equal to the value of low_expression:

test_expression >= low_expression AND test_expression <= high_expression
To specify an exclusive range, you use the greater than (>) and less than operators (<).

Note that if any input to the BETWEEN operator is NULL, the result is NULL, or unknown to be precise.

To negate the result of the BETWEEN operator, you use the NOT BETWEEN operator as follows:

test_expression NOT BETWEEN low_expression AND high_expression
The NOT BETWEEN returns true if the value of test_expression is less than the value of low_expression or greater than the value of high_expression:

test_expression < low_expression OR test_expression > high_expression
*/

/*

SQLite BETWEEN numeric values example
The following statement finds invoices whose total is between 14.91 and 18.86:
*/
SELECT
    InvoiceId,
    BillingAddress,
    Total
FROM
    invoices
WHERE
    Total BETWEEN 14.91 and 18.86    
ORDER BY
    Total;

/*
To find the invoices whose total are not between 1 and 20, you use the NOT BETWEEN operator as shown in the following query:
*/

SELECT
    InvoiceId,
    BillingAddress,
    Total
FROM
    invoices
WHERE
    Total NOT BETWEEN 1 and 20
ORDER BY
    Total;

/*
As clearly shown in the output, the result includes the invoices whose total is less than 1 and greater than 20.

The following example finds invoices whose invoice dates are from January 1 2010 and January 31 2010:
*/
SELECT
    InvoiceId,
    BillingAddress,
    InvoiceDate,
    Total
FROM
    invoices
WHERE
    InvoiceDate BETWEEN '2010-01-01' AND '2010-01-31'
ORDER BY
    InvoiceDate;

/*
The following statement finds invoices whose dates are not between January 03, 2009, and December 01, 2013:
*/

SELECT
    InvoiceId,
    BillingAddress,
    date(InvoiceDate) InvoiceDate,
    Total
FROM
    invoices
WHERE
    InvoiceDate NOT BETWEEN '2009-01-03' AND '2013-12-01'
ORDER BY
    InvoiceDate;

WITH Count as (
	Select COUNT(*) as cnt from tracks )
SELECT 
    TrackId, 
    Name, 
    Composer 
FROM 
    tracks
ORDER BY 
    Composer NULLS LAST
LIMIT 10 OFFSET (select cnt from count) - 10;

/*
The SQLite IN operator determines whether a value matches any value in a list or a subquery. The syntax of the IN operator is as follows:

expression [NOT] IN (value_list|subquery);
The expression can be any valid expression or a column of a table.

A list of values is a fixed value list or a result set of a single column returned by a subquery. The returned type of expression and values in the list must be the same.

The IN operator returns true or false depending on whether the expression matches any value in a list of values or not. To negate the list of values, you use the NOT IN operator.
*/
/*
The following statement uses the IN operator to query the tracks whose media type id is 1 or 2.
*/
SELECT
	TrackId,
	Name,
	Mediatypeid
FROM
	Tracks
WHERE
	MediaTypeId IN (1, 2)
ORDER BY
	Name ASC;

/*
This query uses the OR operator instead of the IN operator to return the same result set as the above query:
*/
SELECT
	TrackId,
	Name,
	MediaTypeId
FROM
	Tracks
WHERE
	MediaTypeId = 1 OR MediaTypeId = 2
ORDER BY
	Name ASC;
/*
As you can see from the queries, using the IN operator is much shorter.
*/

/*
If you have a query that uses many OR operators, you can consider using the IN operator instead to make the query more readable.
*/
/*
The following query returns a list of album id of the artist id 12:
*/
SELECT albumid
FROM albums
WHERE artistid = 12;

/*
To get the tracks that belong to the artist id 12, you can combine the IN operator with a subquery as follows:
*/
SELECT
	TrackId, 
	Name, 
	AlbumId
FROM
	Tracks
WHERE
	AlbumId IN (
		SELECT
			AlbumId
		FROM
			Albums
		WHERE
			ArtistId = 12
	);

/*
First, the subquery returns a list of album ids that belong to the artist id 12.
Then, the outer query return all tracks whose album id matches with the album id list returned by the subquery.
*/

/*
The following statement returns a list of tracks whose genre id is not in a list of (1,2,3).
*/
SELECT
	trackid,
	name,
	genreid
FROM
	tracks
WHERE
	genreid NOT IN (1, 2,3);

/*
Sometimes, you don’t know exactly the complete keyword that you want to query. For example, you may know that your most favorite song contains the word,elevator but you don’t know exactly the name.

To query data based on partial information, you use the LIKE operator in the WHERE clause of the SELECT statement as follows:

SELECT
	column_list
FROM
	table_name
WHERE
	column_1 LIKE pattern;
*/
/*
Note that you can also use the LIKE operator in the WHERE clause of other statements such as the DELETE and UPDATE.

SQLite provides two wildcards for constructing patterns. They are percent sign % and underscore _ :

The percent sign % wildcard matches any sequence of zero or more characters.
The underscore _ wildcard matches any single character.
The percent sign % wildcard examples
The s% pattern that uses the percent sign wildcard ( %) matches any string that starts with s e.g.,son and so.

The %er pattern matches any string that ends with er like peter, clever, etc.

And the %per% pattern matches any string that contains per such as percent and peeper.

The underscore _ wildcard examples
The h_nt pattern matches hunt, hint, etc. The __pple pattern matches topple, supple, tipple, etc.
Note that SQLite LIKE operator is case-insensitive. It means "A" LIKE "a" is true.

However, for Unicode characters that are not in the ASCII ranges, the LIKE operator is case sensitive e.g., "Ä" LIKE "ä" is false.
In case you want to make LIKE operator works case-sensitively, you need to use the following PRAGMA:
*/
PRAGMA case_sensitive_like = true;

/*

To find the tracks whose names start with the Wild literal string, you use the percent sign % wildcard at the end of the pattern.
*/
SELECT
	trackid,
	name	
FROM
	tracks
WHERE
	name LIKE 'Wild%';

/*

To find the tracks whose names end with Wild word, you use % wildcard at the beginning of the pattern.
*/
SELECT
	trackid,
	name
FROM
	tracks
WHERE
	name LIKE '%Wild';

/*	
To find the tracks whose names contain the Wild literal string, you use % wildcard at the beginning and end of the pattern:
*/

SELECT
	trackid,
	name	
FROM
	tracks
WHERE
	name LIKE '%Wild%';

/*
The following statement finds the tracks whose names contain: zero or more characters (%), followed by Br, followed by a character ( _), followed by wn, and followed by zero or more characters ( %).
*/
SELECT
	trackid,
	name
FROM
	tracks
WHERE
	name LIKE '%Br_wn%';

/*
If the pattern that you want to match contains % or _, you must use an escape character in an optional ESCAPE clause as follows:

column_1 LIKE pattern ESCAPE expression;
When you specify the ESCAPE clause, the LIKE operator will evaluate the expression that follows the ESCAPE keyword to a string which consists of a single character, or an escape character.

Then you can use this escape character in the pattern to include literal percent sign (%) or underscore (_).  The LIKE operator evaluates the percent sign (%) or underscore (_) that follows the escape character as a literal string, not a wildcard character.

Suppose you want to match the string 10% in a column of a table. However, SQLite interprets the percent symbol % as the wildcard character. Therefore,  you need to escape this percent symbol % using an escape character:

column_1 LIKE '%10\%%' ESCAPE '\';
In this expression, the LIKE operator interprets the first % and last % percent signs as wildcards and the second percent sign as a literal percent symbol.

Note that you can use other characters as the escape character e.g., /, @, $.
*/
/*
Consider the following example:

First, create a table t that has one column:
*/
drop table if exists t;

CREATE TABLE t(
	c TEXT
);
/*
Next, insert some rows into the table t:
*/
INSERT INTO t(c)
VALUES('10% increase'),
	('10 times decrease'),
	('100% vs. last year'),
	('20% increase next year');

/*	Then, query data from the t table:
*/

SELECT * FROM t;
/*	
Fourth, attempt to find the row whose value in the c column contains the 10% literal string:
*/
SELECT c 
FROM t 
WHERE c LIKE '%10%%';
/*
However, it returns rows whose values in the c column contains 10:

*/                 
/*
Fifth, to get the correct result, you use the ESCAPE clause as shown in the following query:
*/
SELECT c 
FROM t 
WHERE c LIKE '%10\%%' ESCAPE '\';

/*
The GLOB operator is similar to the LIKE operator. The GLOB operator determines whether a string matches a specific pattern.

Unlike the LIKE operator, the GLOB operator is case sensitive and uses the UNIX wildcards. In addition, the GLOB patterns do not have escape characters.

The following shows the wildcards used with the GLOB  operator:

The asterisk (*) wildcard matches any number of characters.
The question mark (?) wildcard matches exactly one character.
On top of these wildcards, you can use the list wildcard [] to match one character from a list of characters. For example [xyz] match any single x, y, or z character.

The list wildcard also allows a range of characters e.g., [a-z] matches any single lowercase character from a to z. The [a-zA-Z0-9] pattern matches any single alphanumeric character, both lowercase, and uppercase.

Besides, you can use the character ^ at the beginning of the list to match any character except for any character in the list. For example, the [^0-9] pattern matches any single character except a numeric character.

The following statement finds tracks whose names start with the string Man. The pattern Man* matches any string that starts with Man.
*/
SELECT
	trackid,
	name
FROM
	tracks
WHERE
	name GLOB 'Man*';

/*
The following statement gets the tracks whose names end with Man. The pattern *Man matches any string that ends with Man.
*/

SELECT
	trackid,
	name
FROM
	tracks
WHERE
	name GLOB '*Man';

/*
The following query finds the tracks whose names start with any single character (?), followed by the string ere and then any number of character (*).
*/

SELECT
	trackid,
	name
FROM
	tracks
WHERE
	name GLOB '?ere*';

/*
To find the tracks whose names contain numbers, you can use the list wildcard [0-9] as follows:
*/
SELECT
	trackid,
	name
FROM
	tracks
WHERE
	name GLOB '*[1-9]*';

/*
Or to find the tracks whose name does not contain any number, you place the character ^ at the beginning of the list:
*/

SELECT
	trackid,
	name
FROM
	tracks
WHERE
	name GLOB '*[^1-9]*';

/*
The following statement finds the tracks whose names end with a number.
*/
SELECT
	trackid,
	name
FROM
	tracks
WHERE
	name GLOB '*[1-9]';

/*
NULL is special. It indicates that a piece of information is unknown or not applicable.

For example, some songs may not have the songwriter information because we don’t know who wrote them.

To store these unknown songwriters along with the songs in a database table, we must use NULL.

NULL is not equal to anything even the number zero, an empty string, and so on.

Especially, NULL is not equal to itself. The following expression returns 0:

NULL = NULL
This is because two unknown information cannot be comparable.
*/

/*
The following statement attempts to find tracks whose composers are NULL:
*/
SELECT
    Name, 
    Composer
FROM
    tracks
WHERE
    Composer = NULL;
/*
It returns an empty row without issuing any additional message.

This is because the following expression always evaluates to false:

Composer = NULL
It’s not valid to use the NULL this way.

To check if a value is NULL or not, you use the IS NULL operator instead:

{ column | expression } IS NULL;
The IS NULL operator returns 1 if the column or expression evaluates to NULL.

To find all tracks whose composers are unknown, you use the IS NULL operator as shown in the following query:
*/
SELECT
    Name, 
    Composer
FROM
    tracks
WHERE
    Composer IS NULL
ORDER BY 
    Name;

/*
The NOT operator negates the IS NULL operator as follows:

expression | column IS NOT NULL
The IS NOT NULL operator returns 1 if the expression or column is not NULL, and 0 if the expression or column is NULL.

The following example finds tracks whose composers are not NULL:
*/
SELECT
    Name, 
    Composer
FROM
    tracks
WHERE
    Composer IS NOT NULL
ORDER BY 
    Name;

/*
In relational databases, data is often distributed in many related tables. A table is associated with another table using foreign keys.

To query data from multiple tables, you use INNER JOIN clause. The INNER JOIN clause combines columns from correlated tables.

Suppose you have two tables: A and B.

A has a1, a2, and f columns. B has b1, b2, and f column. The A table links to the B table using a foreign key column named f.

The following illustrates the syntax of the inner join clause:
	
SELECT a1, a2, b1, b2
FROM A
INNER JOIN B on B.f = A.f;
For each row in the A table, the INNER JOIN clause compares the value of the f column with the value of the f column in the B table. If the value of the f column in the A table equals the value of the f column in the B table, it combines data from a1, a2, b1, b2, columns and includes this row in the result set.

In other words, the INNER JOIN clause returns rows from the A table that have the corresponding row in B table.

This logic is applied if you join more than 2 tables
*/

/*

In the tracks table, the AlbumId column is a foreign key. And in the albums table, the AlbumId is the primary key.

To query data from both tracks and albums tables, you use the following statement:
*/
SELECT
	trackid,
	name,
	title
FROM
	tracks
INNER JOIN albums ON albums.albumid = tracks.albumid;

/*
For each row in the tracks table, SQLite uses the value in the albumid column of the tracks table to compare with the value in the albumid of the albums table. If SQLite finds a match, it combines data of rows in both tables in the result set.

You can include the AlbumId columns from both tables in the final result set to see the effect.
*/
SELECT
    trackid,
    name,
    tracks.albumid AS album_id_tracks,
    albums.albumid AS album_id_albums,
    title
FROM
    tracks
    INNER JOIN albums ON albums.albumid = tracks.albumid;

/*
See the following tables:tracks albums and artists


One track belongs to one album and one album has many tracks. The tracks table associated with the albums table via albumid column.

One album belongs to one artist and one artist has one or many albums. The albums table links to the artists table via artistid column.

To query data from these tables, you need to use two inner join clauses in the SELECT statement as follows:
*/
SELECT
    trackid,
    tracks.name AS track,
    albums.title AS album,
    artists.name AS artist
FROM
    tracks
    INNER JOIN albums ON albums.albumid = tracks.albumid
    INNER JOIN artists ON artists.artistid = albums.artistid;
/*
You can use a WHERE clause to get the tracks and albums of the artist with id 10 as the following statement:
*/
SELECT
        albums.artistid as artistid,
	trackid,
	tracks.name AS Track,
	albums.title AS Album,
	artists.name AS Artist
FROM
	tracks
INNER JOIN albums ON albums.albumid = tracks.albumid
INNER JOIN artists ON artists.artistid = albums.artistid
WHERE
	artists.artistid = 10;

/*
Similar to the INNER JOIN clause, the LEFT JOIN clause is an optional clause of the SELECT statement. You use the LEFT JOIN clause to query data from multiple related tables.

Suppose we have two tables: A and B.

A has m and f columns.
B has n and f columns.
To perform join between A and B using LEFT JOIN clause, you use the following statement:

SELECT
	a,
	b
FROM
	A
LEFT JOIN B ON A.f = B.f
WHERE search_condition;
*/
/*
The expression A.f = B.f is a conditional expression. Besides the equality (=) operator, you can use other comparison operators such as greater than (>), less than (<), etc.

The statement returns a result set that includes:

Rows in table A (left table) that have corresponding rows in table B.
Rows in the table A table and the rows in the table B filled with NULL values in case the row from table A does not have any corresponding rows in table B.
In other words, all rows in table A are included in the result set whether there are matching rows in table B or not.

In case you have a WHERE clause in the statement, the search_condition in the WHERE clause is applied after the matching of the LEFT JOIN clause completes.

It is noted that LEFT OUTER JOIN is the same as LEFT JOIN.
 */

/*

One album belongs to one artist. However, one artist may have zero or more albums.

To find artists who do not have any albums by using the LEFT JOIN clause, we select artists and their corresponding albums. If an artist does not have any albums, the value of the AlbumId column is NULL.

To display the artists who do not have any albums first, we have two choices:

First, use ORDER BY clause to list the rows whose AlbumId is NULL values first.
Second, use WHERE clause and IS NULL operator to list only artists who do not have any albums.
The following statement uses the LEFT JOIN clause with the ORDER BY clause.
*/
SELECT
   artists.ArtistId, 
   AlbumId
FROM
   artists
LEFT JOIN albums ON
   albums.ArtistId = artists.ArtistId
ORDER BY
   AlbumId;
/*
The following statement uses the LEFT JOIN clause with the WHERE clause.
*/
SELECT
   artists.ArtistId
   , AlbumId
FROM
   artists
LEFT JOIN albums ON
   albums.ArtistId = artists.ArtistId
WHERE
   AlbumId IS NULL;

/*
In SQLite, the RIGHT JOIN clause allows you to combine rows from two tables based on a related column between them.

The RIGHT JOIN clause returns all rows from the right table and matching rows from the left table. For non-matching rows in the left table, it uses NULL values.

Here’s the syntax of the RIGHT JOIN clause:

SELECT
  select_list
FROM
  table1
  RIGHT JOIN table2 ON table1.column_name1 = table2.column_name2;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

table1 and table2 are the left and right tables respectively.
column_name1 and column_name2 are the related column that links the two tables. Note that they may have the same name.
The RIGHT JOIN clause will return all rows from the right table (table2) and matching rows from the left table (table1).

For rows from the right table (table2) that do not have matching rows from the left table( table1), it uses NULL values for columns of the left table (table1).

If table1 and table2 have the same column_name, you can use the USING syntax:

SELECT
  select_list
FROM
  table1
  RIGHT JOIN table2 USING (column_name);
Code language: SQL (Structured Query Language) (sql)
Notice that USING (column_name) and ON table1.column_name = table2.column_name are the equivalent.

To find rows from the right table (table2) that does not have matching rows in the left table (table1), you can check if the column_name IS NULL in a WHERE clause as follows:

SELECT
  select_list
FROM
  table1
  RIGHT JOIN table2 USING (column_name)
WHERE
  column_name IS NULL;
 */

/*

Let’s take an example of using the RIGHT JOIN clause.

First, create new tables called departments and employees:
*/

drop table if exists emps;
drop table if exists departments;
CREATE TABLE departments (
    department_id INTEGER PRIMARY KEY,
    department_name TEXT NOT NULL
);

CREATE TABLE emps (
    employee_id INTEGER PRIMARY KEY,
    employee_name TEXT NOT NULL,
    department_id INTEGER,
    FOREIGN KEY(department_id) 
        REFERENCES departments(department_id) ON DELETE CASCADE
);
/*
In these tables, the emps table has the department_id column that references the department_id column of the departments table. This relationship is established via a foreign key constraint.

Second, insert rows into the departments and emps tables:
*/
INSERT INTO departments (department_name ) 
VALUES ('HR'),
       ('IT');

INSERT INTO emps (employee_name , department_id ) 
VALUES 
   ('John', 1),
   ('Jane', 2),
   ('Alice', NULL);
/*
Since both emps and departments tables
 have the department_id column, you can use the USING clause:
*/
SELECT
  employee_name,
  department_name
FROM
  departments
  RIGHT JOIN emps USING (department_id);
/*
It should return the same result set of the query that uses the ON clause.

Finally, find all employees who do not have a department using the IS NULL condition in a WHERE clause:
*/
SELECT
  employee_name,
  department_name
FROM
  departments
  RIGHT JOIN emps ON emps.department_id = departments.department_id
WHERE
  department_name IS NULL;
