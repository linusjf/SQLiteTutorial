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
  10 / 5 AS div,
  2 * 4 AS mult;

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
SELECT
  *
FROM
  albums;

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
LIMIT
  5;

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
LIMIT
  5;

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
  trackid,
  name,
  composer
FROM
  tracks
ORDER BY
  composer
LIMIT
  10;

/*
The following example uses the NULLS LAST option to place NULLs after other values:
*/
SELECT
  trackid,
  name,
  composer
FROM
  tracks
ORDER BY
  composer NULLS LAST
LIMIT
  10
OFFSET
  (
    SELECT COUNT(*)
    FROM
      tracks
  ) - 10;

SELECT
  trackid,
  name,
  composer
FROM
  tracks
ORDER BY
  composer DESC NULLS FIRST
LIMIT
  10;

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
FROM
  customers
ORDER BY
  city;

/*
It returns 59 rows. There are a few duplicate rows such as Berlin London, and Mountain View To remove these duplicate rows, you use the DISTINCT clause as follows:
*/
SELECT DISTINCT city
FROM
  customers
ORDER BY
  city;

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
SELECT company
FROM
  customers;

/*
It returns 59 rows with many NULL values.

Now, if you apply the DISTINCT clause to the statement, it will keep only one row with a NULL value.
*/
/*
See the following statement:
*/
SELECT DISTINCT company
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
  billingaddress,
  billingcity,
  total
FROM
  invoices
WHERE
  billingcity = 'New York'
  AND total > 5
ORDER BY
  total;

/*
The following example uses the AND operator with the OR operator to retrieve the invoices with the billing city as either New York or Chicago and the Total greater than 5.
*/
SELECT
  billingaddress,
  billingcity,
  total
FROM
  invoices
WHERE
  total > 5
  AND (
    billingcity = 'New York'
    OR billingcity = 'Chicago'
  )
ORDER BY
  total;

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
  billingaddress,
  billingcity,
  total
FROM
  invoices
WHERE
  billingcity = 'New York'
  OR billingcity = 'Chicago'
ORDER BY
  billingcity;

/*
The following statement uses the OR operator with the AND operator to retrieve the invoices with the billing city is either New York or Chicago and the Total is greater than 10:
*/
SELECT
  billingaddress,
  billingcity,
  total
FROM
  invoices
WHERE
  (
    billingcity = 'New York'
    OR billingcity = 'Chicago'
  )
  AND total > 10
ORDER BY
  total;

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
  trackid,
  name
FROM
  tracks
LIMIT
  10;

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
  trackid,
  name
FROM
  tracks
LIMIT
  10
OFFSET
  10;

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
LIMIT
  10;

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
LIMIT
  5;

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
LIMIT
  1
OFFSET
  1;

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
LIMIT
  1
OFFSET
  2;

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
  invoiceid,
  billingaddress,
  total
FROM
  invoices
WHERE
  total BETWEEN 14.91 AND 18.86
ORDER BY
  total;

/*
To find the invoices whose total are not between 1 and 20, you use the NOT BETWEEN operator as shown in the following query:
*/
SELECT
  invoiceid,
  billingaddress,
  total
FROM
  invoices
WHERE
  total NOT BETWEEN 1 AND 20
ORDER BY
  total;

/*
As clearly shown in the output, the result includes the invoices whose total is less than 1 and greater than 20.

The following example finds invoices whose invoice dates are from January 1 2010 and January 31 2010:
*/
SELECT
  invoiceid,
  billingaddress,
  invoicedate,
  total
FROM
  invoices
WHERE
  invoicedate BETWEEN '2010-01-01' AND '2010-01-31'
ORDER BY
  invoicedate;

/*
The following statement finds invoices whose dates are not between January 03, 2009, and December 01, 2013:
*/
SELECT
  invoiceid,
  billingaddress,
  DATE(invoicedate) AS invoicedate,
  total
FROM
  invoices
WHERE
  invoicedate NOT BETWEEN '2009-01-03' AND '2013-12-01'
ORDER BY
  invoicedate;

--noqa: disable=RF02
WITH
  count AS (
    SELECT COUNT(*) AS cnt
    FROM
      tracks
  )
SELECT
  trackid,
  name,
  composer
FROM
  tracks
ORDER BY
  composer NULLS LAST
LIMIT
  10
OFFSET
  (
    SELECT cnt
    FROM
      count
  ) - 10;

--noqa: enable=RF02
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
  trackid,
  name,
  mediatypeid
FROM
  tracks
WHERE
  mediatypeid IN (1, 2)
ORDER BY
  name ASC;

/*
This query uses the OR operator instead of the IN operator to return the same result set as the above query:
*/
SELECT
  trackid,
  name,
  mediatypeid
FROM
  tracks
WHERE
  mediatypeid = 1
  OR mediatypeid = 2
ORDER BY
  name ASC;

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
FROM
  albums
WHERE
  artistid = 12;

/*
To get the tracks that belong to the artist id 12, you can combine the IN operator with a subquery as follows:
*/
--noqa: disable=RF02
SELECT
  trackid,
  name,
  albumid
FROM
  tracks
WHERE
  albumid IN (
    SELECT albumid
    FROM
      albums
    WHERE
      artistid = 12
  );

--noqa: enable=RF02
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
  genreid NOT IN (1, 2, 3);

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
PRAGMA case_sensitive_like = TRUE;

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
DROP TABLE IF EXISTS t;

CREATE TABLE t (c TEXT);

/*
Next, insert some rows into the table t:
*/
INSERT INTO
  t (c)
VALUES
  ('10% increase'),
  ('10 times decrease'),
  ('100% vs. last year'),
  ('20% increase next year');

/*	Then, query data from the t table:
*/
SELECT
  *
FROM
  t;

/*
Fourth, attempt to find the row whose value in the c column contains the 10% literal string:
*/
SELECT c
FROM
  t
WHERE
  c LIKE '%10%%';

/*
However, it returns rows whose values in the c column contains 10:

*/
/*
Fifth, to get the correct result, you use the ESCAPE clause as shown in the following query:
*/
SELECT c
FROM
  t
WHERE
  c LIKE '%10\%%' ESCAPE '\';

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
  name,
  composer
