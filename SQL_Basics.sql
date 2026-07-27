/*
Workbench: It is a interface use to connect to and interact with a database server.It's where you write and execute SQL queries.
Server: It manages all data storage, retrieval, and processing.A single server can host multiple databases.
Database: A logical container that hosted on sql server. A database is a structured system that stores, organizes, and manages large amounts of data in a way that allows easy access, retrieval, and modification.
Schema: A logical namespace/container within a database that organizes tables, views, and stored procedures.
Tables: The actual data structures where real data is stored in rows and columns. Tables live inside schemas. Each table has a defined structure with column names, data types, and constraints.
Views: Virtual tables created by querying existing tables. They don't store data themselves—they're just saved queries that pull data from tables. Views also live in schemas and can reference multiple tables.
Stored Procedures: Reusable blocks of SQL code (with logic, loops, conditions) that are stored in the database and can be executed. They also live in schemas and operate on tables and views. They're like functions/methods in programming.

SQL: SQL is a standardized programming language designed to manage and manipulate data in database on server.
SQL Commands:
1.DDL (Data Definition Language): These used to define the structure of databases, tables, and other objects.
Commands to CREATE, ALTER, DROP database objects
2.DML(Data Manipulation Language):These are used to add, modify, retrieve, and delete data from tables.
Commands to work with DATA inside tables
3. DCL (Data Control Language):DCL commands manage user permissions and security.
Commands to CONTROL ACCESS to data
4.TCL (Transaction Control Language):It ensure data consistency. A transaction is a group of commands that must all succeed or all fail together.
5.DQL(Data Query Language): Querying or retrieving the data.
*/
CREATE DATABASE IF NOT EXISTS shop; -- Creating the database
USE shop;
-- Drop tables if they exist (to avoid errors on re-run)
DROP TABLE IF EXISTS orders_data;
DROP TABLE IF EXISTS customers_data;
-- -- creating the table 
CREATE TABLE customers_data (
    customer_id INT PRIMARY KEY, -- unique identifier for each customer
    name VARCHAR(100) NOT NULL, -- customer name can not be null, it must has some name
    email VARCHAR(100)  -- customer email is not a required, it is optional
); 

CREATE TABLE orders_data (
    order_id INT PRIMARY KEY, -- unique identifier for each order
    customer_id INT NOT NULL, -- links to customers_data table and it is required
    product VARCHAR(100),
    amount DECIMAL(10,2), -- it allows decimal points upto 2 digits
    FOREIGN KEY (customer_id) REFERENCES customers_data(customer_id) 
    -- FOREIGN KEY constraint: Ensures customer_id exists in customers_data table
    -- it prevents invalid customer references
);
-- Inserting the values in to the corresponding tables
INSERT INTO customers_data(customer_id, name, email)
VALUES
(1, 'John', 'john@gmail.com'),
(2, 'Nick', 'Nickjacks@gmail.com'),
(3, 'Eesha', 'eesha123@gmail.com'),
(4, 'James', 'james@yahoo.com');

INSERT INTO orders_data(order_id, customer_id, product, amount)
VALUES 
(101, 1, 'Laptop', 1000),
(102, 1, 'Mouse', 50),
(103, 2, 'Keyboard', 80),
(104, 3, 'Monitor', 300);
-- selecting all the data from their respective tables
SELECT * FROM shop.customers_data; 
SELECT * FROM shop.orders_data;

-- adding the columns to the tables
ALTER TABLE customers_data ADD COLUMN phone VARCHAR(50);
SELECT * FROM shop.customers_data; 
ALTER TABLE orders_data ADD COLUMN state VARCHAR(100) DEFAULT 'NewYork';
-- Default is used to set the particular value if you didn't assign any value to that
SELECT * FROM shop.orders_data;
-- updating the phone number for the customers
UPDATE customers_data SET phone = '86589678' where customer_id=1;
UPDATE customers_data SET phone = '76583967' where customer_id=2;
UPDATE customers_data SET phone = '24792893' where customer_id=3;

-- Renaming the column name
ALTER table customers_data RENAME COLUMN email to customer_email;

ALTER TABLE orders_data DROP COLUMN state; -- city column is completely removed
SELECT * FROM shop.orders_data;

-- DELETE is used to delete particular rows in a table
DELETE FROM customers_data WHERE customer_id='4';

SELECT * FROM shop.customers_data;
DELETE FROM customers_data; -- daletes all the data from table as a truncate do, but 
-- Delete does by row by row, slower and can rollback
-- where the TRUNCATE deletes the entire data at a time, faster and cannot be rollback
SELECT * FROM shop.customers_data;
SET SQL_SAFE_UPDATES = 0;

-- TRUNCATE is used to delete all rows instantly
TRUNCATE TABLE orders_data;
SELECT * FROM orders_data; 

-- DROP is used to delete entire table and also to delete entire Database
DROP table orders_data;
DROP database shop;