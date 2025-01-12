/*
Introduction to SQLite data types
If you come from other database systems such as MySQL and PostgreSQL, you’ll notice that they use static typing.

This means that when you declare a column with a specific data type, that column can store only data of the declared type.

For example, if you declare a quantity column with the type integer, you can only store whole numbers in that column:

CREATE TABLE table_name(
...
quantity INT NOT NULL,
...
);
Unlike other database systems, SQLite uses a dynamic type system. In other words, the data type of a column is determined by the value stored in it, rather than by the column’s declared data type.

In addition, you don’t have to declare a specific data type for a column when creating a table.

For example, if you declare a column with the integer data type, you can still store various data types like text and BLOB without issues.

SQLite provides five primitive data types, commonly referred to as storage classes.
*/
/*

Storage classes describe the formats that SQLite uses to store data on disk. A storage class is more general than a data type; for example, the INTEGER storage class includes six different integer types. In many cases, you can use storage classes and data types interchangeably.

The following table illustrates five storage classes in SQLite:

Storage Class	Meaning
NULL	NULL values mean missing information or unknown.
INTEGER	Integer values are whole numbers (either positive or negative). An integer can have variable sizes such as 1, 2,3, 4, or 8 bytes.
REAL	Real values are real numbers with decimal values that use 8-byte floats.
TEXT	TEXT is used to store character data. The maximum length of TEXT is unlimited. SQLite supports various character encodings.
BLOB	BLOB stands for a binary large object that can store any kind of data. Theoretically, the maximum size of BLOB is unlimited.
*/
/*
SQLite determines the data type of a value based on its data type according to the following rules:

If a literal has no enclosing quotes and decimal point or exponent, SQLite assigns the REAL storage class.
If a literal is enclosed by single or double quotes, SQLite assigns the TEXT storage class.
If a literal has no quotes, no decimal point, and no exponent, SQLite assigns the INTEGER storage class.
If a literal is NULL without quotes, SQLite assigns the NULL storage class.
If a literal has a prefix X’…’, SQLite assigns the BLOB storage class.
*/
/*
SQLite does not support built-in date and time storage classes. However, you can use the TEXT, INT, or REAL to store date and time values. For detailed information on handling date and time values, check out the SQLite date and time tutorial.

SQLite provides the typeof() function that allows you to check the storage class of a value based on its format. See the following example:
*/
SELECT
  TYPEOF(100) AS int_type,
  TYPEOF(10.0) AS real_type,
  TYPEOF('100') AS text_type,
  TYPEOF(X'1000') AS blob_type, --noqa
  TYPEOF(NULL) AS null_type;

/*
First, create a new table named test_datatypes for testing.
*/
DROP TABLE IF EXISTS test_datatypes;

CREATE TABLE test_datatypes (id INTEGER PRIMARY KEY, val);

--noqa
/*
Second, insert data into the test_datatypes table.
*/
INSERT INTO
  test_datatypes (val)
VALUES
  (1),
  (2),
  (10.1),
  (20.5),
  ('A'),
  ('B'),
  (NULL),
  (x'0010'), --noqa
  (x'0011');

--noqa
/*
Third, use the typeof() function to get the data type of each value stored in the val column.
*/
SELECT
  id,
  val,
  TYPEOF(val)
FROM
  test_datatypes;

/*
You may ask how SQLite sorts data in a column with different storage classes like val column above.

To resolve this, SQLite provides the following set of rules when it comes to sorting:

NULL storage class has the lowest value. It is lower than any other value. Between NULLs, there is no order.
The next higher storage classes are INTEGER and REAL. SQLite compares INTEGER and REAL numerically.
The next higher storage class is TEXT. SQLite uses the collation of TEXT values when comparing the TEXT values.
The highest storage class is the BLOB. SQLite uses the C function memcmp() to compare BLOB values.
*/
/*
You may ask how SQLite sorts data in a column with different storage classes like val column above.

To resolve this, SQLite provides the following set of rules when it comes to sorting:

NULL storage class has the lowest value. It is lower than any other value. Between NULLs, there is no order.
The next higher storage classes are INTEGER and REAL. SQLite compares INTEGER and REAL numerically.
The next higher storage class is TEXT. SQLite uses the collation of TEXT values when comparing the TEXT values.
The highest storage class is the BLOB. SQLite uses the C function memcmp() to compare BLOB values.
When you use the ORDER BY clause to sort the data in a column with different storage classes, SQLite performs the following steps:

First, group values based on storage class: NULL, INTEGER, and REAL, TEXT, and BLOB.
Second, sort the values in each group.
The following statement sorts the mixed data in the val column of the test_datatypes table:
*/
SELECT
  id,
  val,
  TYPEOF(val)
FROM
  test_datatypes
ORDER BY
  val;

/*

Other important concepts related to SQLite data types are manifest typing and type affinity:

Manifest typing means that a data type is a property of a value stored in a column, rather than a property of the column itself. SQLite uses manifest typing to store values of any type in a column.
Type affinity of a column refers to the recommended type for data stored in that column. Please note that this is a recommendation rather than an enforcement. Therefore, a column can store values of any type.

*/
