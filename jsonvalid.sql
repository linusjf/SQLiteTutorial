/*
The json_valid() function checks whether a string contains valid JSON.

Here’s the syntax of the json_valid() function:

json_valid(json_value)
In this syntax:

json_value is a string you want to check for a valid JSON format.
The json_valid() function returns 1 if the json_value is valid JSON, otherwise, it returns 0. The json_valid() function returns NULL if the input string is NULL.

SQLite json_valid() function examples
Let’s take some examples of using the json_valid() function.

1) Checking a valid JSON string
The following example uses the json_valid() function to check if a string is a valid JSON:
*/
SELECT JSON_VALID('{"name": "Bob"}') AS result;

/*
The json_valid() function returns 1 because the json string is valid.

2) Checking an invalid JSON string
*/
SELECT JSON_VALID('{age: 25}') AS result;

/*
This example returns 0 because the input json is invalid.

3) Using json_valid() function with table data
First, create a table called persons:
*/
DROP TABLE IF EXISTS persons;

CREATE TABLE persons (
  id INTEGER PRIMARY KEY,
  data TEXT
);

/*
Second, insert rows into the persons table:
*/
INSERT INTO persons
  (data)
VALUES
  ('{"name": "Alice", "age": 30}'),
  ('{"name": "Bob", "city": "New York"}'),
  ('invalid_json');

/*
Third, validate json data using the json_valid() function:
*/
SELECT
  id,
  data,
  JSON_VALID(data) AS is_valid
FROM persons;

/*
Defining well-formed JSON
Starting from the SQLite version 3.45.0, the json_valid() function has a second optional argument that defines what it means by “well-formed”.

json_valid(json_value, flags );
In this syntax:

json_value is a string that you want to check for valid JSON.
flags is an integer bitmask that specifies what constitutes “well-form” JSON.
SQLite defines the following bits of the flags:

0x01 – Check the json_value against the canonical RFC-8259 JSON, without any extensions.
0x02 – Check the json_value against the JSON5 extensions.
0x04 – If json_value is a BLOB that superficially appears to be SQLite’s internal binary  representation of JSON (JSONB)
0x08 – If json_value is a BLOB that strictly appears to be SQLite’s internal binary representation of JSON (JSONB)
By combining the above bits, you can form some useful flags. For example, flags 6 checks if the json_value is JSON5 text or JSONB.

The following example uses the json_valid() function to check if a JSON value is JSON5 text or JSONB:
*/
SELECT JSON_VALID('{"name": "Joe"}', 6) AS valid;
