# STRINGS
--
select * from city;
select city, LPAD(city, 8, '*')
from sakila.city
limit 10;

select city, RPAD(city, 15, '*')
from sakila.city
limit 10;

select city, LPAD(RPAD(city, 15, '*'), 20, '@')
from sakila.city
limit 15;

#SubStrings
select city, SUBSTRING(city, 3,9) as subcity 
from city;
#Concatination
select * from sakila.actor;
select *, CONCAT(first_name, '.', last_name) as full_name
FROM sakila.actor;

#Length
select * FROM sakila.category;
SELECT *, LENGTH(name) as length_of_name
from sakila.category
where length(name)>=6;

select email, SUBSTRING(email, LOCATE('@', email)+1) as sub_string
from sakila.customer;

select email, substring_index(email,'@',+1) from sakila.customer;

select email, substring_index(SUBSTRING(email, LOCATE('@', email)+1), '.',+1) as sub_email
from sakila.customer;

select * from customer;
select first_name, upper(first_name), lower(first_name) 
from sakila.customer
where first_name like '%as%' or 'a%';

select left(title, 2) as first_name, right(title,3) as last_name
from film;
select left(title, 2) as first_name, right(title,3) as last_name, count(*) as film_count
from sakila.film
group by left(title, 2), right(title,3);

select title, 
case
when left(title,1) between 'A' and 'L' then 'Group A' 
when left(title,1) between 'm' and 'z' then 'Group B'
else 'Other'
END as title_group
from sakila.film;

select title, replace(title, 'A', 'zz') as new_title
from sakila.film
where title like 'AL%';

select title
from sakila.film
where title not regexp '^a';
select title
 from sakila.film
 where title regexp '(ea)$';
 
 select title
 from sakila.film
 where title not regexp '[aeiou]{2}';
 
 select title, rental_rate, rental_rate ^2 as double_rental
 from sakila.film; -- MySQL automatically converts the types to make operations to work
 -- rental_rate is decimal and 2 is integer and both are numeric
 
select amount, CAST(amount as signed) as amount_str
from sakila.payment; -- cast is used to convert the data types from one to other

-- rand() used to generate a random number between 0 and 1
select rand() as random_number;
 
select * from payment;

select amount, ceil(amount), floor(amount), round(amount)
from sakila.payment;
-- ceil is used to round to upper limit and floor is used to round off to lower limit

select amount, round(amount,1)
from sakila.payment;
-- round is used to round the numbers to the nearest integer or to a specified number of decimal places

select amount, TRUNCATE(amount,1)
from sakila.payment;
-- Truncate is just used to cut off the decimals 

select amount, ceil(amount), floor(amount), 
round(amount), truncate(amount,1)
from sakila.payment;

select payment_id, (rand() * 100), floor(rand() * 100)
from sakila.payment
limit 5; -- this generates random number between 1 to 100 and this can be decimal and 
-- integer from 1 to 100

select * from sakila.rental;
select rental_id, rental_date, return_date, 
DATEDIFF(return_date,rental_date) as rental_duration 
from sakila.rental
where return_date is not null;

select rental_date, dayofyear(rental_date), month(rental_date)
from sakila.rental
order by month(rental_date) desc;

select month(rental_date), count(*) 
from sakila.rental
group by month(rental_date)
order by month(rental_date) desc;

