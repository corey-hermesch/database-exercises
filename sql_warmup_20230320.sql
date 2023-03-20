/* 
-- In the sakila database,
-- use the actor, film_actor, and film table
-- find all movies that 'Zero Cage' has been in
-- and make a new column that says if the movie
-- is rate R or not
*/

use sakila;
show tables;
select * from film;

SELECT title, rating
, if(rating = 'R', 'yes', 'no') as is_R_rated
FROM actor
JOIN film_actor USING (actor_id)
JOIN film USING (film_id)
WHERE first_name = 'Zero' AND last_name = 'Cage'
;

CREATE TEMPORARY TABLE pagel_2179.cage_movies AS
SELECT title, rating
FROM actor
JOIN film_actor USING (actor_id)
JOIN film USING (film_id)
WHERE first_name = 'Zero' AND last_name = 'Cage'
;

use pagel_2179;
ALTER TABLE cage_movies ADD is_R_rated VARCHAR(3)
;
SELECT * from cage_movies
;
UPDATE cage_movies
SET is_R_rated = 'YES'
WHERE cage_movies.rating = 'R'
;
UPDATE cage_movies
SET is_R_rated = 'NO'
WHERE cage_movies.rating != 'R'
;