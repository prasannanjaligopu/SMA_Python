# 1. Get all customers whose first name starts with 'J' and who are active.
select * from sakila.customer
where first_name like 'J%' and active='1';

#2.Find all films where the title contains word 'ACTION' or the description contains 'WAR'.
select * from sakila.film 
where title like '%ACTION%' or description like '%WAR%';

#3. List all customers whose last name is not 'SMITH' and whose first name ends with 'a'.
select * from sakila.customer
where last_name not like 'SMITH' and first_name like '%a';

#4. Get all films where the rental rate is greater than 3.0 and 
#the replacement cost is not null.
select * from sakila.film
where rental_rate > 3.0 and replacement_cost is not null;

#5. Count how many customers exist in each store who have active status = 1.
select * from sakila.customer;
select store_id, count(*) 
from sakila.customer
group by store_id, active
having active='1';

#6. Show distinct film ratings available in the film table.
select * from sakila.film;
select distinct(rating) 
from sakila.film;

#7. Find the number of films for each rental duration where 
#the average length is more than 100 minutes.
select rental_duration, count(*)
from sakila.film
group by rental_duration
having avg(length) > 100;

#8. List payment dates and total amount paid per date, 
#but only include days where more than 100 payments were made.
select * from sakila.payment;
select date(payment_date), count(*), sum(amount)
from sakila.payment
group by payment_date
having count(*) > 100;

# 9. Find customers whose email address is null or ends with '.org'.
select * from sakila.customer 
where email is null or email like '%.org';

#10. List all films with rating 'PG' or 'G', and order them by 
#rental rate in descending order.
select title, rental_rate, rating
from sakila.film
where rating='PG' or rating='G'
order by rental_rate desc;

#11. Count how many films exist for each length where the film title starts 
#with 'T' and the count is more than 5.
select * from sakila.film;
select length, count(*)
from sakila.film
where title like 'T%'
group by length
having count(*) > 5;

#12. List all actors who have appeared in more than 10 films.
select a.actor_id, a.first_name, a.last_name,
(select COUNT(film_id) 
from film_actor fa 
where fa.actor_id = a.actor_id) as number_of_films
from actor a
where a.actor_id in (
select actor_id 
from film_actor 
group by actor_id 
having COUNT(film_id) > 10)
order by number_of_films desc;

#13. Find the top 5 films with the highest rental rates and longest lengths combined, 
#ordering by rental rate first and length second.
select * from sakila.film;
select title, rental_rate, length
from sakila.film
order by rental_rate desc, length desc
limit 5;

#14. Show all customers along with the total number of rentals they have made, 
#ordered from most to least rentals.
select c.first_name, c.last_name, 
(select count(rental_id) from sakila.rental as r
where r.customer_id=c.customer_id) as no_of_rentals
from sakila.customer as c
order by no_of_rentals desc;

#15. List the film titles that have never been rented.
select * from sakila.film;
select * from sakila.rental;
select * from sakila.inventory;
select f.film_id, f.title
from sakila.film as f
where f.film_id not in (
select distinct i.film_id
from sakila.inventory i
where i.inventory_id in (
        select r.inventory_id
        from sakila.rental r
    )
)
order by f.title;