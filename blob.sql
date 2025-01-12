/*
BLOB stands for Binary Large Object. In SQLite, you can use the BLOB data type to store binary data such as images, video files, or any raw binary data.

Here’s the syntax for declaring a column with the BLOB type:

column_name BLOB
Code language: SQL (Structured Query Language) (sql)
For example, the following statement creates a table called documents:
*/
DROP TABLE IF EXISTS documents;

CREATE TABLE documents (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  data BLOB NOT NULL
);

/*
In the documents table, the data column has the data type of BLOB. Therefore, you can store binary data in it.

Typically, you’ll use an external program to read a file such as an image, and insert the binary into a SQLite database.
*/
