/*
Upsert is a combination of update and insert. Upsert inserts a new row if a specified unique identifier does not exist or updates an existing row if the same identifier already exists in a table.

Here’s the syntax for performing an upsert:

INSERT INTO table_name(column_list)
VALUES(value_list)
ON CONFLICT(conflict_column)
DO
UPDATE SET column_name = expression
WHERE conflict_condition;
Code language: SQL (Structured Query Language) (sql)
In this syntax:

The INSERT INTO ... VALUES part defines the basic insert statement that inserts values into a specified column of a table.
ON CONFLICT (conflict_colum) clause introduces the upsert behavior. If a conflict occurs in the conflict_column, it should take an action.
DO marks the beginning of the conflict resolution strategy.
UPDATE SET allows you to update existing rows when a conflict occurs. The optional WHERE clause defines which rows to update during a conflict. It is useful when you want to update only specific rows that meet the conflict_condition.
If you don’t want to take action when a conflict occurs, you can use the DO NOTHING strategy like this:

INSERT INTO table_name(column_list)
VALUES(value_list)
ON CONFLICT(conflict_column)
DO NOTHING;
*/
/*
If you attempt to insert or update a row that causes a unique constraint violation specified in the ON CONFLICT clause, the DO clause will take over.

The UPDATE clause following the DO keyword can use the excluded keyword to access the values you were trying to insert or update.

For example, if a row that you want to insert into a table is (name, email, phone), you can access the values of the row via the excluded keyword as follows:

excluded.name
excluded.email
excluded.phone
*/
/*
Basic SQLite upsert example
First, create a table called search_stats to store the searched keywords and the number of searches:
*/
DROP TABLE IF EXISTS search_stats;

CREATE TABLE search_stats (
  id INTEGER PRIMARY KEY,
  keyword TEXT UNIQUE NOT NULL,
  search_count INT NOT NULL DEFAULT 1
);

/*
Second, insert a row into the search_stats table:
*/
INSERT INTO
  search_stats (keyword)
VALUES
  ('SQLite');

/*
Third, insert a row into the search_stats table with the same keyword. If the keyword already exists in the table, increase the search_count by one:
*/
INSERT INTO
  search_stats (keyword)
VALUES
  ('SQLite')
ON CONFLICT (keyword) DO UPDATE
SET
  search_count = search_count + 1;

/*
Fourth, retrieve data from the search_stats table:
*/
SELECT
  *
FROM
  search_stats;

/*
Selective Update on Conflict
First, create a new table called contacts to store the contact information:
*/
DROP TABLE IF EXISTS contacts;

CREATE TABLE IF NOT EXISTS contacts (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT UNIQUE NOT NULL,
  phone TEXT NOT NULL,
  effective_date date NOT NULL
);

/*
Next, insert a new row into the contacts table:
*/
INSERT INTO
  contacts (name, email, phone, effective_date)
VALUES
  (
    'Jane Doe',
    'jane@test.com',
    '(408)-111-2222',
    '2024-04-05'
  );

/*
Then, verify the insert:
*/
SELECT
  *
FROM
  contacts;

/*
After that, update the name, phone, and effective date if the email already exists and only update when the new effective date is later than the current effective date:
*/
INSERT INTO
  contacts (name, email, phone, effective_date)
VALUES
  (
    'Jane Smith',
    'jane@test.com',
    '(408)-111-3333',
    '2024-05-05'
  )
ON CONFLICT (email) DO UPDATE
SET
  name = excluded.name,
  phone = excluded.phone,
  effective_date = excluded.effective_date
WHERE
  excluded.effective_date > contacts.effective_date;

/*
Finally, verify the update:
*/
SELECT
  *
FROM
  contacts;
