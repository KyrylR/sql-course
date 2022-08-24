-- Order by examples
SELECT customer_id,
       rental_id,
       amount,
       payment_date
FROM payment
ORDER BY amount DESC ;

-- Assignment
SELECT
    title,
    length,
    rental_rate
FROM film
ORDER BY length DESC;
