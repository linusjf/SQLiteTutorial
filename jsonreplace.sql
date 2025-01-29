/*
In SQLite, the json_replace() function replaces one or more values in JSON data based on specified paths.

Here’s the syntax of the json_replace() function:

json_replace(json_data, path1, value1, path2, value2, ...)
In this syntax:

json_data is the JSON data that you want to update. It can be a literal JSON or a table column that stores JSON data.
path1, path2, … are the JSON path that locates the elements in json_data to update.
value1, value2, … are the new values for updating.
The json_replace() function returns the new JSON data after updating the value1, value2, … at the corresponding path1, path2, …

It’s important to note that the json_replace() function will not create the element if a path does not exist. This is the main difference between the json_replace() and json_set() functions.

The json_set() function overwrites the value if the path exists or creates a new value if the path does not exist.

The json_replace() updates values sequentially from left to right. It means that the json_repalce() function will use the result of the previous update for the next one.

First, create a table called events:
*/
DROP TABLE IF EXISTS events;

CREATE TABLE events (
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
Third, use the json_replace() function to update the date of the event with id 1:
*/
UPDATE events
SET data = JSON_REPLACE(data, '$.date', '2024-05-10')
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
The output shows that the event_date has been updated successfully.

Fourth, use the json_replace() function to update the time and venue:
*/
UPDATE events
SET data = JSON_REPLACE(
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