FROM
  tracks
WHERE
  composer IS NULL;

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
  name,
  composer
FROM
  tracks
WHERE
  composer IS NULL
ORDER BY
  name;

/*
The NOT operator negates the IS NULL operator as follows:

expression | column IS NOT NULL
The IS NOT NULL operator returns 1 if the expression or column is not NULL, and 0 if the expression or column is NULL.

The following example finds tracks whose composers are not NULL:
*/
SELECT
  name,
  composer
FROM
  tracks
WHERE
  composer IS NOT NULL
ORDER BY
  name;

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
  tracks.trackid,
  tracks.name,
  albums.title
FROM
  tracks
  INNER JOIN albums ON tracks.albumid = albums.albumid;

/*
For each row in the tracks table, SQLite uses the value in the albumid column of the tracks table to compare with the value in the albumid of the albums table. If SQLite finds a match, it combines data of rows in both tables in the result set.

You can include the AlbumId columns from both tables in the final result set to see the effect.
*/
SELECT
  tracks.trackid,
  tracks.name,
  tracks.albumid AS album_id_tracks,
  albums.albumid AS album_id_albums,
  albums.title
FROM
  tracks
  INNER JOIN albums ON tracks.albumid = albums.albumid;

/*
See the following tables:tracks albums and artists


One track belongs to one album and one album has many tracks. The tracks table associated with the albums table via albumid column.

One album belongs to one artist and one artist has one or many albums. The albums table links to the artists table via artistid column.

To query data from these tables, you need to use two inner join clauses in the SELECT statement as follows:
*/
SELECT
  tracks.trackid,
  tracks.name AS track,
  albums.title AS album,
  artists.name AS artist
FROM
  tracks
  INNER JOIN albums ON tracks.albumid = albums.albumid
  INNER JOIN artists ON albums.artistid = artists.artistid;

/*
You can use a WHERE clause to get the tracks and albums of the artist with id 10 as the following statement:
*/
SELECT
  albums.artistid,
  tracks.trackid,
  tracks.name AS track,
  albums.title AS album,
  artists.name AS artist
FROM
  tracks
  INNER JOIN albums ON tracks.albumid = albums.albumid
  INNER JOIN artists ON albums.artistid = artists.artistid
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
  artists.artistid,
  albums.albumid
FROM
  artists
  LEFT JOIN albums ON artists.artistid = albums.artistid
ORDER BY
  albums.albumid;

/*
The following statement uses the LEFT JOIN clause with the WHERE clause.
*/
SELECT
  artists.artistid,
  albums.albumid
FROM
  artists
  LEFT JOIN albums ON artists.artistid = albums.artistid
WHERE
  albums.albumid IS NULL;

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
DROP TABLE IF EXISTS emps;

DROP TABLE IF EXISTS departments;

CREATE TABLE departments (
  department_id INTEGER PRIMARY KEY,
  department_name TEXT NOT NULL
);

CREATE TABLE emps (
  employee_id INTEGER PRIMARY KEY,
  employee_name TEXT NOT NULL,
  department_id INTEGER,
  FOREIGN KEY (department_id) REFERENCES departments (department_id) ON DELETE CASCADE
);

/*
In these tables, the emps table has the department_id column that references the department_id column of the departments table. This relationship is established via a foreign key constraint.

Second, insert rows into the departments and emps tables:
*/
INSERT INTO
  departments (department_name)
VALUES
  (' HR '),
  (' IT ');

INSERT INTO
  emps (employee_name, department_id)
VALUES
  (' John ', 1),
  (' Jane ', 2),
  (' Alice ', NULL);

/*
Since both emps and departments tables
have the department_id column, you can use the USING clause:
*/
--noqa:disable=CV08
SELECT
  emps.employee_name,
  departments.department_name
FROM
  departments
  RIGHT JOIN emps USING (department_id);

/*
It should return the same result set of the query that uses the ON clause.

Finally, find all employees who do not have a department using the IS NULL condition in a WHERE clause:
*/
SELECT
  emps.employee_name,
  departments.department_name
FROM
  departments
  RIGHT JOIN emps ON departments.department_id = emps.department_id
WHERE
  departments.department_name IS NULL;

--noqa:enable=CV08
/*
If you use a LEFT JOIN, INNER JOIN, or CROSS JOIN without the ON or USING clause, SQLite produces a cartesian product of the involved tables. The number of rows in the cartesian product is the product of the number of rows in each table.

Suppose, we have two tables A and B. The following statements perform the cross join and produce a cartesian product of the rows from the A and B tables.

SELECT *
FROM A JOIN B;
SELECT *
FROM A
INNER JOIN B;
SELECT *
FROM A
CROSS JOIN B;
SELECT *
FROM A, B;

Suppose, the A table has n rows and B table has m rows, the CROSS JOIN of these two tables will produce a result set that includes nxm rows.

Imagine that if you have the third table C with k rows, the result of the CROSS JOIN clause of these three tables will contain nxmxk rows, which may be very huge. Therefore, you should be very careful when using the CROSS JOIN clause.

You use the INNER JOIN and LEFT JOIN clauses more often than the CROSS JOIN clause. However, you will find the CROSS JOIN clause very useful in some cases.

For example, when you want to have a matrix that has two dimensions filled with data like members and date data in a membership database. You want to check the member attendance for all relevant dates. In this case, you may use the CROSS JOIN clause as the following statement:

SELECT
name,
date
FROM
members
CROSS JOIN dates;
*/
/*
The following statements create the ranks and suits tables that store the ranks and suits for a deck of cards and insert data into these two tables.
*/
DROP TABLE IF EXISTS ranks;

DROP TABLE IF EXISTS suits;

CREATE TABLE ranks (rank TEXT NOT NULL);

CREATE TABLE suits (suit TEXT NOT NULL);

INSERT INTO
  ranks (rank)
VALUES
  (' 2 '),
  (' 3 '),
  (' 4 '),
  (' 5 '),
  (' 6 '),
  (' 7 '),
  (' 8 '),
  (' 9 '),
  (' 10 '),
  (' J '),
  (' Q '),
  (' K '),
  (' A ');

INSERT INTO
  suits (suit)
