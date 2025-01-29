/*
Starting from version 3.38.0, SQLite supports the JSON operators -> and ->> for extracting subcomponents of JSON.

Here’s the syntax of the -> and ->> operators:

json -> path
json ->> path
In this syntax:

First, specify a JSON string or JSONB on the left side of the operator.
Second, specify a JSON path expression on the right side of the operator.
Both -> and ->> operators select subcomponents of JSON specified by the JSON path.

The -> operator returns a JSON representation whereas the ->> operator returns the SQL representation of the subcomponent.

It’s important to notice that the -> and ->> operators are different from the json_extract() function.

The json_extract() function returns JSON value if the subcomponent is a JSON array or object, and SQL value if the subcomponent is JSON null, string, or number.

Let’s take some examples of using the JSON operators.

1) Extracting scalar values
The following example uses the -> operator to extract the name from JSON:
*/
SELECT '{"name": "Joe"}' -> '$.name' AS name;

/*
In this example, the JSON path $.name selects the name property of the top-level object of JSON. The returned value is a JSON value denoted by the double quotes (").

The following statement uses the ->> operator to extract the name from JSON:
*/
SELECT '{"name": "Joe"}' ->> '$.name' AS name;

/*
The return value is an SQL value that is not surrounded by double quotes (“).

2) Extracting JSON arrays
The following example uses the -> operator to extract a JSON array from JSON:
*/
SELECT '{"name": "Jane", "skills": ["SQL","SQLite","Python"]}' -> '$.skills' AS skills;

/*
The return value is a JSON array.

The following example uses the ->> operator to extract an array from JSON:
*/
SELECT '{"name": "Jane", "skills": ["SQL","SQLite","Python"]}' ->> '$.skills' AS skills;

/*
The return value is an SQL value of the text type even though it looks like a JSON value.
*/
/*
3) Extracting JSON objects
The following example uses the -> operator to extract an object from JSON:
*/
SELECT '{
   "name": "Jane",
   "phones": {
      "work": "(408)-111-2222",
      "home": "(408)-111-3333"
   }
}' -> '$.phones' AS phones;

/*
The extracted value is a JSON object.

The following example uses the ->> operator to extract an object from JSON:
*/
SELECT '{
   "name": "Jane",
   "phones": {
      "work": "(408)-111-2222",
      "home": "(408)-111-3333"
   }
}' ->> '$.phones' AS phones;

/*
The extracted value is a text string.

4) Using SQLite JSON operators with table data
First, create a table called user_settings:
*/
DROP TABLE IF EXISTS user_settings;

CREATE TABLE user_settings (
  id INTEGER PRIMARY KEY,
  settings TEXT NOT NULL
);

/*
Second, insert rows into the user_settings table:
*/
INSERT INTO user_settings
  (settings)
VALUES
  (
    '{"user_id": 1, "preferences": {"theme": "dark", "font_size": 14}, "notifications": {"email": true, "sms": false}, "languages": ["en", "es"]}'
  ),
  (
    '{"user_id": 2, "preferences": {"theme": "light", "font_size": 12}, "notifications": {"email": true, "sms": true}, "languages": ["en", "de"]}'
  ),
  (
    '{"user_id": 3, "preferences": {"theme": "dark", "font_size": 16}, "notifications": {"email": false, "sms": false}, "languages": ["jp", "cn"]}'
  );

/*
Third, use the -> operator to extract user_id from the settings column:
*/
SELECT settings -> '$.user_id' AS user_id
FROM user_settings;

/*
Fourth, use the -> operator to extract the preferences property:
*/
SELECT settings -> '$.preferences' AS preferences
FROM user_settings;

/*
Fifth, use the -> operator to extract the languages as a JSON array:
*/
SELECT settings -> '$.languages' AS languages
FROM user_settings;

/*
Sixth, retrieve the user settings whose language has the word en:
*/
SELECT settings -> '$.languages' AS languages
FROM user_settings
WHERE settings ->> '$.languages' LIKE '%"en"%';
