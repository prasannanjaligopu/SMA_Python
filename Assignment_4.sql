#1. List all customers along with the films they have rented.
use sakila;
select * from customer;
select * from film;
select * from rental;
select * from inventory;

select c.customer_id, c.first_name, c.last_name, f.title as film_title
from customer as c
left join rental as r on c.customer_id = r.customer_id
left join inventory i on r.inventory_id = i.inventory_id
left join film f on i.film_id = f.film_id;

#2. List all customers and show their rental count, including those who haven't rented any films.
select c.customer_id, c.first_name, count(rental_id) as rental_count
from customer as c
left join rental as r on r.customer_id=c.customer_id
group by c.customer_id;

#3. Show all films along with their category. Include films that don't have a category assigned.-]
select * from film_category;
select f.film_id, f.title, c.name as category_name
from film as f
left join film_category as fc on fc.film_id=f.film_id
left join category as c on c.category_id= fc.category_id;

#4. Show all customers and staff emails from both customer and 
#staff tables using a full outer join (simulate using LEFT + RIGHT + UNION).
select * from customer;
select * from staff;
select c.first_name, c.last_name, c.email as customer_email, s.email as staff_email
from customer c
left join staff s on c.email = s.email
union
select c.first_name, c.last_name, c.email as customer_email, s.email as staff_email
from customer c
right join staff s on c.email = s.email;

#5. Find all actors who acted in the film "ACADEMY DINOSAUR".
select * from actor;
select * from film;
select a.first_name from actor as a
left join film_actor as fa on fa.actor_id=a.actor_id
left join film as f on f.film_id= fa.film_id
where f.title= 'ACADEMY DINOSAUR';

#6. List all stores and the total number of staff members working in each store, even if a store has no staff.
select * from store;
select * from staff;
select st.store_id, count(staff_id)from store as st
left join staff as sf on sf.store_id= st.store_id
group by st.store_id;

#7. List the customers who have rented films more than 5 times. Include their name and total rental count.
select * from customer;
select * from rental;
select c.first_name, count(r.rental_id) from customer as c
left join rental as r on c.customer_id=r.customer_id
group by c.customer_id
having count(rental_id) >5;

