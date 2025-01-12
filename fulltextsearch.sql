/*
A virtual table is a custom extension to SQLite. A virtual table is like a normal table. The difference between a virtual table and a normal table is where the data come from i.e., when you process a normal table, SQLite accesses the database file to retrieve data. However, when you access a virtual table, SQLite calls the custom code to get the data. The custom code can have specified logic to handle certain tasks such as getting data from multiple data sources.

To use full-text search in SQLite, you use FTS5 virtual table module.

The following CREATE VIRTUAL TABLE statement creates an FTS5 table with two columns:

CREATE VIRTUAL TABLE table_name
USING FTS5(column1,column2...);
/*
Notice that you cannot add types, constraints, or PRIMARY KEY declaration in the CREATE VIRTUAL TABLE statement for creating an FTS5 table. If you do so, SQLite will issue an error.

Like creating a normal table without specifying the primary key column, SQLite adds an implicit rowid column to the FTS5 table.

The following example creates an FTS5 table named posts with two columns title and body.
*/
DROP TABLE IF EXISTS posts;

CREATE VIRTUAL TABLE posts USING fts5 (title, body);

/*
Similar to a normal table, you can insert data into the posts table as follows:
*/
INSERT INTO
  posts (title, body)
VALUES
  (
    'Learn SQlite FTS5',
    'This tutorial teaches you how to perform full-text search in SQLite using FTS5'
  ),
  (
    'Advanced SQlite Full-text Search',
    'Show you some advanced techniques in SQLite full-text searching'
  ),
  (
    'SQLite Tutorial',
    'Help you learn SQLite quickly and effectively'
  );

/*
And query data against it:
*/
SELECT
  *
FROM
  posts;

/*
You can execute a full-text query against an FTS5 table using one of these three ways.

First, use a MATCH operator in the WHERE clause of the SELECT statement. For example, to get all rows that have the term fts5, you use the following query:
*/
SELECT
  *
FROM
  posts
WHERE
  posts MATCH 'fts5';

/*
Second, use an equal (=) operator in the WHERE clause of the SELECT statement. The following statement returns the same result as the statement above:
*/
SELECT
  *
FROM
  posts
WHERE
  posts = 'fts5';

/*
Third, use a tabled-value function syntax. In this way, you use the search term as the first table argument:
*/
SELECT
  *
FROM
  POSTS('fts5');

/*
By default, FTS5 is case-independent. It treats the
terms fts5FTS5 and Fts5 the same.

To sort the search results from the most to least relevant, you use the ORDER BY clause as follows:
*/
SELECT
  *
FROM
  posts
WHERE
  posts MATCH 'text'
ORDER BY
  rank;
/*
A full-text search query is made up of phrases, where each phrase is an ordered list of one or more tokens. You can use the “+” operator to concatenate two phrases as the following example:

"learn SQLite"
"learn + SQLite"
FTS5 determines whether a document matches a phrase if the document contains at least one subsequence of tokens that match the sequence of tokens used to construct the phrase.

The following query returns all documents that match the search term Learn SQLite:
*/
SELECT * 
FROM posts 
WHERE posts MATCH 'learn SQLite';