VALUES
  (' Clubs '),
  (' Diamonds '),
  (' Hearts '),
  (' Spades ');

/*
The following statement uses the CROSS JOIN clause to return a complete deck of cards data:
*/
SELECT
  ranks.rank,
  suits.suit
FROM
  ranks
  CROSS JOIN suits
ORDER BY
  suits.suit;

/*
In SQLite, a FULL OUTER JOIN clause allows you to combine rows from two tables based on a related column.

The FULL OUTER JOIN clause returns all rows from the first and second tables. If there are no matching rows in one of the tables, it uses NULL to represent the missing values.

Notice that the result of a FULL OUTER JOIN is a combination of  the results of a LEFT JOIN and a RIGHT JOIN.

Here’s the syntax of the FULL OUTER JOIN clause:

SELECT select_list
FROM table1
FULL OUTER JOIN table2 ON table2.column2 = table2.column1;
In this syntax:

table1 and table2 are the names of the related tables that you want to combine rows.
column1 and column2 are the related columns that link the two tables. Typically, these columns have the same.
If the related columns (column1 and column2) have the same name (column_name), you can use the USING syntax:

SELECT select_list
FROM table1
FULL OUTER JOIN table2 USING (column_name);

Please note that FULL OUTER JOIN and FULL JOIN are the same because the OUTER keyword is optional.

If you want to find rows from the table1 that do not have matching rows in the table2, you can use the following statement:

SELECT
select_list
FROM
table1
FULL OUTER JOIN table2 USING (column_name)
WHERE
table2.column_name IS NULL;
Similarly, you can find rows from the table2 that do not have matching rows in the table1 using the following query:

SELECT
select_list
FROM
table1
FULL OUTER JOIN table2 USING (column_name)
WHERE
table1.column_name IS NULL;
*/
/*
First, create three tables called students, courses, and enrollments:
*/
DROP TABLE IF EXISTS enrollments;

DROP TABLE IF EXISTS courses;

DROP TABLE IF EXISTS students;

CREATE TABLE students (
  student_id INTEGER PRIMARY KEY,
  student_name TEXT NOT NULL
);

CREATE TABLE courses (
  course_id INTEGER PRIMARY KEY,
  course_name TEXT NOT NULL
);

CREATE TABLE enrollments (
  enrollment_id INTEGER PRIMARY KEY,
  student_id INTEGER,
  course_id INTEGER,
  FOREIGN KEY (student_id) REFERENCES students (student_id),
  FOREIGN KEY (course_id) REFERENCES courses (course_id)
);

/*
Second, insert rows into these tables:
*/
INSERT INTO
  students (student_name)
VALUES
  (' John '),
  (' Jane '),
  (' Doe '),
  (' Alice '),
  (' Bob ');

INSERT INTO
  courses (course_name)
VALUES
  (' Math '),
  (' Science '),
  (' History ');

INSERT INTO
  enrollments (student_id, course_id)
VALUES
  (1, 1),
  (2, 2),
  (3, 3),
  (4, NULL),
  (NULL, 3);

/*
Third, use the FULL OUTER JOIN clause to find student enrollments:
*/
SELECT
  studs.student_name,
  courses.course_name
FROM
  students AS studs
  FULL OUTER JOIN enrollments ON studs.student_id = enrollments.student_id
  FULL OUTER JOIN courses ON enrollments.course_id = courses.course_id;

/*
The output shows that Alice and Bob do not enroll in any courses and no student is enrolled in the History course.

Since the tables share the same column names, you can use the USING syntax:
*/
--noqa: disable=ST11
SELECT
  students.student_name,
  courses.course_name
FROM
  students
  FULL OUTER JOIN enrollments USING (student_id)
  FULL OUTER JOIN courses USING (course_id);

/*
It should return the same result set as the query above.
*/
/*
Fourth, find students who have not enrolled in any courses:
*/
SELECT
  students.student_name,
  courses.course_name
FROM
  students
  FULL OUTER JOIN enrollments USING (student_id)
  FULL OUTER JOIN courses USING (course_id)
WHERE
  courses.course_name IS NULL;

/*
Finally, identify the courses that have not been enrolled in by any students:
*/
SELECT
  students.student_name,
  courses.course_name
FROM
  students
  FULL OUTER JOIN enrollments USING (student_id)
  FULL OUTER JOIN courses USING (course_id)
WHERE
  students.student_name IS NULL;

--noqa: enable=ST11
/*
An artist can have zero or many albums while an album belongs to one artist.

To query data from both artists and albums tables, you can use an INNER JOIN, LEFT JOIN, or CROSS JOIN clause. Each join clause determines how SQLite uses data from one table to match with rows in another table.

The following statement returns the album titles and the corresponding artist names:
*/
SELECT
  albums.title,
  artists.name
FROM
  albums
  INNER JOIN artists ON albums.artistid = artists.artistid;

/*
In this example, the INNER JOIN clause matches each row from the albums table with every row from the artists table based on the join condition (artists.ArtistId = albums.ArtistId) specified after the ON keyword.

If the join condition evaluates to true (or 1), the columns of rows from both albums and artists tables are included in the result set.

This query uses table aliases (l for the albums table and r for artists table) to shorten the query:
*/
SELECT
  albums.title,
  artists.name
FROM
  albums
  INNER JOIN artists ON albums.artistid = artists.artistid;

/*
In case the column names of joined tables are
same e.g., ArtistId, you can use the USING syntax as follows:
*/
SELECT
  albums.title,
  artists.name
FROM
  albums
  INNER JOIN artists USING (artistid);

/*
The clause USING(ArtistId) is equivalent to the clause ON artists.ArtistId = albums.ArtistId.


This statement uses the SELECT statement with the LEFT JOIN clause to retrieve the artist names and album titles from the artists and albums tables:
*/
SELECT
  artists.name,
  albums.title
FROM
  artists
  LEFT JOIN albums ON artists.artistid = albums.artistid
ORDER BY
  artists.name;

/*
The LEFT JOIN clause selects data starting from the left table (artists) and matching rows in the right table (albums) based on the join condition (artists.ArtistId = albums.ArtistId) .

The left join returns all rows from the artists table (or left table) and the matching rows from the albums table (or right table).

If a row from the left table doesn’t have a matching row in the right table, SQLite includes columns of the rows in the left table and NULL for the columns of the right table.

Similar to the INNER JOIN clause, you can use the USING syntax for the join condition as follows:
*/
SELECT
  artists.name,
  albums.title
