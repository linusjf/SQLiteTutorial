/*
The json_each() function is a table-valued function that extracts and iterates over top-level elements in a JSON object or array.

Here’s the syntax of the json_each() function:

json_each(json_data)
In this syntax:

json_data is a JSON object or array that you want to iterate.
The json_each() function returns a set of rows, each representing an element in the json_data. The resulting table includes the following columns:

key: is the key of the object element or the index of the array element.
value: is the value of the element.
type: is the data type of the value such as integer, text, real, null, or object.
atom: is the atomic value of the element such as the number, string, or null.
id: is the identifier for the top-level JSON value (useful for joining with other json_each() results).
parent: is the identifier of the parent JSON value (useful for hierarchical queries).
fullkey: is the full key path to the element.
path: is the JSON path to the element.
If you want to iterate over a JSON object or array specified by a path, you can use the following syntax:

json_each(json_data, path)
In this syntax:

json_data is the JSON string you want to select a JSON object or array to iterate.
path is the JSON path expression that selects a JSON object or array for iteration.
Because the json_each() function is a table-valued function, you have to use it in the place that accepts a table such as in the FROM clause of the SELECT statement.

If you don’t do so, you’ll encounter the following error:

Parse error: no such function: json_each
SQLite json_each() function examples
Let’s take some examples of using the json_each() function.

1) Iterating elements of a JSON object
The following example uses the json_each() function to iterate over elements of a JSON object:
*/
SELECT
  *
FROM
  JSON_EACH(
    '{
  "name": "John Doe",
  "age": 30,
  "skills": ["SQL", "SQLite", "JSON"]
}'
  );

/*
2) Iterating elements of a JSON array
The following example uses the json_each() function to iterate over elements of a JSON array:
*/
SELECT
  *
FROM
  JSON_EACH(
    '{
  "name": "John Doe",
  "age": 30,
  "skills": ["SQL", "SQLite", "JSON"]
}',
    '$.skills'
  );

/*
3) Aggregating JSON array elements
The following example uses the json_each() function with the SUM() function to calculate the total of numbers in a JSON array:
*/
SELECT SUM(CAST(value AS INTEGER)) AS total
FROM JSON_EACH('[1, 2, 3, 4]');

/*
4) Using the json_each() function with table data
First, create a table called member_profiles to store member profile data:
*/
DROP TABLE IF EXISTS member_profiles;

CREATE TABLE member_profiles (
  id INTEGER PRIMARY KEY,
  profile_data TEXT NOT NULL
);

/*
Second, insert JSON data into the member_profiles table:
*/
INSERT INTO member_profiles
  (profile_data)
VALUES
  ('{"name": "Alice", "age": 30, "skills": ["SQL", "SQLite", "JSON"]}'),
  ('{"name": "Bob", "age": 25, "skills": ["Python", "Django", "APIs"]}'),
  (
    '{"name": "Charlie", "age": 35, "skills": ["JavaScript", "React", "Node.js"]}'
  );

/*
Third, extract all the key-value pairs from the profile_data column using the json_each() function:
*/
SELECT
  member_profiles.id,
  profile.key,
  profile.value
FROM
  member_profiles
  CROSS JOIN JSON_EACH(member_profiles.profile_data) AS profile;
