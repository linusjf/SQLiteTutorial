/*
What are INSTEAD OF triggers in SQLite
In SQLite, an INSTEAD OF trigger can be only created based on a view, not a table.

Views are read-only in SQLite. And if you issue a DML statement such as INSERT, UPDATE, or DELETE against a view, you will receive an error.

When a view has an INSTEAD OF trigger, the trigger will fire when you issue a corresponding DML statement. This allows you to inject your own logic in the processing flow.

For example, if a view has an INSTEAD OF INSERT trigger, when you issue an INSERT statement, the trigger will fire automatically. Inside the trigger, you can perform insert, update, or delete data in the base tables.

In other words, the INSTEAD OF triggers allow views to become modifiable.

The following illustrates the syntax of creating an INSTEAD OF trigger in SQLite:

CREATE TRIGGER [IF NOT EXISTS] schema_name.trigger_name
INSTEAD OF [DELETE | INSERT | UPDATE OF column_name]
ON table_name
BEGIN
-- insert code here
END;
In this syntax:

First, specify the name of the trigger after the CREATE TRIGGER keywords. Use IF NOT EXISTS if you want to create the trigger if it exists only.
Second, use the INSTEAD OF keywords followed by a triggering event such as INSERT, UPDATE, or DELETE.
Third, specify the name of the view to which the trigger belongs.
Finally, specify the code that executes the logic.
*/
/*
SQLite INSTEAD OF trigger example
For the demonstration, we will use the Artists and Albums tables from the sample database.


First, create a view named AlbumArtists based on data from the Artists and Albums tables:
*/
DROP VIEW IF EXISTS albumartists;

CREATE VIEW albumartists (albumtitle, artistname) AS
  SELECT
    albums.title,
    artists.name
  FROM
    albums
    INNER JOIN artists USING (artistid);

/*
Second, use this query to verify data from the view:
*/
SELECT
  *
FROM albumartists;

/*
Third, insert a new row into the AlbumArtists view:
*/
INSERT INTO albumartists
  (albumtitle, artistname)
VALUES
  ('Who Do You Trust?', 'Papa Roach');

/*
SQLite issued the following error:

[SQLITE_ERROR] SQL error or missing database (cannot modify AlbumArtists because it is a view)
Fourth, create an INSTEAD OF trigger that fires when a new row is inserted into the AlbumArtists table:
*/
CREATE TRIGGER insert_artist_album_trg
INSTEAD OF INSERT ON albumartists
BEGIN
  -- insert the new artist first
  INSERT INTO artists
    (name)
  VALUES
    (new.artistname);

  -- use the artist id to insert a new album
  INSERT INTO albums
    (title, artistid)
  VALUES
    (new.albumtitle, LAST_INSERT_ROWID());
END;

/*
Second, use the last_insert_rowid() to get the generated value from the ArtistId column and insert a new row into the Albums table.
Finally, verify insert from the Artists and Albums tables:
*/
SELECT
  *
FROM artists
ORDER BY artistid DESC;

SELECT
  *
FROM albums
ORDER BY albumid DESC;
/*
As you can see the output, a new row has been inserted into the Artists and Albums tables.
*/
