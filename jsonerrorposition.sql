/*
Introduction to the SQLite json_error_position() function
When working with JSON data, you may encounter JSON syntax errors.

To identify the exact location of the error within a JSON string, you can use the json_error_position() function.

The json_error_position() function returns the character position of the first syntax error in a JSON string.

Here’s the syntax of the json_error_position() function:

json_error_position(json_string)
In this syntax:

json_string is the JSON string that you want to check for errors.
SQLite json_error_positition() function examples
Let’s take some examples of using the json_error_position() function.

Checking well-formed JSON strings
*/
SELECT JSON_ERROR_POSITION('{"name":"John", "age":30}') AS position;

/*
The function returns 0, indicating that the input JSON string has no error.

2) Checking malformed JSON strings
*/
SELECT JSON_ERROR_POSITION('{"name":"John", "age":30') AS position;

/*
In this example, the JSON string does not have the closing brace. Therefore, the json_error_position() function returns the position of the error, which is 25 in this case.

3) Using SQLite json_error_position() function with table data
First, create a table called user_profiles:
*/
DROP TABLE IF EXISTS user_profiles;

CREATE TABLE user_profiles (
  id INTEGER PRIMARY KEY,
  profile_data JSON NOT NULL
);

/*
Second, insert rows into the user_profiles table:
*/
INSERT INTO user_profiles
  (profile_data)
VALUES
  (
    '{"username": "john_doe", "email": "john@example.com", "full_name": "John Doe", "role": "admin", "created_at": "2024-04-27T08:00:00Z"}'
  ),
  (
    '{"username": "alice_smith", "email": "alice@example.com", "full_name": "Alice Smith", "role": "editor", "created_at": "2024-04-27T09:15:00Z"}'
  ),
  (
    '{"username": "bob_jones", "email": "bob@example.com", "full_name": "Bob Jones", "role": "user", "created_at": "2024-04-27T10:30:00Z"}'
  ),
  ('malformed JSON here');

/*
Third, use the json_error_position() function to list all user profiles and highlight any errors if present:
*/
SELECT
  id,
  profile_data,
  CASE
    WHEN JSON_ERROR_POSITION(profile_data) = 0 THEN 'Valid'
    ELSE 'Invalid JSON at position ' || JSON_ERROR_POSITION(profile_data)
  END AS json_status
FROM user_profiles;
