/*
The json_set() function works like the json_replace() function except that the json_set() function does create a JSON value if it does not exist.

Here’s the syntax of the json_set() function:

json_set(json_data, path1, value1, path2, value2, ...)
In this syntax:

json_data is the JSON data you want to modify. It can be a literal JSON or a table column that stores JSON data.
path1, value1, path2, value2 path2, … are a pair of JSON paths and new values to update.
The json_set() function returns the new JSON data after updating the value1, value2, … at the corresponding path1, path2, …

Notice that the number of arguments of the json_set is always odd. The first argument is the input JSON data. Subsequent arguments are pairs of JSON paths and values to update.

The json_set() function creates the JSON element if a path does not exist. This is the main difference between the json_replace() and json_set() functions:

Function	Overwrite if exists	Create if not exist
json_insert()	No	Yes
json_replace()	Yes	No
json_set()	Yes	Yes
The json_set() sequentially updates values from left to right. It means that the json_set() function uses the result of the previous update for the next one.

SQLite json_set() function example
First, create a table called events:
*/
DROP TABLE IF EXISTS events;

CREATE TABLE IF NOT EXISTS events (
  id INTEGER PRIMARY KEY,
  data TEXT NOT NULL
);

/*
Second, insert a new row into the events table:
*/
INSERT INTO events
  (data)
VALUES
  (
    '{
  "title": "Tech Conference 2024",
  "description": "A conference showcasing the latest trends in technology.",
  "date": "2024-04-30",
  "time": "09:00 AM",
  "location": {
    "venue": "Convention Center",
    "city": "New York",
    "country": "USA"
  },
  "organizers": [
    {
      "name": "Tech Events Company",
      "contact": "info@techeventscompany.com"
    },
    {
      "name": "New York Tech Association",
      "contact": "contact@nytech.com"
    }
  ],
  
  "topics": [
    "Artificial Intelligence",
    "Blockchain",
    "Internet of Things",
    "Cybersecurity"
  ]
}'
  );

/*
Third, use the json_set() function to update the date of the event with id 1:
*/
UPDATE events
SET data = JSON_SET(data, '$.date', '2024-12-05')
WHERE id = 1;

/*
Verify the update:
*/
SELECT
  data ->> 'title' AS event_title,
  data ->> 'date' AS event_date
FROM events
WHERE id = 1;

/*
The output shows that the event_date has been updated to 05 December 2024 successfully.

Fourth, use the json_set() function to update the time and venue:
*/
UPDATE events
SET data = JSON_SET(
  data,
  '$.time',
  '08:30 AM',
  '$.location.venue',
  'Jacob K. Javits Convention Center'
)
WHERE id = 1;

/*
Verify the update:
*/
SELECT
  data ->> 'time' AS event_time,
  data ->> '$.location.venue' AS venue
FROM events
WHERE id = 1;

/*
Fifth, set the price of the event id 1 to 199.99 :
*/
UPDATE events
SET data = JSON_SET(data, '$.price', '199.99')
WHERE id = 1;

/*
Since the price does not exist, the json_set() function creates a new property price with a value of 199.99:
*/
SELECT
  data ->> 'title' AS event_title,
  data ->> '$.price' AS price
FROM events
WHERE id = 1;
