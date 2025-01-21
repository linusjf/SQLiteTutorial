/*
Introduction to SQLite strict tables
In SQLite, ordinary tables use dynamic typing for columns. This means that the data types of the columns serve as hints rather than strict rules. Consequently, you can store values of any type in columns without strictly adhering to the declared data types.

For example, even if you declare a column with the INTEGER type, you still can store a value of TEXT or BLOB type in that column.

This feature is unique to SQLite, but some developers find it challenging to work with. Therefore, SQLite introduced a strict typing mode for each table in SQLite 3.37.0, released on Nov 27, 2021.

When creating tables, you have the option to enable the strict typing mode for each table separately by using the STRICT keyword:

CREATE TABLE strict_table_name(
column type constraint, 
...
) STRICT;
These tables are often referred to as strict tables.

The strict tables follow these rules:

Every column must have one of the following data types: INT, INTEGER, REAL, TEXT, BLOB, and ANY.
When inserting a value into a column, SQLite will attempt to convert the value into the column’s data type. If the conversion fails, it will raise an error.
Columns with the ANY data type can accept any kind of data. SQLite will not perform any conversion for these columns.
PRIMARY KEY columns are implicitly NOT NULL.
The PRAGMA integrity_check and PRAGMA quick_check commands verify the type of the contents of all columns in strict tables and display errors if any mismatches are found.
*/
/*
Basic SQLite strict table example
First, create a strict table called products to store the product data:
*/
CREATE TABLE products (
  id INT PRIMARY KEY,
  name TEXT NOT NULL,
  price REAL NOT NULL DEFAULT 0
)
STRICT;

/*
The STRICT keyword after the closing parenthesis ) indicates that the products table is strict.

Second, attempt to insert NULL into the id column:
*/
INSERT INTO products
  (id, name, price)
VALUES
  (NULL, 'A', 9.99);

/*
SQLite issues the following error:

SQL Error (19): NOT NULL constraint failed: products.id

The reason is that the primary key column of a strict table implicitly has the NOT NULL constraint. To make it work, you must provide a valid value for the id column in the INSERT statement.

Third, insert a new row into the products table by providing values for all columns:
*/
INSERT INTO products
  (id, name, price)
VALUES
  (1, 'A', 9.99);

/*
Alternatively, you can use the auto-increment column by changing the type of the id column to INTEGER PRIMARY KEY.

Fourth, recreate the products table with the type of id column is INTEGER PRIMARY KEY:
*/
DROP TABLE IF EXISTS products;

CREATE TABLE products (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  price REAL NOT NULL DEFAULT 0
)
STRICT;

/*
In this case, if you insert NULL into the id column, SQLite will use the next integer value for insertion.

Fifth, insert two rows into the products table whose values in the id column are NULLs:
*/
INSERT INTO products
  (id, name, price)
VALUES
  (NULL, 'A', 9.99);

INSERT INTO products
  (id, name, price)
VALUES
  (NULL, 'B', 10.99);

/*
Sixth, retrieve data from products table:
*/
SELECT
  *
FROM products;

/*
The output indicates that SQLite uses the integers 1 and 2 for the insertion.

Seventh, insert a new row into the products table without providing the value for the id column:
*/
INSERT INTO products
  (name, price)
VALUES
  ('C', 5.59);

/*
Eighth, query data from products table again:
*/
SELECT
  *
FROM products;
/*
In this example, SQLite uses the next integer in the sequence and inserts it into the id column.
*/