FROM
  artists
  LEFT JOIN albums USING (artistid)
ORDER BY
  artists.name;

/*
If you want to find artists who don’t have any albums, you can add a WHERE clause as shown in the following query:
*/
SELECT
  artists.name,
  albums.title
FROM
  artists
  LEFT JOIN albums ON artists.artistid = albums.artistid
WHERE
  albums.title IS NULL
ORDER BY
  artists.name;

/*
Generally, this type of query allows you to find rows that are available in the left table but don’t have corresponding rows in the right table.

Note that LEFT JOIN and LEFT OUTER JOIN are synonyms.

SQLite CROSS JOIN
The CROSS JOIN clause creates a Cartesian product of rows from the joined tables.

Unlike the INNER JOIN and LEFT JOIN clauses, a CROSS JOIN doesn’t have a join condition. Here is the basic syntax of the CROSS JOIN clause:

SELECT
select_list
FROM
table1
CROSS JOIN table2;

The CROSS JOIN combines every row from the first table (table1) with every row from the second table (table2) to form the result set.

If the first table has n rows, the second table has m rows, the final result will have nxm rows.

A practical example of the CROSS JOIN clause is to combine two sets of data to form an initial data set for further processing. For example, you have a list of products and months, and you want to make a plan for when you can sell which products.

The following script creates the products and calendars tables:
*/
DROP TABLE IF EXISTS calendars;

DROP TABLE IF EXISTS products;

CREATE TABLE products (product TEXT NOT NULL);

INSERT INTO
  products (product)
VALUES
  (' P1 '),
  (' P2 '),
  (' P3 ');

CREATE TABLE calendars (y INT NOT NULL, m INT NOT NULL);

INSERT INTO
  calendars (y, m)
VALUES
  (2019, 1),
  (2019, 2),
  (2019, 3),
  (2019, 4),
  (2019, 5),
  (2019, 6),
  (2019, 7),
  (2019, 8),
  (2019, 9),
  (2019, 10),
  (2019, 11),
  (2019, 12);

/*
This query uses the CROSS JOIN clause to combine the products with the months:
*/
--noqa: disable=RF02
SELECT
  *
FROM
  products
  CROSS JOIN calendars;

--noqa: enable=RF02
/*
The self-join is a special kind of joins that allow you to join a table to itself using either LEFT JOIN or INNER JOIN clause. You use self-join to create a result set that joins the rows with the other rows within the same table.

Because you cannot refer to the same table more than one in a query, you need to use a table alias to assign the table a different name when you use self-join.

The self-join compares values of the same or different columns in the same table. Only one table is involved in the self-join.

You often use self-join to query parents/child relationship stored in a table or to obtain running totals.
*/
/*
The employees table stores not only employee data but also organizational data. The ReportsTo column specifies the reporting relationship between employees.

If an employee reports to a manager, the value of the ReportsTo column of the employee’s row is equal to the value of the EmployeeId column of the manager’s row. In case an employee does not report to anyone, the ReportsTo column is NULL.

To get the information on who is the direct report of whom, you use the following statement:
*/
SELECT
  mgrs.firstname || ' ' || mgrs.lastname AS manager,
  emps.firstname || ' ' || emps.lastname AS direct_report
FROM
  employees AS emps
  INNER JOIN employees AS mgrs ON emps.reportsto = mgrs.employeeid
ORDER BY
  manager;

/*
The statement used the INNER JOIN clause to join the employees to itself. The employees table has two roles: employees and managers.

Because we used the INNER JOIN clause to join the employees table to itself, the result set does not have the row whose manager column contains a NULL value.

Note that the concatenation operator || concatenates multiple strings into a single string. In the example, we use the concatenation operator to from the full names of the employees by concatenating the first name, space, and last name.

In case you want to query the CEO who does not report to anyone, you need to change the INNER JOIN clause to LEFT JOIN clause in the query above. */
SELECT
  mgrs.firstname || ' ' || mgrs.lastname AS manager,
  emps.firstname || ' ' || emps.lastname AS direct_report
FROM
  employees AS emps
  LEFT JOIN employees AS mgrs ON emps.reportsto = mgrs.employeeid
ORDER BY
  manager;

--noqa: disable=CV08
SELECT
  mgrs.firstname || ' ' || mgrs.lastname AS employee,
  emps.firstname || ' ' || emps.lastname AS manager
FROM
  employees AS emps
  RIGHT JOIN employees AS mgrs ON emps.employeeid = mgrs.reportsto
ORDER BY
  employee;

--noqa: enable=CV08
/*
Andrew Adams is the CEO because he does not report anyone.

You can use the self-join technique to find the employees located in the same city as the following query:
*/
SELECT DISTINCT
  emps_1.city,
  emps_1.firstname || ' ' || emps_1.lastname AS fullname
FROM
  employees AS emps_1
  INNER JOIN employees AS emps_2 ON emps_1.city = emps_2.city
  AND (
    emps_1.firstname != emps_2.firstname
    AND emps_1.lastname != emps_2.lastname
  )
ORDER BY
  emps_1.city;

/*
The join condition has two expressions:

emps_1.city = emps_2.city to make sure that both employees located in the same city
e.firstname <> emps_2.firstname AND emps_1.lastname <> emps_2.lastname to ensure that e1 and e2 are not the same employee with the assumption that there aren’t employees who have the same first name and last name.
*/
SELECT DISTINCT
  emps_1.city,
  emps_1.firstname || ' ' || emps_1.lastname AS fullname
FROM
  employees AS emps_1
  INNER JOIN employees AS emps_2 ON emps_1.city = emps_2.city
  AND emps_1.employeeid != emps_2.employeeid
ORDER BY
  emps_1.city;

