-- CASE statements examples
-- Assignment +
SELECT first_name,
       last_name,
       CASE
           WHEN active = 1 THEN 'active store'
           WHEN active = 0 THEN 'inactive store'
           ELSE 'error'
           END AS label
FROM customer;

-- CASE && `Pivots`
SELECT
    film_id,
    COUNT(CASE WHEN store_id=1 THEN inventory_id END) AS store_1_copies,
    COUNT(CASE WHEN store_id=2 THEN inventory_id END) AS store_2_copies,
    COUNT(inventory_id) AS total_copies
FROM inventory
GROUP BY
    film_id
ORDER BY
    film_id;

-- Assignment +
SELECT
    store_id,
    COUNT(CASE WHEN active = 1 THEN customer_id END ) as active,
    COUNT(CASE WHEN active = 0 THEN customer_id END ) as inactive
FROM customer
GROUP BY store_id;
