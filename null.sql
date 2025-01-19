/*
Introduction to SQLite NOT NULL constraint
When you create a table, you can specify whether a column acceptsNULL values or not. By default, all columns in a table accept NULL values except you explicitly use NOT NULL constraints.

To define a NOT NULL constraint for a column, you use the following syntax:

CREATE TABLE table_name (
...,
column_name type_name NOT NULL,
...
);
Unlike other constraints such as PRIMARY KEY and CHECK, you can only define NOT NULL constraints at the column level, not the table level.

Based on the SQL standard, PRIMARY KEY should always imply NOT NULL. However, SQLite allows NULL values in the PRIMARY KEY column except that a column is INTEGER PRIMARY KEY column or the table is a WITHOUT ROWID table or the column is defined as a NOT NULL column.

This is due to a bug in some early versions. If this bug is fixed to conform with the SQL standard, then it might break the legacy systems. Therefore, it has been decided to allow NULL values in the  PRIMARY KEY column.

Once a NOT NULL constraint is attached to a column, any attempt to set the column value to NULL such as inserting or updating will cause a constraint violation.

SQLite NOT NULL constraint example
The following example creates a new table named suppliers:
*/
DROP TABLE IF EXISTS suppliers;

CREATE TABLE suppliers (
  supplier_id INTEGER PRIMARY KEY,
  name TEXT NOT NULL
);

/*
In this example, the supplier_id is the PRIMARY KEY column of the suppliers table. Because this column is declared as INTEGER PRIMARY KEY, it will not accept NULL values.

The name column is also declared with a NOT NULL constraint, so it will accept only non-NULL values.

The following statement attempt to insert a NULL into the name column of the suppliers table:
*/
INSERT INTO suppliers
  (name)
VALUES
  (NULL);
/*
The statement fails due to the NOT NULL constraint violation. Here is the error message:

SQL Error [19]: [SQLITE_CONSTRAINT]  Abort due to constraint violation (NOT NULL constraint failed: suppliers.name)
*/
