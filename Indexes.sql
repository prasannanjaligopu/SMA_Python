#INDEXING: Creating a faster lookup mechanism for database queries
-- If we want to find customer without index, it will read the entire table 
-- i.e., has to check every record until it found it and takes long time
-- If we index like customer_id=5, it will directly goes to id 5, which is faster 
-- Leaf nodes stores the actual data
#Clustered Index: Determines physical order of rows in table, data sorted by this column
-- Only one per table which is like primary key which is kind of fast index type
#Non-Clustered Index:A non-clustered index is a separate structure from the actual table data. 
-- It stores pointers (row IDs or PK values) to the actual rows in the clustered index.
-- It can be more than one
-- Leaf nodes stores the pointers referring to the actual data
-- Slower than clustered index because it adds extra lookup step which is bookmark lookup
-- Create new employees table

drop table if exists employees;
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date DATE,
    active INT
);
INSERT INTO employees VALUES
(1, 'JOHN', 'SMITH', 'john.smith@company.com', 'Sales', 50000.00, '2020-01-15', 1),
(2, 'MARY', 'JOHNSON', 'mary.johnson@company.com', 'IT', 65000.00, '2019-05-20', 1),
(3, 'ROBERT', 'WILLIAMS', 'robert.williams@company.com', 'HR', 55000.00, '2018-03-10', 1),
(4, 'PATRICIA', 'BROWN', 'patricia.brown@company.com', 'Sales', 52000.00, '2021-02-14', 1),
(5, 'MICHAEL', 'JONES', 'michael.jones@company.com', 'IT', 70000.00, '2017-06-25', 1),
(6, 'LINDA', 'GARCIA', 'linda.garcia@company.com', 'HR', 58000.00, '2019-08-30', 1),
(7, 'DAVID', 'MILLER', 'david.miller@company.com', 'Sales', 51000.00, '2020-11-05', 1),
(8, 'BARBARA', 'DAVIS', 'barbara.davis@company.com', 'IT', 68000.00, '2018-09-12', 1),
(9, 'JAMES', 'RODRIGUEZ', 'james.rodriguez@company.com', 'Finance', 60000.00, '2019-12-01', 1),
(10, 'SUSAN', 'MARTINEZ', 'susan.martinez@company.com', 'Finance', 62000.00, '2020-04-18', 1);
select * from employees;
SHOW INDEXES FROM employees;
-- Search by PRIMARY KEY (Clustered Index)
SELECT * FROM employees WHERE employee_id = 5;
-- Search by non-primary key column (Full table scan)
SELECT * FROM employees WHERE department = 'IT';
EXPLAIN SELECT * FROM employees WHERE department = 'IT'; -- cost=1.15 rows=9
-- Create a regular (non-clustered) index on first_name
CREATE INDEX idx_first_name ON employees(first_name);

-- Create a regular (non-clustered) index on email
CREATE INDEX idx_email ON employees(email);

-- Create a regular (non-clustered) index on department
CREATE INDEX idx_department ON employees(department);

-- Create a regular (non-clustered) index on salary
CREATE INDEX idx_salary ON employees(salary);

SHOW INDEXES FROM employees;
SELECT * FROM employees WHERE department = 'IT';
EXPLAIN SELECT * FROM employees WHERE department = 'IT'; -- cost=0.8 rows=3


#NATURAL KEY: Existing attribute in real world which has business meaning
-- Thses are unique by nature like SSN, email, student ID
-- Usually these comes from business data
#SURROGATE KEY: These are artificially created without any business meaning
-- It is just a unique identifier like auto-increment integer and these are created by database