/*
You could simply use employeeid instead.
*/
/*
The GROUP BY clause is an optional clause of the SELECT statement. The GROUP BY clause a selected group of rows into summary rows by values of one or more columns.

The GROUP BY clause returns one row for each group. For each group, you can apply an aggregate function such as MIN, MAX, SUM, COUNT, or AVG to provide more information about each group.

The following statement illustrates the syntax of the SQLite GROUP BY clause.

SELECT
column_1,
aggregate_function(column_2)
FROM
table
GROUP BY
column_1,
column_2;
*/
/*
The GROUP BY clause comes after the FROM clause of the SELECT statement. In case a statement contains a WHERE clause, the GROUP BY clause must come after the WHERE clause.

Following the GROUP BY clause is a column or a list of comma-separated columns used to specify the group.
*/
/*
The following statement returns the album id and the number of tracks per album. It uses the GROUP BY clause to groups tracks by album and applies the COUNT() function to each group.
*/
SELECT
  albumid,
  COUNT(trackid) AS no_of_tracks
FROM
  tracks
GROUP BY
  albumid;

/*
You can use the ORDER BY clause to sort the groups as follows:
*/
SELECT
  albumid,
  COUNT(trackid) AS no_of_tracks
FROM
  tracks
GROUP BY
  albumid
ORDER BY
  no_of_tracks DESC;

/*
You can query data from multiple tables using the INNER JOIN clause, then use the GROUP BY clause to group rows into a set of summary rows.

For example, the following statement joins the tracks table with the albums table to get the album’s titles and uses the GROUP BY clause with the COUNT function to get the number of tracks per album.
*/
SELECT
  tracks.albumid,
  albums.title,
  COUNT(tracks.trackid) AS no_of_tracks
FROM
  tracks
  INNER JOIN albums USING (albumid)
GROUP BY
  albums.albumid
ORDER BY
  no_of_tracks;

/*
To filter groups, you use the GROUP BY with HAVING clause. For example, to get the albums that have more than 15 tracks, you use the following statement:
*/
SELECT
  tracks.albumid,
  albums.title,
  COUNT(tracks.trackid) AS no_of_tracks
FROM
  tracks
  INNER JOIN albums ON tracks.albumid = albums.albumid
GROUP BY
  tracks.albumid
HAVING
  no_of_tracks > 15;

/*
You can use the SUM function to calculate total per group. For example, to get total length and bytes for each album, you use the SUM function to calculate total milliseconds and bytes.
*/
SELECT
  albumid,
  SUM(milliseconds) AS length,
  SUM(bytes) AS size
FROM
  tracks
GROUP BY
  albumid;

/*
The following statement returns the album id, album title, maximum length, minimum length, and the average length of tracks in the tracks table.
*/
SELECT
  tracks.albumid,
  albums.title,
  MIN(tracks.milliseconds) AS min_length,
  MAX(tracks.milliseconds) AS max_length,
  ROUND(AVG(tracks.milliseconds), 2) AS avg_length
FROM
  tracks
  INNER JOIN albums USING (albumid)
GROUP BY
  tracks.albumid;

/*
SQLite allows you to group rows by multiple columns.

For example, to group tracks by media type and genre, you use the following statement:
*/
SELECT
  mediatypeid,
  genreid,
  COUNT(trackid) AS no_of_tracks
FROM
  tracks
GROUP BY
  mediatypeid,
  genreid;

/*
SQLite uses the combination of values of MediaTypeId and GenreId columns as a group e.g., (1,1) and (1,2). It then applies the COUNT function to return the number of tracks in each group.
*/
/*The following statement returns the number of invoice by years.
*/
SELECT
  STRFTIME(' % Y ', invoicedate) AS invoiceyear,
  COUNT(invoiceid) AS invoicecount
FROM
  invoices
GROUP BY
  STRFTIME(' % Y ', invoicedate)
ORDER BY
  invoiceyear;

/*In this example:

The function STRFTIME(' % Y ', InvoiceDate) returns a year from a date string.
The GROUP BY clause groups the invoices by years.
The function COUNT() returns the number of invoice in each year (or group).
*/
/*

SQLite HAVING clause is an optional clause of the SELECT statement. The HAVING clause specifies a search condition for a group.

You often use the HAVING clause with the GROUP BY clause. The GROUP BY clause groups a set of rows into a set of summary rows or groups. Then the HAVING clause filters groups based on a specified condition.

If you use the HAVING clause, you must include the GROUP BY clause; otherwise, you will get the following error:

Error: a GROUP BY clause is required before HAVING

Note that the HAVING clause is applied after GROUP BY clause, whereas the WHERE clause is applied before the GROUP BY clause.

The following illustrates the syntax of the HAVING clause:

SELECT
column_1,
column_2,
aggregate_function (column_3)
FROM
table
GROUP BY
column_1,
column_2
HAVING
search_condition;

In this syntax, the HAVING clause evaluates the search_condition for each group as a Boolean expression. It only includes a group in the final result set if the evaluation is true.

*/
/*
To find the number of tracks for each album, you use GROUP BY clause as follows:
*/
SELECT
  albumid,
  COUNT(trackid) AS no_of_tracks
FROM
  tracks
GROUP BY
  albumid;

/*

SQLite HAVING clause with COUNT function
To find the numbers of tracks for the album with id 1, we add a HAVING clause to the following statement:
*/
SELECT
  albumid,
  COUNT(trackid) AS no_of_tracks
FROM
  tracks
GROUP BY
  albumid
HAVING
  albumid = 1;

/*
We have referred to the AlbumId column in the HAVING clause.

To find albums that have the number of tracks between 18 and 20, you use the aggregate function in the HAVING clause as shown in the following statement:
*/
SELECT
  albumid,
  COUNT(trackid) AS no_of_tracks
FROM
  tracks
GROUP BY
  albumid
HAVING
  no_of_tracks BETWEEN 18 AND 20
ORDER BY
  albumid;

SELECT
  albumid,
  COUNT(trackid) AS no_of_tracks
FROM
  tracks
GROUP BY
  albumid
HAVING
  COUNT(albumid) BETWEEN 18 AND 20
ORDER BY
  albumid;

/*
The following statement queries data from tracks and albums tables using inner join to find albums that have the total length greater than 60,000,000 milliseconds.
*/
SELECT
  tracks.albumid,
  albums.title,
  SUM(tracks.milliseconds) AS length
FROM
  tracks
  INNER JOIN albums USING (albumid)
GROUP BY
  albums.albumid
