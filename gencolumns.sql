/*
Introduction to SQLite generated columns
SQLite introduced the generated columns since version 3.31.0.

By definition, generated columns are the columns of a table whose values are derived from an expression that involves other columns of the same table.

Generated columns are also known as computed columns.

To define a generated column, you use the GENERATED ALWAYS column constraint syntax as follows:

column_name data_type 
[GENERATED ALWAYS] AS expression 
[VIRTUAL | STORED]
Code language: SQL (Structured Query Language) (sql)
In this syntax, you specify the expression that computes values for the column_name after the GENERATED ALWAYS keywords. The expression typically involves columns of the same row within the same table.

The GENERATED ALWAYS keywords are optional. Therefore, you can make it shorter as follows:

column_name data_type AS expression [VIRTUAL | STORED]
Code language: SQL (Structured Query Language) (sql)
A generated column can be either VIRTUAL or STORED.

If a generated column is VIRTUAL, SQLite doesn’t store the values of the column physically. Instead, when you read values from the generated column, SQLite computes these values based on the expression specified in the column declaration.

In case a generated column is STORED, SQLite stores the values of the column physically. In other words, the STORED generated column takes up spaces in the database file. SQLite updates the values of the STORED generated column when you write to the database.

SQLite uses the VIRTUAL by default when you don’t explicitly specify VIRTUAL or STORED in the generated column declaration.

In practice, you use the STORED option when you want to optimize for reading and the VIRTUAL option when you want to optimize for writing.

SQLite generated column example
First, create a table called products by using the following CREATE TABLE statement:
*/
DROP TABLE IF EXISTS products;

CREATE TABLE products (
  name TEXT NOT NULL,
  price REAL NOT NULL,
  discount REAL NOT NULL,
  tax REAL NOT NULL,
  net_price REAL GENERATED ALWAYS AS (price * (1 - discount) * (1 + tax))
);

/*
In the products table, the net_price is a generated column whose value derived from the price, discount, and tax columns.

Because we didn’t specify VIRTUAL or STORED for the net_price column, the net_price column uses VIRTUAL by default.

Second, insert a new row into the products table. Note that it doesn’t supply values to the net_price column:
*/
INSERT INTO products
  (name, price, discount, tax)
VALUES
  ('ABC Widget', 100, 0.05, 0.07);

/*
Third, query data from the products table:
*/
SELECT
  *
FROM products;
/*
As you can see clearly from the output, the value of the net_price column is calculated based on the values of the price, discount, and tax columns.
*/
/*
SQLite generated column features
Generated columns have the following features:

A generated column can have a datatype. SQLite will convert the value from the expression to that data type using the same affinity rules as for regular columns.
A generated column can have NOT NULL, CHECK, UNIQUE, and FOREIGN KEY constraints.
A generated column can be a part of one or more indexes.
A generated column can reference other columns including other generated columns within the same table as long as it does not reference itself.
SQLite places the following constraints on generated columns:

A generated column cannot have a default value.
A generated column cannot be used as a part of a PRIMARY KEY.
If a table has a generated column, it must have a least one generated columns.
It’s NOT possible to use the ALTER TABLE ADD COLUMN statement to add a STORED column. However, it possible to use the ALTER TABLE ADD COLUMN statement to add a VIRTUAL column.
A generated column cannot reference itself, either directly or indirectly.
The expression cannot use subqueries, aggregate functions, window functions, or table-valued functions. It only can reference constants literals, columns within the same rows, and scalar deterministic functions.
The expression of a generated column can reference a INTEGER PRIMARY KEY column but it cannot directly reference a ROWID column.
*/
/*

Generated columns are columns whose values derived from other columns within the same table.
Use GENERATED ALWAYS constraint to declare a generated column.
Use VIRTUAL or STORED option for a generated column. The STORED column does take up space in the database file while the VIRTUAL column doesn’t. By default, SQLite uses the VIRTUAL option if you don’t specify it.
*/
