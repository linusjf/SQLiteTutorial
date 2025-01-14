/*
Let’s start with two tables: suppliers and supplier_groups :
*/
PRAGMA foreign_keys;

PRAGMA foreign_keys = ON;

PRAGMA foreign_keys;

DROP TABLE IF EXISTS suppliers;

DROP TABLE IF EXISTS supplier_groups;

CREATE TABLE suppliers (
  supplier_id INTEGER PRIMARY KEY,
  supplier_name TEXT NOT NULL,
  group_id INTEGER NOT NULL
);

CREATE TABLE supplier_groups (
  group_id INTEGER PRIMARY KEY,
  group_name TEXT NOT NULL
);

PRAGMA table_info ([suppliers]);

PRAGMA foreign_key_list ([suppliers]);

/*
Assuming that each supplier belongs to one and only one supplier group. And each supplier group may have zero or many suppliers. The relationship between supplier_groups and suppliers tables is one-to-many. In other words, for each row in the suppliers table, there is a corresponding row in the supplier_groups table.

Currently, there is no way to prevent you from adding a row to the suppliers table without a corresponding row in the supplier_groups table.

In addition, you may remove a row in the supplier_groups table without deleting or updating the corresponding rows in the suppliers table. This may leave orphaned rows in the suppliers table.

To enforce the relationship between rows in the suppliers and supplier_groups table, you use the foreign key constraints.

To add the foreign key constraint to the suppliers table, you change the definition of the  CREATE TABLE statement above as follows:
*/
DROP TABLE IF EXISTS suppliers;

CREATE TABLE suppliers (
  supplier_id INTEGER PRIMARY KEY,
  supplier_name TEXT NOT NULL,
  group_id INTEGER NOT NULL,
  FOREIGN KEY (group_id) REFERENCES supplier_groups (group_id)
);

PRAGMA table_info ([suppliers]);

PRAGMA foreign_key_list ([suppliers]);

/*
The supplier_groups table is called a parent table, which is the table that a foreign key references. The suppliers table is known as a child table, which is the table to which the foreign key constraint applies.

The group_id column in the supplier_groups table is called the parent key, which is a column or a set of columns in the parent table that the foreign key constraint references. Typically, the parent key is the primary key of the parent table.

The group_id column in the suppliers table is called the child key. Generally, the child key references to the primary key of the parent table.
*/
/*
First, insert three rows into the supplier_groups table.
*/
INSERT INTO
  supplier_groups (group_name)
VALUES
  ('Domestic'),
  ('Global'),
  ('One-Time');

/*
SQLite Foreign Key - Supplier Groups
Second, insert a new supplier into the suppliers table with the supplier group that exists in the supplier_groups table.
*/
INSERT INTO
  suppliers (supplier_name, group_id)
VALUES
  ('HP', 2);

/*
This statement works perfectly fine.

Third, attempt to insert a new supplier into the suppliers table with the supplier group that does not exist in the supplier_groups table.
*/
INSERT INTO
  suppliers (supplier_name, group_id)
VALUES
  ('ABC Inc.', 4);

PRAGMA foreign_key_list ([suppliers]);

/*
SQLite checked the foreign key constraint, rejected the change, and issued the following error message:
*/
SELECT
  *
FROM
  suppliers;

SELECT
  *
FROM
  supplier_groups;