HAVING
  length > 60000000;

SELECT COUNT(*)
FROM
  tracks;

SELECT COUNT(*)
FROM
  albums;

/*
Sometimes, you need to combine the results of multiple queries into a single result set. To achieve this, you can use the UNION operator.

Here’s the syntax of the UNION operator:

query1
UNION [ALL]
query2;

In this syntax:

First, specify the first query.
Second, use the UNION operator to indicate that you want to combine the result set of the first query with the next one.
Third, specify the second query.
The UNION operator eliminates duplicate rows in the final result set. If you want to retain the duplicate rows, you can use the UNION ALL operator.

Here are the rules for the queries when using the UNION operator:

The queries (query1 and query2) have the same number of columns.
The corresponding columns must have compatible data types.
The column names of the first query determine the column names of the combined result set.
If you use the GROUP BY and HAVING clauses, they will be applied to each query, not the final result set.
If you use the ORDER BY clause, it will be applied to the combined result set, not the individual result set.
Note that the difference between UNION and JOIN e.g., INNER JOIN or LEFT JOIN is that the JOIN clause combines columns from multiple related tables, whereas the UNION operator combines rows from multiple result sets.

Suppose you have two tables t1 and t2 with the following structures:
*/
DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (c1 INT);

INSERT INTO
  t1 (c1)
VALUES
  (1),
  (2),
  (3);

DROP TABLE IF EXISTS t2;

CREATE TABLE t2 (c2 INT);

INSERT INTO
  t2 (c2)
VALUES
  (2),
  (3),
  (4);

/*
The following statement combines the result sets of the t1 and t2 tables using the UNION operator:
*/
SELECT c1
FROM
  t1
UNION
SELECT c2
FROM
  t2;

/*
The following statement combines the result sets of t1 and t2 tables using the  UNION ALL operator:
*/
SELECT c1
FROM
  t1
UNION ALL
SELECT c2
FROM
  t2;

/*
This statement uses the UNION operator to combine the names of employees and customers into a single list:
*/
SELECT
  firstname,
  lastname,
  ' Employee ' AS type
FROM
  employees
UNION
SELECT
  firstname,
  lastname,
  ' Customer ' AS type
FROM
  customers;

/*
This example uses the UNION operator to combine the names of the employees and customers into a single list. In addition, it uses the ORDER BY clause to sort the name list by first name and last name.
*/
SELECT
  firstname,
  lastname,
  ' Employee ' AS type
FROM
  employees
UNION
SELECT
  firstname,
  lastname,
  ' Customer ' AS type
FROM
  customers
ORDER BY
  firstname,
  lastname;

/*
SQLite EXCEPT operator compares the result sets of two queries and returns distinct rows from the first query that are not output by the second query.

The following shows the syntax of the EXCEPT operator:

SELECT select_list1
FROM table1
EXCEPT
SELECT select_list2
FROM table2;
This query must conform to the following rules:

First, the number of columns in the select lists of both queries must be the same.
Second, the order of the columns and their types must be comparable.
The following statements create two tables t1 and t2 and insert some data into both tables:

The following statement illustrates how to use the EXCEPT operator to compare result sets of two queries:
*/
SELECT c1
FROM
  t1
EXCEPT
SELECT c2
FROM
  t2;

/*
First, create new tables books, customers, and orders:
*/
DROP TABLE IF EXISTS orders;

DROP TABLE IF EXISTS custs;

DROP TABLE IF EXISTS books;

CREATE TABLE books (
  book_id INTEGER PRIMARY KEY,
  title TEXT,
  author TEXT,
  genre TEXT,
  price REAL
);

CREATE TABLE custs (
  customer_id INTEGER PRIMARY KEY,
  name TEXT,
  email TEXT
);

CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER,
  book_id INTEGER,
  order_date DATE,
  FOREIGN KEY (customer_id) REFERENCES custs (customer_id),
  FOREIGN KEY (book_id) REFERENCES books (book_id)
);

/*
Second, insert rows into these tables:
*/
INSERT INTO
  books (title, author, genre, price)
VALUES
  (
    ' TO KILL a Mockingbird ',
    ' Harper Lee ',
    ' Fiction ',
    12.99
  ),
  (
    ' 1984 ',
    ' George Orwell ',
    ' Science Fiction ',
    10.99
  ),
  (
    ' The Great Gatsby ',
    ' F.Scott Fitzgerald ',
    ' Classic ',
    9.99
  ),
  (
    ' Pride
    AND Prejudice ',
    ' Jane Austen ',
    ' Romance ',
    8.99
  ),
  (
    ' The Catcher IN the Rye ',
    ' J.D.Salinger ',
    ' Fiction ',
    11.99
  );

INSERT INTO
  custs (name, email)
VALUES
  (' Alice ', ' alice @gmail.com '),
  (' Bob ', ' bob @yahoo.com '),
  (' Charlie ', ' charlie @outlook.com ');

INSERT INTO
  orders (customer_id, book_id, order_date)
VALUES
  (1, 1, ' 2024 -04 -25 '), -- Alice purchased ' TO KILL a Mockingbird '
  (1, 3, ' 2024 -04 -27 '), -- Alice purchased ' The Great Gatsby '
  (2, 2, ' 2024 -04 -26 ');

-- Bob purchased ' 1984 '
/*
Third, use the EXCEPT operator to find books that have not had any sales:
*/
SELECT
  title,
  author,
  genre,
  price
FROM
  books
EXCEPT
SELECT
  books.title,
  books.author,
  books.genre,
  books.price
FROM
  books
  INNER JOIN orders USING (book_id);

/*
How it works.

The first query selects all books from the books table.
The second query retrieves books that have orders by joining the books table with the orders table.
The EXCEPT operator returns a list of distinct books that have not been ordered by any customer.
*/
/*
SQLite INTERSECT operator allows you to combine the result sets of two queries and returns distinct rows that appear in both result sets of the queries.

The following illustrates the syntax of the INTERSECT operator:

SELECT select_list1
FROM table1
INTERSECT
SELECT select_list2
FROM table2;
The basic rules for combining the result sets of two queries are as follows:

First, the number and the order of the columns in all queries must be the same.
Second, the data types must be comparable.
For the demonstration, we will create two tables t1 and t2 and insert some data into both tables:

The following statement illustrates how to use the INTERSECT operator to compare result sets of two queries:
*/
SELECT c1
FROM
  t1
