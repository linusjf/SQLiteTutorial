/*
There are several ways to dump data from an SQLite database to a CSV file.

Export SQLite Database to a CSV file using sqlite3 tool
SQLite project provides you with a command-line program called sqlite3 or sqlite3.exe on Windows. By using the sqlite3 tool, you can use the SQL statements and dot-commands to interact with the SQLite database.

To export data from the SQLite database to a CSV file, you use these steps:

Turn on the header of the result set using the .header on command.
Set the output mode to CSV to instruct the sqlite3 tool to issue the result in the CSV mode.
Send the output to a CSV file.
Issue the query to select data from the table to which you want to export.
The following commands select data from the customers table and export it to the data.csv file.
*/
/* sql-formatter-disable */
-- noqa:disable=all
.headers on
.mode csv
.output data.csv
SELECT customerid,firstname,lastname,company FROM customers;
/*
Besides using the dot-commands, you can use the options of the sqlite3 tool to export data from the SQLite database to a CSV file.

For example, the following command exports the data from the tracks table to a CSV file named tracks.csv.

>sqlite3 -header -csv c:/sqlite/chinook.db "select * from tracks;" > tracks.csv

If you have a file named query.sql that contains the script to query data, you can execute the statements in the file and export data to a CSV file.

>sqlite3 -header -csv c:/sqlite/chinook.db < query.sql > data.csv
*/
