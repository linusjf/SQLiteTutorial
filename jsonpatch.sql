/*
The json_patch() function merges and patches the second JSON object to the original JSON object. It allows you to add, update, or delete elements within the original JSON object and returns the patched JSON object.

SQLite json_patch() function implements the RFC-7396 MergePatch algorithm to patch a JSON with a specified patch.

Here’s the syntax of the json_patch() function:

json_patch(T, P)
In this syntax:

T is the original JSON object.
P is the patch object.
The json_patch() function applies the patch P against input T and returns the patched copy of T.

It’s important to note that the json_patch() cannot add, update, or remove elements of a JSON array. It can only insert, update, or delete the whole array as a single unit.

Let’s take some examples of using the json_patch() function.

1) Inserting a new member
The following example uses the json_patch() function to insert a new member into a JSON object:
*/
SELECT JSON_PATCH('{ "name" : "John" }', '{ "age" : 22 }') AS person;

/*
2) Updating an existing member
The following example uses the json_patch() function to update the name of an existing member in a JSON object:
*/
SELECT JSON_PATCH('{ "name" : "Jane Doe" }', '{ "name" : "Jane Smith" }') AS person;

/*
3) Updating multiple key/value pairs
The following example uses the json_patch() function to update both the name and age of a JSON object:
*/
SELECT
  JSON_PATCH(
    '{ "name" : "Jane Doe", "age": 21 }',
    '{ "name" : "Jane Smith", "age": 22}'
  ) AS person;

/*
4) Updating and Inserting
The following example uses the json_patch() function to update the name and insert the age into a JSON object:
*/
SELECT
  JSON_PATCH(
    '{ "name" : "Jane Doe" }',
    '{ "name" : "Jane Smith", "age" : 22 }'
  ) AS person;

/*
5) Deleting a member
To delete a member, you use NULL in the patch object. For example, the following statement uses the json_patch() to remove the age member from a JSON object:
*/
SELECT
  JSON_PATCH(
    '{ "name" : "Jane Smith", "age" : 25}',
    '{ "age" : null }'
  ) AS person;