INTERSECT
SELECT c2
FROM
  t2;

/*
The following statement uses the INTERSECT operator to find customers who have invoices:
*/
SELECT
  customerid,
  firstname,
  lastname
FROM
  customers
INTERSECT
SELECT
  customers.customerid,
  customers.firstname,
  customers.lastname
FROM
  invoices
  INNER JOIN customers USING (customerid)
ORDER BY
  customerid;

/*
How it works.

The first query returns all customers from the customers table.
The second query returns customers who have invoices by joining the customers table with the invoices table.
The INTERSECT operator returns customers who have invoices.*/
/*
A subquery is a SELECT statement nested in another statement. See the following statement.

SELECT column_1
FROM table_1
WHERE column_1 = (
SELECT column_1
FROM table_2
);

The following query is the outer query:

SELECT column_1
FROM table_1
WHERE colum_1 =
Code language: SQL (Structured Query Language) (sql)
And the following query is the subquery.

(SELECT column_1
FROM table_2)

You must use a pair of parentheses to enclose a subquery. Note that you can nest a subquery inside another subquery with a certain depth.

Typically, a subquery returns a single row as an atomic value, though it may return multiple rows for comparing values with the IN operator.

You can use a subquery in the SELECT, FROM, WHERE, and JOIN clauses.

You can use a simple subquery as a search condition. For example, the following statement returns all the tracks in the album with the title  Let There Be Rock
*/
--noqa: disable=RF02
SELECT
  trackid,
  name,
  albumid
FROM
  tracks
WHERE
  albumid = (
    SELECT albumid
    FROM
      albums
    WHERE
      title = ' Let There Be Rock '
  );

/*
The subquery returns the id of the album with the title ' Let There Be Rock '. The query uses the equal operator (=) to compare albumid returned by the subquery with the  albumid in the tracks table.

If the subquery returns multiple values, you can use the IN operator to check for the existence of a single value against a set of value.
*/
/*
For example, the following query returns the customers whose sales representatives are in Canada.
*/
SELECT
  customerid,
  firstname,
  lastname
FROM
  customers
WHERE
  supportrepid IN (
    SELECT employeeid
    FROM
      employees
    WHERE
      country = ' Canada '
  );

--noqa: enable=RF02
/*
The subquery returns a list of ids of the employees who locate in Canada. The outer query uses the IN operator to find the customers who have the sales representative id in the list.
*/
/*
Sometimes you want to apply aggregate functions to a column multiple times. For example, first, you want to sum the size of an album and then calculate the average size of all albums. You may come up with the following query.

SELECT AVG(SUM(bytes)
FROM tracks
GROUP BY albumid;
Code language: SQL (Structured Query Language) (sql)
This query is not valid.

To fix it, you can use a subquery in the FROM clause as follows:
*/
SELECT AVG(album.size)
FROM
  (
    SELECT SUM(bytes) AS size
    FROM
      tracks
    GROUP BY
      albumid
  ) AS album;

/*
In this case, SQLite first executes the subquery in the FROM clause and returns a result set. Then, SQLite uses this result set as a derived table in the outer query.
*/
/*
All the subqueries you have seen so far can be executed independently. In other words, it does not depend on the outer query.

The correlated subquery is a subquery that uses the values from the outer query. Unlike an ordinal subquery, a correlated subquery cannot be executed independently.

The correlated subquery is not efficient because it is evaluated for each row processed by the outer query.

The following query uses a correlated subquery to return the albums whose size is less than 10MB.
*/
SELECT
  albumid,
  title
FROM
  albums
WHERE
  10000000 > (
    SELECT SUM(tracks.bytes)
    FROM
      tracks
    WHERE
      tracks.albumid = albums.albumid
  )
ORDER BY
  title;

/*
How the query works.

For each row processed in the outer query, the correlated subquery calculates the size of the albums from the tracks that belong the current album using the SUM function.
The predicate in the WHERE clause filters the albums that have the size greater than or equal 10MB (10000000 bytes)
*/
/*
The following query uses a correlated subquery in the SELECT clause to return the number of tracks in an album.
*/
SELECT
  albumid,
  title,
  (
    SELECT COUNT(tracks.trackid)
    FROM
      tracks
    WHERE
      tracks.albumid = albums.albumid
  ) AS tracks_count
FROM
  albums
ORDER BY
  tracks_count DESC;

/*
The EXISTS operator is a logical operator that checks whether a subquery returns any row.

Here is the basic syntax of the EXISTS operator:

EXISTS(subquery)
In this syntax, the subquery is a SELECT statement that returns zero or more rows.

If the subquery returns one or more row, the EXISTS operator return true. Otherwise, the EXISTS operator returns false or NULL.

Note that if the subquery returns one row with NULL, the result of the EXISTS operator is still true because the result set contains one row with NULL.

To negate the EXISTS operator, you use the NOT EXISTS operator as follows:

NOT EXISTS (subquery)
The NOT EXISTS operator returns true if the subquery returns no row.
*/
SELECT
  customerid,
  firstname,
  lastname,
  company
FROM
  customers
WHERE
  EXISTS (
    SELECT 1
    FROM
      invoices
    WHERE
      invoices.customerid = customers.customerid
  )
ORDER BY
  firstname,
  lastname;

SELECT
  customerid,
  firstname,
  lastname,
  company
FROM
  customers
WHERE
  EXISTS (
    SELECT
      invoices.*
    FROM
      invoices
    WHERE
      invoices.customerid = customers.customerid
  )
ORDER BY
  firstname,
  lastname;

/*
In this example, for each customer, the EXISTS operator checks if the customer id exists in the invoices table.

If yes, the subquery returns one row with value 1 that causes the EXISTS operator evaluate to true. Therefore, the query includes the curstomer in the result set.
In case the customer id does not exist in the Invoices table, the subquery returns no rows which causes the EXISTS operator to evaluate to false, hence the query does not include the customer in the result set.
Notice that you can use the IN operator instead of EXISTS operator in this case to achieve the same result:
*/
--noqa: disable=RF02
SELECT
  customerid,
  firstname,
  lastname,
  company
