-- Select all records from table.
SELECT *
FROM rental;

-- Select from specific columns.
SELECT
	customer_id,
	rental_date
FROM rental;

-- Assignment +
SELECT
	first_name,
    last_name,
    email
FROM customer;

-- Select dictinct
SELECT DISTINCT
	rating
FROM film;

-- Assignment +
SELECT DISTINCT
	rental_duration
FROM film;



