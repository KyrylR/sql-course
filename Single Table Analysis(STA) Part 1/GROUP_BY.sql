-- Group By example
SELECT
    rating,
    COUNT(film_id) AS films_with_rating
FROM film
GROUP BY
    rating;

/* Nice! */

-- Assignment +
SELECT
    rental_duration,
    COUNT(title) AS films_with_this_rental_duration
FROM film
GROUP BY
    rental_duration;

-- Multiple Group By
SELECT
    rental_duration,
    rating,
    COUNT(film_id) as count_of_films
FROM film
GROUP BY
    rental_duration,
    rating;

-- Aggregate functions
SELECT
    rating,
    COUNT(film_id) AS count_of_films,
    MIN(length) AS shortest_film,
    MAX(length) AS longest_film,
    AVG(length) AS avarage_length_of_film,
    SUM(length) AS total
FROM film
GROUP BY rating;

-- Assignment +
SELECT
    replacement_cost,
    COUNT(film_id) AS count_of_films,
    MIN(rental_rate) AS cheapest_rental,
    MAX(rental_rate) AS most_expansive_rental,
    AVG(rental_rate) AS avarage_rental
FROM film
GROUP BY
    replacement_cost;
