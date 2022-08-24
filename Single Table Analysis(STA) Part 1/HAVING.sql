-- Having examples.
SELECT
    customer_id,
    COUNT(*) AS total_rental
FROM rental
GROUP BY
    customer_id
HAVING COUNT(*) >= 30;

-- Assignment +
SELECT
    customer_id,
    COUNT(rental_id) AS total_rental
FROM rental
GROUP BY
    customer_id
HAVING COUNT(rental_id) < 15;
