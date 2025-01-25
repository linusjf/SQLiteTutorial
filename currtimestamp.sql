/*
The current_timestamp function returns the current date and time in UTC in the format YYYY-MM-DD HH:MM:SS.

Here’s the syntax of the current_timestamp function:

<code>current_timestamp</code>
Note that the current_timestamp function does not have the opening and closing parentheses ()

In practice, you’ll use the current_timestamp function to insert or update a column value with the current date and time.

SQLite current_timestamp function examples
Let’s explore some examples of using the current_timestamp function.

1) Basic current_timestamp function example
The following example uses the current_timestamp function to return the current date and time in UTC:
*/
SELECT CURRENT_TIMESTAMP;

/*
To get the current date and time in local time, you pass the result of the current_timestamp function to the datetime() function and use the 'localtime' modifier as follows:
*/
SELECT DATETIME(CURRENT_TIMESTAMP, 'localtime') AS `CURRENT_TIMESTAMP`;

/*
2) Using the current_timestamp function as the default value for a column
First, create a table called notes:
*/
DROP TABLE IF EXISTS notes;

CREATE TABLE notes (
  id INTEGER PRIMARY KEY,
  note TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP
);

/*
In the notes table, both created_at and updated_at columns have default values of the current date and time. This means that when you insert rows into the notes table, these columns will automatically be populated with the current timestamp.

Second, insert a row into the notes table:
*/
INSERT INTO notes
  (note)
VALUES
  ('Learn SQLite current_timestamp function')
RETURNING *;

/*
The output indicates that SQLite uses the current date and time in UTC returned by the current_timestamp function to insert into the created_at and updated_at columns.

Third, create a conditional trigger that is invoked when a row in the notes table is updated, and the updated_at column is not the same as the current date and time:
*/
CREATE TRIGGER update_notes_updated_at
AFTER UPDATE ON notes
WHEN old.updated_at != CURRENT_TIMESTAMP
BEGIN
  UPDATE notes
  SET updated_at = CURRENT_TIMESTAMP
  WHERE id = old.id;
END;

/*
Without the WHEN clause, the trigger will create an infinite loop because it updates the updated_at column, which in turn fires the AFTER UPDATE trigger again.

Fourth, update the row with id 1:
*/
UPDATE notes
SET note = 'Learn SQLite current_timestamp'
WHERE id = 1;

/*
Finally, retrieve data from the notes table:
*/
SELECT
  *
FROM notes;
