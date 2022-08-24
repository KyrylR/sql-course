/*
1. My partner and I want to come by each of the stores in person and meet the managers.
Please send over the managers’ names at each store, with the full address
of each property (street address, district, city, and country please).
*/
SELECT staff.first_name,
       staff.last_name,
       a.address,
       a.district,
       c.city,
       c2.country
FROM staff
         LEFT JOIN store s on staff.staff_id = s.manager_staff_id
         LEFT JOIN address a on s.address_id = a.address_id
         LEFT JOIN city c on a.city_id = c.city_id
         LEFT JOIN country c2 on c.country_id = c2.country_id;


/*
2.	I would like to get a better understanding of all of the inventory that would come along with the business.
Please pull together a list of each inventory item you have stocked, including the store_id number,
the inventory_id, the name of the film, the film’s rating, its rental rate and replacement cost.
*/
SELECT inventory.store_id,
       inventory.inventory_id,
       f.title,
       f.rating,
       f.rental_rate,
       f.replacement_cost
FROM inventory
         LEFT JOIN film f on inventory.film_id = f.film_id;

/*
3.	From the same list of films you just pulled, please roll that data up and provide a summary level overview
of your inventory. We would like to know how many inventory items you have with each rating at each store.
*/
SELECT inventory.store_id,
       f.rating,
       COUNT(inventory.inventory_id) AS count_inventory_items
FROM inventory
         LEFT JOIN film f on inventory.film_id = f.film_id
GROUP BY inventory.store_id,
         rating;


/*
4. Similarly, we want to understand how diversified the inventory is in terms of replacement cost. We want to
see how big of a hit it would be if a certain category of film became unpopular at a certain store.
We would like to see the number of films, as well as the average replacement cost, and total replacement cost,
sliced by store and film category.
*/
SELECT store_id,
       category.name                 AS category,
       COUNT(inventory.inventory_id) AS films,
       AVG(film.replacement_cost)    AS avg_replacement_cost,
       SUM(film.replacement_cost)    AS total_replacement_cost

FROM inventory
         LEFT JOIN film
                   ON inventory.film_id = film.film_id
         LEFT JOIN film_category
                   ON film.film_id = film_category.film_id
         LEFT JOIN category
                   ON category.category_id = film_category.category_id

GROUP BY store_id,
         category.name

ORDER BY SUM(film.replacement_cost) DESC;


/*
5.	We want to make sure you folks have a good handle on who your customers are. Please provide a list
of all customer names, which store they go to, whether or not they are currently active,
and their full addresses – street address, city, and country.
*/
SELECT customer.first_name,
       customer.last_name,
       customer.store_id,
       customer.active,
       a.address,
       c.city,
       c2.country
FROM customer
         INNER JOIN address a on customer.address_id = a.address_id
         INNER JOIN city c on a.city_id = c.city_id
         INNER JOIN country c2 on c.country_id = c2.country_id;


/*
6.	We would like to understand how much your customers are spending with you, and also to know
who your most valuable customers are. Please pull together a list of customer names, their total
lifetime rentals, and the sum of all payments you have collected from them. It would be great to
see this ordered on total lifetime value, with the most valuable customers at the top of the list.
*/
SELECT customer.first_name,
       customer.last_name,
       COUNT(r.rental_id) AS total_lifetime_rentals,
       SUM(p.amount)      AS sum_of_all_payments
FROM customer
         LEFT JOIN rental r on customer.customer_id = r.customer_id
         LEFT JOIN payment p on customer.customer_id = p.customer_id
GROUP BY customer.first_name,
         customer.last_name
ORDER BY SUM(p.amount) DESC;

/*
7. My partner and I would like to get to know your board of advisors and any current investors.
Could you please provide a list of advisor and investor names in one table?
Could you please note whether they are an investor or an advisor, and for the investors,
it would be good to include which company they work with.
*/
SELECT 'advisor' AS type,
       first_name,
       last_name,
       'Self-employment :)'
FROM advisor
UNION
SELECT 'investor' AS type,
       first_name,
       last_name,
       company_name
FROM investor;


/*
8. We're interested in how well you have covered the most-awarded actors.
Of all the actors with three types of awards, for what % of them do we carry a film?
And how about for actors with two types of awards? Same questions.
Finally, how about actors with just one award?
*/
SELECT CASE
           WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
           WHEN actor_award.awards IN ('Emmy, Oscar', 'Emmy, Tony', 'Oscar, Tony') THEN '2 awards'
           ELSE '1 award'
           END                                     AS number_of_awards,
       AVG(IF(actor_award.actor_id IS NULL, 0, 1)) AS pct_w_one_film

FROM actor_award


GROUP BY CASE
             WHEN actor_award.awards = 'Emmy, Oscar, Tony ' THEN '3 awards'
             WHEN actor_award.awards IN ('Emmy, Oscar', 'Emmy, Tony', 'Oscar, Tony') THEN '2 awards'
             ELSE '1 award'
             END




