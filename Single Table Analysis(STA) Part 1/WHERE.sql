-- Where examples
SELECT customer_id,
       rental_id,
       amount,
       payment_date
FROM payment
WHERE payment_date >= '2006-02-14';

-- Assignment +
SELECT customer_id,
       rental_id,
       amount,
       payment_date
FROM payment
WHERE customer_id BETWEEN 1 AND 100;

-- Where && and
SELECT customer_id,
       rental_id,
       amount,
       payment_date
FROM payment
WHERE amount = 0.99
  AND payment_date > '2005-07-12';

-- Assignment +/-
SELECT customer_id,
       rental_id,
       amount,
       payment_date
FROM payment
WHERE payment_date > '2006-01-00'
  AND amount > 5
  AND customer_id BETWEEN 1 AND 100;

-- Where && or
SELECT customer_id,
       rental_id,
       amount,
       payment_date
FROM payment
WHERE customer_id = 5
  OR customer_id = 11;

-- Assignment +
SELECT customer_id,
       rental_id,
       amount,
       payment_date
FROM payment
WHERE amount > 5
   OR customer_id = 42
   OR customer_id = 53
   OR customer_id = 60
   OR customer_id = 75;

-- Where && in
SELECT customer_id,
       rental_id,
       amount,
       payment_date
FROM payment
WHERE amount > 5
   OR customer_id IN (42,53,60,75);

-- Where && like
SELECT customer_id,
       rental_id,
       amount,
       payment_date
FROM payment
WHERE amount > 5
   OR customer_id IN (42,53,60,75);

-- Assignment +
SELECT
    title,
    special_features
FROM film
WHERE special_features LIKE '%Behind the Scenes%'
