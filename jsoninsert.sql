/*
In SQLite, the json_insert() function inserts one or more values into JSON data using specified paths.

Here’s the syntax of the json_insert() function:

json_insert(json_value, path1, value1, path2, value2, ....);
In this syntax:

json_value is the json value that you want to insert. It can be literal JSON or a table column that stores JSON data.
path1, path2, … are the JSON paths that specify locations in the json_value to insert. If the paths already exist, the json_insert() function will do nothing.
value1, value2, … are the JSON values that you want to insert into json_value at the corresponding path1, path2, …
The json_insert() function returns the updated json after inserting value1, value2, … at the specified paths path1, path2, …

First, create a table contacts to store contact data:
*/
DROP TABLE IF EXISTS contacts;

CREATE TABLE contacts (
  id INTEGER PRIMARY KEY,
  data TEXT NOT NULL
);

/*
We’ll store contact details as JSON data in the data column.

Second, insert a row into the contacts table:
*/
INSERT INTO contacts
  (data)
VALUES
  ('{"name": "John"}');

/*
Third, retrieve data from the contacts table:
*/
SELECT
  *
FROM contacts;

/*

Fourth, insert the email into the JSON data stored in the contacts table:
*/
UPDATE contacts
SET data = JSON_INSERT(data, '$.email', 'john@test.com')
WHERE id = 1;

/*
Verify the insert:
*/
SELECT data
FROM contacts
WHERE id = 1;

/*
The output indicates that the statement successfully inserted the email property with the value "john@test.com" into the JSON data of the contact with id 1.

Fifth, insert home phone and work phone at the same time into the contact’s data:
*/
UPDATE contacts
SET data = JSON_INSERT(
  data,
  '$.home_phone',
  '(408)-111-1111',
  '$.work_phone',
  '(408)-222-2222'
)
WHERE id = 1;

/*
Sixth, insert a JSON array into the JSON data of the contact id 1:
*/
UPDATE contacts
SET data = JSON_INSERT(data, '$.kids', JSON_ARRAY('Alice', 'Bob'))
WHERE id = 1;

/*
In this example, we use the json_array() function to create a JSON array from the Alice and Bob strings.

Verify the insert:
*/
SELECT data
FROM contacts
WHERE id = 1;
