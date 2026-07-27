#SUB-QUERIES: Query inside another query
-- Inner query(Nested query) runs first and give results to outer query
-- Used to break complex problems into steps
-- SubQueries with WHERE
-- finding customers who rented films

-- Use subqueries when:
-- You need temporary results to build your main query
-- You are comparing against aggregate values

#Subqueries using WHERE clause
select customer_id, first_name
from sakila.customer
where customer_id in(
select customer_id from sakila.rental);
select * from film;
select * from film_category;
select * from category;

-- Find films in 'Action' category
select film_id, title 
from sakila.film
where film_id in(
select film_id from sakila.film_category 
where category_id in(
select category_id from sakila.category
where name='Action')
);

# Subqueries using Select Clause
-- Adds calculated column,runs for EACH row,returns single value,creates derived column and Can be slow with many rows
select * from sakila.customer;
-- getting customers with their rental rate
select customer_id, first_name,
(select count(rental_id) 
from sakila.rental as r
where r.customer_id=c.customer_id
) as total_rentals
from sakila.customer as c;

-- customers with avg payment
select customer_id, first_name,
(select avg(amount) from sakila.payment as p
where p.customer_id=c.customer_id)
from sakila.customer as c;

#DERIVED TABLES(Subquery in From): Creates temporary table from subquery
-- Subquery runs FIRST, result becomes a table and can join with other tables
-- Must have alias, like a temporary view

-- customer spending summary
select customer_id, total_spent
from ( select customer_id, sum(amount) as total_spent
		from sakila.payment 
        group by customer_id) as customer_totals
where total_spent >100;

select * from customer;
select * from payment;
select customer_id, total_spent
from (select customer_id, sum(amount) as total_spent
		from sakila.payment as p
        group by customer_id
        order by total_spent desc
        limit 25
) as cp;

select * from sakila.customer;
select * from(
select first_name, case 
					when left(first_name,1) between 'A' and 'M' then 'Group 1'
                    when left(first_name,1) between 'O' and 'Z' then 'Group 2'
                    else 'Others'
                    end as group_lable
from sakila.customer) as Grouped_customers
where group_lable='Group 2'
limit 25;


#co related subqueries 
-- References outer query, runs for EACH outer row, Compares values between tables
-- More complex but powerful, Can be slower, Uses aliases and correlation

SELECT payment_id, customer_id, amount, payment_date
FROM sakila.payment p1
WHERE amount > (
    SELECT AVG(amount)
    FROM sakila.payment p2
    WHERE p2.customer_id = p1.customer_id
);

SELECT 
    c.customer_id,
    c.first_name,
    (SELECT SUM(amount) FROM sakila.payment p
     WHERE p.customer_id = c.customer_id) as total_spent
FROM sakila.customer c
WHERE (
    SELECT SUM(amount) FROM sakila.payment p
    WHERE p.customer_id = c.customer_id
) > (
    SELECT AVG(total) FROM (
        SELECT SUM(amount) as total
        FROM sakila.payment
        GROUP BY customer_id
    ) avg_table
);
