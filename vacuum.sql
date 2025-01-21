/*
Why do you need SQLite VACUUM command
First, when you drop database objects such as tables, views, indexes, and triggers or delete data from tables, the database file size remains unchanged. Because SQLite just marks the deleted objects as free and reserves it for the future uses. As a result, the size of the database file always grows in size.

Second, when you insert or delete data from the tables, the indexes and tables become fragmented, especially for the database that has a high number of inserts, updates, and deletes.

Third, the insert, update and delete operations create unused data block within individual database pages. It decreases the number of rows that can be stored in a single page. Therefore, it increases the number of pages to hold a table. Because of this, it increases storage overhead for the table, takes more time to read/write, and decreases the cache performance.

SQLite VACUUM
SQLite provides the VACUUM command to address all three issues above.

SQLite first copies data within a database file to a temporary database. This operation defragments the database objects, ignores the free spaces, and repacks individual pages. Then, SQLite copies the content of the temporary database file back to the original database file. The original database file is overwritten.

Because the VACUUM command rebuilds the database, you can use it to change some database-specific configuration parameters such as page size, page format, and default encoding. To do this, you set new values using pragma and then vacuum the database.
*/
/*
The SQLite VACUUM command
The VACUUM command does not change the content of the database except the rowid values. If you use INTEGER PRIMARY KEY column, the VACUUM does not change the values of that column. However, if you use unaliased rowid, the VACUUM command will reset the rowid values. Besides changing the rowid values, the VACUUM command also builds the index from scratch.

It is a good practice to perform the VACUUM command periodically, especially when you delete large tables or indexes from a database.

It is important to note that the VACCUM command requires storage to hold the original file and also the copy. Also, the VACUUM command requires exclusive access to the database file. In other words, the VACUUM command will not run successfully if the database has a pending SQL statement or an open transaction.

Currently, as of version 3.9.2, you can run the VACUUM command on the main database, not the attached database file.

Even though SQLite enables the auto-vacuum mode that triggers the vacuum process automatically with some limitations. It is a good practice to run the VACUUM command manually.

*/
/*
How to run the SQLite VACUUM command
The following shows how to run the VACUUM command:
*/
-- noqa:disable=all
VACUUM;

-- noqa:enable=all
/*
Make sure that there is no open transaction while you’re running the command.

The following statement enables full auto-vacuum mode:
*/
PRAGMA auto_vacuum = FULL;

/*
To enable incremental vacuum, you use the following statement:
*/
PRAGMA auto_vacuum = INCREMENTAL;

/*
The following statement disables auto-vacuum mode:
*/
PRAGMA auto_vacuum = NONE;

/*
VACUUM with an INTO clause
Here is syntax of the VACUUM with INTO clause:

VACUUM schema-name INTO filename;
The VACUUM statement with an INTO clause keeps the original database file unchanged and creates a new database with the file name specified. The new database will contain the same logical content as the original database, but fully vacuumed.

The filename in the INTO clause can be any SQL expression that evaluates to a string. It must be a path to a file that does not exist or to an empty file, or the VACUUM INTO command will result in an error.

The VACUUM command is very useful for generating backup copies of a live database. It is transactional safe, which the generated database is a consistent snapshot of the original database. However, if a unplanned shutdown or power lose interupts the command, the generated database might be corrupted.

The following statement uses the VACUUM INTO command to generate a new database with the file name chinook_backup.db whose data is copied from of the main schema of the chinook database:
*/
VACUUM main INTO 'chinook_backup.db';
