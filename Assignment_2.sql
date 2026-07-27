#1. Identify if there are duplicates in Customer table. 
#Don't use customer id to check the duplicates
select store_id, first_name, last_name, email, count(*)
from sakila.customer
group by store_id, first_name, last_name, email
having count(*) >1;

#2. Number of times letter 'a' is repeated in film descriptions
select description, length(description)-length(replace(description,'a',''))
from sakila.film;

#3. Number of times each vowel is repeated in film descriptions
select description, 
length(description)-length(replace(description, 'a','')) as no_of_a,
length(description)-length(replace(description, 'e','')) as no_of_e,
length(description)-length(replace(description, 'i','')) as no_of_i,
length(description)-length(replace(description, 'o','')) as no_of_o,
length(description)-length(replace(description, 'u','')) as no_of_u
from sakila.film;

#4. Display the payments made by each customer
#        1. Month wise
#        2. Year wise
#        3. Week wise
select * from payment;
select customer_id ,year(payment_date),sum(amount) from payment
group by customer_id ,year(payment_date)
order by customer_id,year(payment_date);

select customer_id ,month(payment_date),sum(amount) from payment
group by customer_id ,month(payment_date)
order by customer_id,month(payment_date);

select customer_id ,week(payment_date),sum(amount) from payment
group by customer_id ,week(payment_date)
order by customer_id,week(payment_date);

select customer_id ,year(payment_date),month(payment_date),week(payment_date) from payment
group by customer_id,year(payment_date),month(payment_date),week(payment_date);

#5. Check if any given year is a leap year or not. 
#You need not consider any table from sakila database. 
#Write within the select query with hardcoded date
select
    year('2024-01-01') as year,
    case 
        when(year('2024-01-01') % 4 = 0 and year('2024-01-01') % 100 != 0)
             or (year('2024-01-01') % 400 = 0)
        then 'Leap Year'
        else 'Not a Leap Year'
    end as leap_year_check;
    
#6. Display number of days remaining in the current year from today.
select 
curdate() as today_date,
concat(year(curdate()),'-12-31') as last_date_of_year,
datediff(concat(year(curdate()),'-12-31'), curdate()) as days_remaining;

#7. Display quarter number(Q1,Q2,Q3,Q4) for the payment dates from payment table.
select payment_date,quarter(payment_date) from payment;

