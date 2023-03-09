show databases;
use albums_db;
select database();
show tables;
show create table albums;
-- The primary key of albums is 'id'
SELECT * FROM albums;
-- The column name represents names of music artists and bands.
-- The column sales is either number of albums sold in millions or revenue of albums sold in millions

-- Find the name of all albums by Pink Floyd
SELECT artist, name
FROM albums
WHERE artist = 'Pink Floyd';

-- What is the year Sgt. Pepper's Lonely Hearts Club Band was released?
SELECT artist, name, release_date
FROM albums
WHERE artist = 'The Beatles';
-- 1967 is the year

-- What is the genre for the album Nevermind
SELECT artist, name, genre
FROM albums
WHERE name = 'Nevermind';
-- The genre is Grunge, Alternative rock

-- Which albums were released in the 1990s?
SELECT name, release_date
FROM albums
WHERE release_date BETWEEN 1990 AND 1999;
-- The Bodyguard and several more.

-- Which albums had less than 20 million certified sales?
SELECT name, sales
FROM albums
WHERE sales < 20.0;
-- Grease and several others


