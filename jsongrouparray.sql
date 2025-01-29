/*
In SQLite, the json_group_array() function allows you to aggregate values into a JSON array.

Here’s the syntax of the json_group_array() function:

json_group_array(x)
In this syntax:

x: is a column that contains values you want to aggregate into a JSON array.
The json_group_array() function returns a JSON array that contains values from the x column.

SQLite json_group_array() function example
We’ll use the albums and tracks table from the sample database:

The following example uses the json_group_array() function to aggregate track names of albums into a JSON array:
*/
SELECT
  albums.title,
  JSON_GROUP_ARRAY(tracks.name) AS tracks
FROM
  tracks
  INNER JOIN albums USING (albumid)
GROUP BY albums.title
ORDER BY albums.title DESC
LIMIT 20;
/*
How it works.

First, join the albums table with the tracks table by matching the values in the AlbumId column in both tables.

Second, group the tracks by album titles using the GROUP BY clause.

Third, aggregate track names in each album into a JSON array using the json_group_array() function.
*/
