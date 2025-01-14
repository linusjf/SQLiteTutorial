/*

Starting from SQLite 3.35.0, the INSERT, UPDATE, and DELETE have an optional RETURNING clause that returns the row that is inserted, updated, or deleted.

Here’s the syntax of the RETURNING clause when used with the INSERT statement:

INSERT INTO table_name(column_list)
VALUES(value_list)
RETURNING
expression1 AS column_alias1,
expression2 AS column_alias2,
...;
In this syntax:

First, place the RETURNING clause after the INSERT statement.
expression1, expression2, and so on are the columns of the inserted row. They can be expressions that involve the columns. Additionally, you can use column aliases to return a row with the new column name
If you want to return all columns of the inserted row without forming expressions or aliases, you can use the asterisk (*) shortcut:

INSERT INTO table_name(column_list)
VALUES(value_list)
RETURNING *;
Similarly, you can use the RETURNING clause with the UPDATE statement:

UPDATE table_name
SET column1 = value1, column2 =value2,
WHERE condition
RETURNING
expression1 AS column_alias1,
expression2 AS column_alias2,
...;
In this syntax, the RETURNING clause returns the modified row.

Likewise, the RETURNING clause in a delete statement returns the deleted row:

DELETE FROM table_name
WHERE condition
RETURNING
expression1 AS column_alias1,
expression2 AS column_alias2,
...;
It’s important to note that for the INSERT and UPDATE statements, the RETURNING clause returns the rows after SQLite has applied the change. For the DELETE statements, the RETURNING clause returns the row before the delete.

Statement	RETURNING
INSERT	inserted row ( after inserting)
UPDATE	updated row ( after updating)
DELETE	deleted row ( before deleting)
In practice, you use the RETURNING clause to get the inserted, updated, and deleted row without having to issue a separate query.
*/
/*
Let’s take examples of using the RETURNING clause. We’ll create a new table called books for the demonstration:
*/
DROP TABLE IF EXISTS books;

CREATE TABLE books (
  id INTEGER PRIMARY KEY,
  title TEXT NOT NULL,
  isbn TEXT NOT NULL,
  release_date DATE
);

/*
Returning inserted rows
First, insert a new row into the books table and return the inserted row:
*/
INSERT INTO
  books (title, isbn, release_date)
VALUES
  (
    'The Catcher in the Rye',
    '9780316769488',
    '1951-07-16'
  ) RETURNING *;

/*
In this example, the RETURNING clause returns all columns of the inserted row because of the asterisk.

Second, insert a new row into the books table and return the inserted book id:
*/
INSERT INTO
  books (title, isbn, release_date)
VALUES
  ('The Great Gatsby', '9780743273565', '1925-04-10') RETURNING id;

/*
In this example, the RETURN clause returns the id of the inserted book.

Third, insert a new row into the books table and return the book id and release year:
*/
INSERT INTO
  books (title, isbn, release_date)
VALUES
  ('The Great Gatsby', '9780743273565', '1925-04-10') RETURNING id AS book_id,
  STRFTIME('%Y', release_date) AS year;

/*
Fourth, insert two rows and return the inserted rows:
*/
INSERT INTO
  books (title, isbn, release_date)
VALUES
  (
    'Pride and Prejudice',
    '9780141439518',
    '1813-01-28'
  ),
  (
    'The Lord of the Rings',
    '9780618640157',
    '1954-07-29'
  ) RETURNING *;

/*
Returning updated rows
First, use the UPDATE statement uses the RETURNING clause to update the ISBN of the book with id 1 and return the updated row:
*/
UPDATE books
SET
  isbn = '0141439512'
WHERE
  id = 1 RETURNING *;

/*
Second, use the UPDATE statement uses the RETURNING clause to change the book title to uppercase and return the updated rows:
*/
UPDATE books
SET
  title = UPPER(title) RETURNING *;

/*
3) Returning deleted rows
First, delete a book with id 1 and return the deleted row:
*/
DELETE FROM books
WHERE
  id = 1 RETURNING *;

/*
Second, delete all rows from the books table and return multiple deleted rows:
*/
DELETE FROM books RETURNING *;

/*
Here are some restrictions when using the RETURNING clause:

The RETURNING cannot be used as a subquery even though it returns a result set. It can only return data to the application.
If the RETURNING clause returns multiple rows, the order of rows is unspecified.
The RETURNING clause returns the original rows that do not reflect changes made by triggers.
The RETURNING clause may not contain top-level aggregate functions or window functions.
The RETURNING clause can only reference the table being modified. It cannot reference the table that drives the modification such as in the UPDATE FROM statement.
*/
