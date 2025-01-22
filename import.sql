/*
Importing a CSV file into a table using sqlite3 tool
In the first scenario, you want to import data from CSV file into a table that does not exist in the SQLite database.

First, the sqlite3 tool creates the table. The sqlite3 tool uses the first row of the CSV file as the names of the columns of the table.
Second, the sqlite3 tool import data from the second row of the CSV file into the table.
We will import a CSV file named city.csv with two columns: name and population.

To import the c:\sqlite\city.csv file into the cities table:

First, set the mode to CSV to instruct the command-line shell program to interpret the input file as a CSV file. To do this, you use the .mode command as follows:
*/
/* sql-formatter-disable */
-- noqa:disable=all
.mode csv
/*
Second, use the command .import FILE TABLE to import the data from the city.csv file into the cities table.
*/
.import city.csv cities
/*
To verify the import, you use the command .schema to display the structure of the cities table.
*/
.schema cities
/*
To view the data of the cities table, you use the following SELECT statement.
*/
SELECT
name,
population
FROM
cities;

/*
In the second scenario, the table is already available in the database and you just need to import the data.

First, drop the cities table that you have created.
*/
DROP TABLE IF EXISTS cities;
/*
Second, use the following CREATE TABLE statement to create the table cities.
*/
CREATE TABLE cities (
  name TEXT NOT NULL,
  population INTEGER NOT NULL
);

/*
If the table already exists, the sqlite3 tool uses all the rows, including the first row, in the CSV file as the actual data to import. Therefore, you should delete the first row of the CSV file.

The following commands import the city_without_header.csv file into the cities table.
*/
.mode csv
.import city_wo_header.csv cities

SELECT
name,
population
FROM
cities;
