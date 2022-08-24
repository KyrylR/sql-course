-- Group By example
SELECT
    rating,
    COUNT(film_id) AS films_with_rating
FROM film
GROUP BY
    rating;

/* Nice! */
