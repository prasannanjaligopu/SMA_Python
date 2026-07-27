#1. display all customer details who have made more than 5 payments.

select * from customer as c
where customer_id in (
select customer_id from sakila.payment as p
group by customer_id
having count(customer_id) > 5);

#2. Find the names of actors who have acted in more than 10 films.
select actor_id, first_name from sakila.actor
where actor_id in (
	select actor_id from sakila.film_actor as fa
    group by actor_id
    having count(film_id) > 10);
    
#3. Find the names of customers who never made a payment.
select * from customer;
select * from payment;
select customer_id, first_name from sakila.customer
where customer_id not in( select customer_id from sakila.payment);

#4. List all films whose rental rate is higher than the average rental rate of all films.
select * from rental;
select * from film;
select title from sakila.film
where rental_rate > (select avg(rental_rate) from sakila.film);

#5. List the titles of films that were never rented.

select title from film as f
where not exists (
    select 1 from inventory i
    where i.film_id = f.film_id and 
    exists(select 1 from rental r
	where r.inventory_id = i.inventory_id
      )
);


#6. Display the customers who rented films in the same month as customer with ID 5.

#select month(rental_date) as rental_month from sakila.rental
#where customer_id=5
#group by rental_month;
select customer_id, first_name from sakila.customer
where customer_id in (select customer_id from sakila.rental
						where month(rental_date) in(select month(rental_date) as rental_month from sakila.rental
													where customer_id=5
													group by rental_month)
						);

#7. Find all staff members who handled a payment greater than the average payment amount.
select * from staff;
select * from payment;

select * from staff
where staff_id in (select staff_id from payment
where amount> (select avg(amount) from payment));

#8. Show the title and rental duration of films whose rental duration is greater than the average.

select title, rental_duration from sakila.film
where rental_duration > (select avg(rental_duration) from sakila.film);

#9. Find all customers who have the same address as customer with ID 1.

select c.customer_id, c.first_name 
from sakila.customer as c
where c.address_id=(select address_id from customer
					where customer_id=1);

#10. List all payments that are greater than the average of all payments.

select payment_id, amount 
from sakila.payment
where amount > (select avg(amount) from sakila.payment);
