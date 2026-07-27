SELECT * FROM sakila.actor; -- get all the data from table actor

-- get the unique first name from actor table
SELECT DISTINCT first_name FROM sakila.actor; 

-- counting the unique first names
SELECT COUNT(DISTINCT first_name) FROM sakila.actor;

-- getting the film title with NULL language
SELECT title FROM sakila.film WHERE original_language_id is NULL;

-- extracting the wnique film titles with NULL language
SELECT DISTINCT(title) FROM sakila.film WHERE original_language_id is NULL;

-- counting the unique film titles with NULL language
SELECT COUNT(DISTINCT(title)) FROM sakila.film WHERE original_language_id is NULL;

-- Finding the first names appearing more than once
SELECT first_name from sakila.actor
group by first_name
having count(first_name) > 1;

-- Extracting the first 100 first and last names from the table
SELECT first_name, last_name FROM sakila.actor
LIMIT 100;
-- Payments by staff 2 AND amount >= $1.99
SELECT * FROM sakila.payment
WHERE staff_id= 2 and amount >= 1.99;
-- Payments by staff 2 OR amount >= $1.99
SELECT * FROM sakila.payment
WHERE staff_id= 2 or amount >= 1.99;
-- All cities sorted by country in descending order
SELECT * FROM sakila.city order by country_id desc;
-- excluding city 300 and sorted alphabetically
SELECT * FROM sakila.address
WHERE city_id NOT in(300)
order by address asc;
-- LIKE operator: finding the film title with 3rd character 'a'
SELECT * FROM film
WHERE title like '__a%';

-- finding rentals from customers > 130 and sorting in  ascending order
SELECT * FROM sakila.rental
where customer_id>130
ORDER BY customer_id asc;

-- Finding the top 50 customers who took the rentals more that 30 times
SELECT customer_id, COUNT(rental_id) as count_rentals
FROM sakila.rental
GROUP BY customer_id
HAVING count(rental_id) > 30
ORDER BY customer_id DESC
limit 50;
-- oredr of execution: FROM(table) -> join -> group by -> having ->select -> order by -> limit

