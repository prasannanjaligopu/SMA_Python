# SQL FINE TUNING TECHNIQUES
-- 1. Use only necessary columns (Avoid SELECT *)
select first_name, last_name from customer;

-- 2. Use WHERE before GROUP BY and HAVING
-- It filters data before grouping which is more efficient way
SELECT store_id, COUNT(*) AS total_customers
FROM sakila.customer
WHERE active = 1
GROUP BY store_id
HAVING COUNT(*) > 200;

-- Using joins instead of queries
-- When we create a Query inside another query, inner query runs first and returns the results to outer query
-- It follows the sequential execution
SELECT first_name, last_name
FROM sakila.customer
WHERE customer_id IN (
    SELECT customer_id FROM sakila.rental
);
-- Combines tables directly, which is parallel processing and more efficient
SELECT DISTINCT c.first_name, c.last_name
FROM sakila.customer c
JOIN sakila.rental r ON c.customer_id = r.customer_id; 

-- 4. Avoid functions on indexed columns: Goal is to make indexex work effectively
-- When we use function on indexed column:
-- Index CANNOT be used, Database ignores the index,Full table scan happens and Performance drops dramatically
explain SELECT * FROM sakila.rental WHERE YEAR(rental_date) = 2005;
-- When we avoid function on indexed column:
-- Index CAN be used, Fast lookup happens, Only matching rows checked and Query runs much faster
explain SELECT * FROM sakila.rental WHERE rental_date BETWEEN '2005-01-01' AND '2005-12-31';

-- 5. Use LIMIT effectively
SELECT *  
FROM sakila.film
ORDER BY film_id
LIMIT 100;

-- 6. Use CTE for readable query breakdown
with payment_count as(
select customer_id, count(*) as total_payments
from sakila.payment 
group by customer_id)
select customer_id, total_payments 
from payment_count as pc
where total_payments > 5;

-- 7. Use EXPLAIN to understand query execution plan
EXPLAIN SELECT * FROM sakila.customer WHERE store_id = 1;

-- 8. Maintenance commands (run periodically)
ANALYZE TABLE sakila.customer;
OPTIMIZE TABLE sakila.customer;

-- 9. Avoid large OFFSETs in pagination
-- Inefficient:
SELECT * FROM sakila.payment LIMIT 1000, 10;
-- Efficient:
SELECT * FROM sakila.payment WHERE payment_id > 1000 LIMIT 10;

