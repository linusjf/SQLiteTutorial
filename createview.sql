/*
What is a view
In database theory, a view is a result set of a stored query. A view is the way to pack a query into a named object stored in the database.

You can access the data of the underlying tables through a view. The tables that the query in the view definition refers to are called base tables.

A view is useful in some cases:

First, views provide an abstraction layer over tables. You can add and remove the columns in the view without touching the schema of the underlying tables.
Second, you can use views to encapsulate complex queries with joins to simplify the data access.
SQLite view is read only. It means you cannot use INSERT, DELETE, and  UPDATE statements to update data in the base tables through the view.

SQLite CREATE VIEW statement
To create a view, you use the CREATE VIEW statement as follows:

CREATE [TEMP] VIEW [IF NOT EXISTS] view_name[(column-name-list)]
AS 
select-statement;
First, specify a name for the view. The IF NOT EXISTS option only creates a new view if it doesn’t exist. If the view already exists, it does nothing.

Second, use the the TEMP or TEMPORARY option if you want the view to be only visible in the current database connection. The view is called a temporary view and SQLite automatically removes the temporary view whenever the database connection is closed.

Third, specify a  SELECT statement for the view. By default, the columns of the view derive from the result set of the SELECT statement. However, you can assign the names of the view columns that are different from the column name of the table
*/
/*
Let’s take some examples of creating a new view using the CREATE VIEW statement.

1) Creating a view to simplify a complex query
The following query gets data from the tracks, albums, media_types and genres tables in the sample database using the inner join clause.
*/
SELECT
  tracks.trackid,
  tracks.name,
  albums.title AS album,
  media_types.name AS media,
  genres.name AS genres
FROM
  tracks
  INNER JOIN albums ON tracks.albumid = albums.albumid
  INNER JOIN media_types ON tracks.mediatypeid = media_types.mediatypeid
  INNER JOIN genres ON tracks.genreid = genres.genreid;

/*
MySQL CREATE VIEW example
To create a view based on this query, you use the following statement:
*/
DROP VIEW IF EXISTS v_tracks;

CREATE VIEW v_tracks AS
  SELECT
    tracks.trackid,
    tracks.name,
    albums.title AS album,
    media_types.name AS media,
    genres.name AS genres
  FROM
    tracks
    INNER JOIN albums ON tracks.albumid = albums.albumid
    INNER JOIN media_types ON tracks.mediatypeid = media_types.mediatypeid
    INNER JOIN genres ON tracks.genreid = genres.genreid;

/*
From now on, you can use the following simple query instead of the complex one above.
*/
SELECT
  *
FROM v_tracks;

/*
Creating a view with custom column names
The following statement creates a view named v_albums that contains album title and the length of album in minutes:
*/
DROP VIEW IF EXISTS v_albums;

CREATE VIEW v_albums (albumtitle, minutes) AS
  SELECT
    albums.title AS albumtitle,
    SUM(tracks.milliseconds) / 60000 AS minutes
  FROM
    tracks
    INNER JOIN albums USING (albumid)
  GROUP BY albumtitle;

/*
In this example, we specified new columns for the view AlbumTitle for the albums.title column and Minutes for the expression SUM(milliseconds) / 60000

This query returns data from the v_albums view:
*/
SELECT
  *
FROM v_albums;