FROM
  customers
WHERE
  customerid IN (
    SELECT customerid
    FROM
      invoices
  )
ORDER BY
  firstname,
  lastname;

--noqa: enable=RF02
/*
Once the subquery returns the first row, the EXISTS operator stops searching because it can determine the result. On the other hand, the IN operator must scan all rows returned by the subquery to determine the result.

Generally speaking, the EXISTS operator is faster than IN operator if the result set returned by the subquery is large. By contrast, the IN operator is faster than the EXISTS operator if the result set returned by the subquery is small.*/
/*
This query find all artists who do not have any album in the Albums table:
*/
SELECT
  artists.*
FROM
  artists
WHERE
  NOT EXISTS (
    SELECT 1
    FROM
      albums
    WHERE
      albums.artistid = artists.artistid
  )
ORDER BY
  artists.name;

--noqa: enable=RF02
/*
Common table expressions (CTE) are temporary result sets defined within the scope of a query. CTEs allow you to make your query more readable.

Additionally, CTEs enable modular SQL queries by breaking them into smaller, logical units.

In practice, you can use CTEs to replace the subqueries to make them more readable.

Here’s the syntax for defining a CTE in SQLite:

WITH cte_name AS (
-- cte query definion

)
-- main query using the cte
SELECT * FROM cte_name;
In this syntax:

First, specify a name for the CTE in the WITH clause.
Second, provide a query that defines the CTE inside the parentheses followed by the AS keyword. The result set followed by this query forms the temporary result set you can reference in the main query.
Third, write the main query that references the CTE.
Here’s an example to illustrate the CTE syntax:

WITH cte_example AS (
SELECT column1, column2
FROM table_name
WHERE condition
)
SELECT * FROM cte_example;
*/
/*

In this syntax:

cte_example is the name of the CTE
The CTE query retrieves data from column 1 and column 2 of the table_name based on the specified condition. Note that the query may include join, group by, having, and other clauses of the SELECT statement.
The main query selects all columns from the CTE cte_example.
*/
/*
The following example uses a CTE to retrieve the top 5 tracks from the tracks table:
*/
WITH
  top_tracks AS (
    SELECT
      trackid,
      name
    FROM
      tracks
    ORDER BY
      trackid
    LIMIT
      5
  )
SELECT
  *
FROM
  top_tracks;

/*

The following example uses a CTE to find the top 5 customers by total sales from the invoices and invoice_items tables:
*/
WITH
  customer_sales AS (
    SELECT
      customers.customerid,
      customers.firstname || ' ' || customers.lastname AS customer_name,
      ROUND(
        SUM(invoice_items.unitprice * invoice_items.quantity),
        2
      ) AS total_sales
    FROM
      customers
      INNER JOIN invoices ON customers.customerid = invoices.customerid
      INNER JOIN invoice_items ON invoices.invoiceid = invoice_items.invoiceid
    GROUP BY
      customers.customerid
  )
SELECT
  customer_name,
  total_sales
FROM
  customer_sales
ORDER BY
  total_sales DESC,
  customer_name ASC
LIMIT
  5;

/*
The SQLite CASE expression evaluates a list of conditions and returns an expression based on the result of the evaluation.

The CASE expression is similar to the IF-THEN-ELSE statement in other programming languages.

You can use the CASE expression in any clause or statement that accepts a valid expression. For example, you can use the CASE expression in clauses such as WHERE, ORDER BY, HAVING, SELECT and statements such as SELECT, UPDATE, and DELETE.

SQLite provides two forms of the CASE expression: simple CASE and searched CASE.
*/
/*
The simple CASE expression compares an expression to a list of expressions to return the result. The following illustrates the syntax of the simple CASE expression.

CASE case_expression
WHEN when_expression_1 THEN result_1
WHEN when_expression_2 THEN result_2
...
[ ELSE result_else ]
END
The simple CASE expression compares the case_expression to the expression appears in the first WHEN clause, when_expression_1, for equality.

If the case_expression equals when_expression_1, the simple CASE returns the expression in the corresponding THEN clause, which is the result_1.

Otherwise, the simple CASE expression compares the case_expression with the expression in the next WHEN clause.

In case no case_expression matches the when_expression, the CASE expression returns the result_else in the ELSE clause. If you omit the ELSE clause, the CASE expression returns NULL.

The simple CASE expression uses short-circuit evaluation. In other words, it returns the result and stop evaluating other conditions as soon as it finds a match.
*/
/*
Suppose, you have to make a report of the customer groups with the logic that if a customer locates in the USA, this customer belongs to the domestic group, otherwise the customer belongs to the foreign group.

To make this report, you use the simple CASE expression in the SELECT statement as follows:
*/
SELECT
  customerid,
  firstname,
  lastname,
  CASE country
    WHEN 'USA' THEN 'Domestic'
    ELSE 'Foreign'
  END AS customergroup
FROM
  customers
ORDER BY
  lastname,
  firstname;

/*

The searched CASE expression evaluates a list of expressions to decide the result. Note that the simple CASE expression only compares for equality, while the searched CASE expression can use any forms of comparison.

The following illustrates the syntax of the searched CASE expression.

CASE
WHEN bool_expression_1 THEN result_1
WHEN bool_expression_2 THEN result_2
[ ELSE result_else ]
END
The searched CASE expression evaluates the Boolean expressions in the sequence specified and return the corresponding result if the expression evaluates to true.

In case no expression evaluates to true, the searched CASE expression returns the expression in the ELSE clause if specified. If you omit the ELSE clause, the searched CASE expression returns NULL.

Similar to the simple CASE expression, the searched CASE expression stops the evaluation when a condition is met.
*/
/*

Suppose you want to classify the tracks based on its length such as less a minute, the track is short; between 1 and 5 minutes, the track is medium; greater than 5 minutes, the track is long.

To achieve this, you use the searched CASE expression as follows:
*/
SELECT
  trackid,
  name,
  CASE
    WHEN milliseconds < 60000 THEN 'short'
    WHEN milliseconds > 60000
    AND milliseconds < 300000 THEN 'medium'
    ELSE 'long'
  END AS category
FROM
  tracks;
