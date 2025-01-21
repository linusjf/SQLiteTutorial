-- test
SELECT
  1 + 1;

-- - test
SELECT
  10 / 5 AS div,
  2 * 4 AS mult;

-- test
SELECT
  trackid,
  name,
  composer,
  unitprice
FROM tracks;

-- test
SELECT
  trackid,
  name,
  albumid,
  mediatypeid,
  genreid,
  composer,
  milliseconds,
  bytes,
  unitprice
FROM tracks;
