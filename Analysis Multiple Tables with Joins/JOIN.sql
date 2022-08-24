-- Inner Join examples

SELECT DISTINCT inventory.inventory_id
FROM inventory
         INNER JOIN rental r
                    ON inventory.inventory_id = r.inventory_id;

-- Assignment +
SELECT DISTINCT i.inventory_id,
                i.store_id,
                film.title,
                film.description
FROM film
         INNER JOIN inventory i on film.film_id = i.film_id;


-- Left Join
SELECT DISTINCT inventory.inventory_id,
                rental.inventory_id
FROM inventory
         LEFT JOIN rental
                   ON inventory.inventory_id = rental.inventory_id;

-- Assignment +
SELECT DISTINCT film.title,
                COUNT(fa.actor_id) AS number_of_actors
FROM film
         LEFT JOIN film_actor fa ON film.film_id = fa.film_id
GROUP BY film.title
ORDER BY COUNT(fa.actor_id);


-- Bridge
SELECT film.film_id,
       film.title,
       c.name
FROM film
         INNER JOIN film_category fc on film.film_id = fc.film_id
         INNER JOIN category c on fc.category_id = c.category_id;

-- Assignment +
SELECT actor.first_name,
       actor.last_name,
       f.title
FROM actor
         INNER JOIN film_actor fa on actor.actor_id = fa.actor_id
         INNER JOIN film f on fa.film_id = f.film_id;

-- Assignment +
SELECT DISTINCT film.title,
                film.description
FROM film
         INNER JOIN inventory i
                    ON film.film_id = i.film_id
                        AND i.store_id = 2


