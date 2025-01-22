/*
SQLite project delivers the sqlite3 tool that allows you to interact with the SQLite database using a command-line program.

By using the sqlite3 tool, you can use the SQL statements to query or update data in the database. Also, you can use special commands, which are known as dot commands to perform various useful database operations.

One of these dot-commands is the  .dump command that gives you the ability to dump the entire database or tables into a text file.

Dump the entire database into a file using the SQLite dump command
The following command opens a new SQLite database connection to the chinook.db file.

C:\sqlite>sqlite3 c:/sqlite/chinook.db
SQLite version 3.13.0 2016-05-18 10:57:30
Enter ".help" for usage hints.
sqlite>
To dump a database into a file, you use the .dump command. The .dump command converts the entire structure and data of an SQLite database into a single text file.

By default, the .dump command outputs the SQL statements on screen. To issue the output to a file, you use the .output FILENAME command.

The following commands specify the output of the dump file to chinook.sql and dump the chinook database into the chinook.sql file.
*/
/* sql-formatter-disable */
-- noqa:disable=all
.output chinook.sql
.dump
/*
Dump a specific table using the SQLite dump command
To dump a specific table, you specify the table name after the .dump command. For example, the following command saves the albums table to the albums.sql file.
*/
.output albums.sql
.dump albums
/*
The following picture shows the contents of the albums.sql file.

Dump tables structure only using schema command
To dump the table structures in a database, you use the .schema command.

The following commands set the output file to chinook_structure.sql file and save the table structures into the chinook_structure.sql file:
*/
.output chinook_structure.sql
.schema
/*
Dump data of one or more tables into a file
To dump the data of a table into a text file, you use these steps:

First, set the mode to insert using the .mode command as follows:
*/
.mode insert
/*
From now on, every SELECT statement will issue the result as the INSERT statements instead of pure text data.

Second, set the output to a text file instead of the default standard output. The following command sets the output file to the data.sql file.
*/
.output data.sql
/*
Third, issue the SELECT statements to query data from a table that you want to dump. The following command returns data from the artists table.
*/
select * from artists;
/*
Check the content of the data.sql file, if everything is fine, you will see the following output:

SQLite dump data only
To dump data from other tables, you need to issue the SELECT statements to query data from those tables.
*/
