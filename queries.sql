--3. Inside sakila db modify 2 film records values
UPDATE film
SET 
film.title = 'The Lord of the Rings: The Fellowship of the Ring', 
film.description= 'A meek Hobbit from the Shire and eight companions set out on a journey to destroy the powerful One Ring and save Middle-earth from the Dark Lord Sauron.',
film.release_year= 2001,
film.rental_rate = 5.99,
film.`length`= 178,
film.rating= 'PG-13'
WHERE film.film_id=1;

UPDATE film
SET 
film.title = 'The Lord of the Rings: The Two Towers', 
film.description= "While Frodo and Sam edge closer to Mordor with the help of the shifty Gollum, the divided fellowship makes a stand against Sauron's new ally, Saruman, and his hordes of Isengard.",
film.release_year= 2002,
film.rental_rate = 7.99,
film.`length`= 179,
film.rating= 'PG-13'
WHERE film.film_id=2;

--4. List Movies by actor
SELECT 
actor.actor_id,
actor.first_name,
actor.last_name,
film.film_id,
film.title
FROM
actor
JOIN
film_actor
ON
film_actor.actor_id = actor.actor_id
JOIN
film
ON
film.film_id = film_actor.film_id

--5. Movies per actor
SELECT
actor.actor_id,
actor.first_name,
actor.last_name,
COUNT(DISTINCT film_actor.film_id) 
AS 
"Films per actor"
FROM
film_actor
JOIN
actor
ON
film_actor.actor_id = actor.actor_id
GROUP BY
film_actor.actor_id

--6. Movie Languages
SELECT
COUNT(DISTINCT `language`.language_id) 
AS 
"Movie languages"
FROM
`language`

--7. Average cost for replacementof a film
SELECT AVG(film.replacement_cost)
AS
"Average replacement cost"
FROM film
--8. Stored procedure
DELIMITER //

CREATE PROCEDURE update_film_data(
IN filmTitle NVARCHAR(30),
IN filmDescription NVARCHAR(100),
IN releaseYear INT(5),
IN filmId INT(5)
)
BEGIN
UPDATE film
SET 
film.title = filmTitle, 
film.description= filmDescription, 
film.release_year= releaseYear
WHERE film.film_id= filmId;
END //
DELIMITER ;
