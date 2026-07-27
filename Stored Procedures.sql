# CTE(Common Table Expression): is a temporary named result set that you can use within a 
#SELECT, INSERT, UPDATE, or DELETE statement
#It makes complex queries more redable and reusable

with payment_count as(
select customer_id, count(*) as total_payments
from sakila.payment 
group by customer_id)
select customer_id, total_payments 
from payment_count as pc
where total_payments > 5;

-- Finding the customer who spent more than $100 and their spending details
with customer_payment as(
select
p.customer_id,
sum(amount) as total_amount,
count(payment_id) as payment_count,
avg(amount) as avg_payment,
min(amount) as min_payment,
max(amount) as max_payment
from sakila.payment as p
group by p.customer_id
)
select 
c.customer_id,
c.first_name,
c.last_name,
cp.total_amount,
cp.payment_count,
cp.avg_payment,
cp.min_payment,
cp.max_payment
from sakila.customer as c
inner join customer_payment as cp on c.customer_id=cp.customer_id
where cp.total_amount > 100
order by cp.total_amount desc
limit 20;

#RECURSIVE CTE has TWO parts:
#1.ANCHOR MEMBER:(Initial query)
-- Initial query that starts the recursion and executes once
#2.RECURSIVE MEMBER(Loop query):
-- References the CTE itself and executes repeatedly until the condition fails
-- Each iteration builds on previous, which adds new rows based on previous rows
-- numbers from 1 to 10
with RECURSIVE num_seq as (
select 1 as num
union all
select num+1
from num_seq
where num<10 )
select num from num_seq;
-- counting numbers from 10 to 15
with RECURSIVE count_num as (
select 10 as num
union all
select num+1
from count_num
where num<15 )
select num from count_num;

#TEMPORARY TABLES:The table that exists only for the duration of a session
-- or present until we drop the tables
-- It is not created in the database 
-- It's automatically deleted when the session ends.
-- Storing the intermediate results or 
-- testing transformations without affecting the actual data
-- Creating a temporary table with top customers who rented more than 20 times 
-- and spent more than $100
CREATE TEMPORARY TABLE temp_top_customers (
    customer_id INT,
    first_name VARCHAR(45),
    last_name VARCHAR(45),
    total_rentals INT,
    total_spent DECIMAL(10, 2),
    avg_rental_price DECIMAL(10, 2)
);
-- INSERTING VALUES TO TEMP TABLE
INSERT INTO temp_top_customers
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COUNT(r.rental_id) as total_rentals,
    SUM(p.amount) as total_spent,
    ROUND(AVG(p.amount), 2) as avg_rental_price
FROM sakila.customer AS c
INNER JOIN sakila.rental AS r ON c.customer_id = r.customer_id
INNER JOIN sakila.payment AS p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(r.rental_id) > 20 AND SUM(p.amount) > 100
ORDER BY total_spent DESC;
SELECT * FROM temp_top_customers;
-- still scope is the limitation with Temp tables as it is only for that particular query
-- It cannot use outside of this query
#VIEWS: A View is a saved SELECT query that looks and acts like a table, 
-- but doesn't store actual data.
-- It normally saves the query, when we call that query then it will run that query and 
-- then it gets data in that particular query
/* Uses of Views:
1. Simplification: It hides complex joins making users to see simple data
2. Security: It hides sensitive information, controls the access, so that 
users don't see the full table.
3. Reusability: Write query once, can use multiple times and can use across 
different applications.
4.Consistency: It uses same logic everywhere, if we update once, it affects all
5.Maintenance: Change query once, all reports reported and easy to maintain
6. Abstraction: Hide table structure, Change table without breaking apps and internal
changes are hidden.*/
-- Creating view with only active customers
create view active_customers as
select customer_id, first_name, last_name, email, active
from sakila.customer
where active=1;

select * from active_customers
limit 20;
-- Creating view with joins
drop view if exists customer_rental_summary;
create view customer_rental_summary as
select c.customer_id, c.first_name, c.last_name, c.email, 
count(r.rental_id) as total_rentals,
max(r.return_date) as last_rentaldate
from sakila.customer as c
left join sakila.rental as r on r.customer_id= c.customer_id
group by c.customer_id
limit 20;
select * from customer_rental_summary;


/* STORED PROCEDURES
Pre-written SQL code saved in database,Can be called by name,
Accepts parameters and returns results and can contain complex logic
*/
DELIMITER //

CREATE PROCEDURE analyze_customer(
IN p_customer_id INT,
OUT p_total_spent DECIMAL(10,2),
OUT p_rental_count INT,
OUT p_avg_payment DECIMAL(10,2))
BEGIN
    SELECT SUM(amount), COUNT(*), ROUND(AVG(amount),2)
    INTO p_total_spent, p_rental_count, p_avg_payment
    FROM sakila.payment 
    WHERE customer_id = p_customer_id;
END//

DELIMITER ;
CALL analyze_customer(1, @total, @count, @avg);
SELECT @total, @count, @avg;
/*SP has Dynamic Nature in which Procedure adapts based on input parameters
Same procedure but different values, not hardcoded to one value, flexible and reusable
META DATA: Data of date like a data dictoneary
-It stores information about the stored procedures 
-It includes Procedure name,Parameter names and types, Parameter directions (IN/OUT/INOUT),
Creation date, Last modified date, Owner/creator and Definition/source code
-SCOPE of SP: Exists permanently in database, Visible to all users (with permissions),
Can be called from any application, Persists across sessions, NOT limited to one connection
and Lasts until dropped
-SP are precompiled where 
Regular SQL:
    Parse → Compile → Optimize → Execute (every time)
Stored Procedure:
    Parse → Compile → Optimize (once at creation)
    Execute (just run compiled code)
Hence it results faster execution
-ENCAPSULATION: Hiding internal implementation details showing only the interface
-
