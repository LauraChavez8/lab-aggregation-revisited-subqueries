USE sakila;

-- 
SELECT DISTINCT c.first_name, c.last_name, c.email FROM customer c
JOIN rental r ON c.customer_id = r.customer_id;

--
SELECT DISTINCT c.customer_id, CONCAT(c.first_name," ", c.last_name), AVG(p.amount) FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

--
SELECT DISTINCT c.first_name, c.last_name, c.email FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film_category f ON i.film_id = f.film_id
JOIN category t ON t.category_id = f.category_id
WHERE t.name = 'Action';

SELECT DISTINCT first_name, last_name, email FROM customer
WHERE customer_id IN ( 
	SELECT customer_id FROM rental
	WHERE inventory_id IN (
		SELECT inventory_id FROM inventory
		WHERE film_id IN (
			SELECT film_id FROM film_category
			WHERE category_id IN (1)
    )));
    
--
SELECT p.customer_id, c.first_name, c.last_name, p.amount, 
CASE
	WHEN p.amount < 2 THEN 'Low'
	WHEN p.amount < 4 THEN 'Medium'
	ELSE 'High'
END AS 'Classification'
FROM payment p
JOIN customer c ON p.customer_id = c.customer_id;