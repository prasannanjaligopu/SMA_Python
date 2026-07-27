#JOINS
/* Cardinality: Relationship between the tables
It says how the tables are related to each other
It can be of 4 types: 1 to 1, 1 to many, many to 1, many to many */
select * from category;
select * from film;
select * from film_category;
# 1 to 1: Single row in one table that should exactly related to one row in other table
select * from city;
select * from address;
select * from store;
select c.city_id, c.city, a. address_id, a. address
from store as s
inner join address as a on a.address_id=s.address_id
inner join city as c on c.city_id=a.city_id;

# 1 to many: It means ONE record in a table is related to MANY records in another table.
select * from payment;
select * from customer;
-- single customer can make multiple payments 
select c.customer_id, c.first_name, c.last_name, p.payment_id, p.amount
from sakila.customer as c
inner join sakila.payment as p on
c.customer_id=p.customer_id;

# many to 1: 
select c.customer_id, c.first_name, c.last_name, p.payment_id, p.amount
from sakila.payment as p
inner join sakila.customer as c on 
c.customer_id=p.customer_id;

# many to many: means MANY records in one table are related to MANY records in another table.
# It requires a bridge table which connects the two tables
select a.actor_id, a.first_name, f.film_id, f.title
from sakila.actor as a
inner join sakila.film_actor as fa on fa.actor_id=a.actor_id
inner join sakila.film as f on f.film_id=fa.film_id
order by f.film_id,a.actor_id
limit 50;
-----------------------

select f.film_id, f.title, c.name, c.category_id
from sakila.film as f
join sakila.film_category as fc
on fc.film_id=f.film_id
join sakila.category as c
on c.category_id=fc.category_id;

select * from customer;
select * from payment;
-- Inner join: Only returns matching rows from both tables
select c.customer_id, c.first_name, p.payment_id, p.rental_id 
from sakila.customer as c
inner join sakila.payment as p on
c.customer_id=p.customer_id
limit 15;


-- LEFTJOIN: Returns ALL rows from the left table and matching rows from the right table
-- ir returns with NULL values where there's no match
select c.customer_id, c.first_name, p.payment_id, p.rental_id 
from sakila.customer as c
left join sakila.payment as p on
c.customer_id=p.customer_id
limit 15;
-- it should return the customers with no payments
select c.customer_id, c.first_name, p.payment_id, p.rental_id 
from sakila.customer as c
left join sakila.payment as p on
c.customer_id=p.customer_id
where p.customer_id is NULL
limit 15;

-- RIGHTJOIN: Returns ALL the rows from the right table and matching rows from the left table
-- it returns with NULL values where ther's no match
select c.customer_id, c.first_name, p.payment_id, p.rental_id 
from sakila.customer as c
right join sakila.payment as p on
c.customer_id=p.customer_id;
-- it should return payments with no matching with the customer
select c.customer_id, c.first_name, p.payment_id, p.rental_id 
from sakila.customer as c
right join sakila.payment as p on
c.customer_id=p.customer_id
where c.customer_id is NULL;


-- FULL OUTER JOIN: It should return all customers (with or without payments),
-- All payments (with or without customers)  
select c.customer_id, c.first_name, p.payment_id, p.rental_id 
from sakila.customer as c
left join sakila.payment as p on
c.customer_id=p.customer_id
UNION
select c.customer_id, c.first_name, p.payment_id, p.rental_id 
from sakila.customer as c
right join sakila.payment as p on
c.customer_id=p.customer_id;
-- It should return all customers (with or without payments),
-- All payments (with or without customers) with no duplicates 
select c.customer_id, c.first_name, p.payment_id, p.rental_id 
from sakila.customer as c
left join sakila.payment as p on
c.customer_id=p.customer_id
UNION
select c.customer_id, c.first_name, p.payment_id, p.rental_id 
from sakila.customer as c
right join sakila.payment as p on
c.customer_id=p.customer_id
where c.customer_id is null or p.customer_id is null;

# CROSS JOIN: A CROSS JOIN produces a Cartesian product - it combines every row 
#from the first table with every row from the second table.

SELECT s.store_id, st.staff_id, st.first_name, st.last_name
FROM sakila.store AS s
CROSS JOIN sakila.staff AS st
ORDER BY s.store_id, st.staff_id;
# Always limit the rsults as it can create massive result sets
#that consume memory and slow down queries when it has large data

#SELF JOIN: A SELF JOIN is when a table is joined to ITSELF to compare or 
#find relationships between records within the same table.
select * from film;
select f1.film_id, f2.film_id, f1.title, f2.title,
f1.rental_rate, f1.length, f2.length 
from sakila.film as f1
inner join sakila.film as f2 on
f1.rental_rate=f2.rental_rate
where f1.film_id < f2.film_id
order by f1.rental_rate desc, f1.film_id
limit 30;