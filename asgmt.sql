
#                                                  <<   SQL Basics  >>
#                                                << Assignment Questions >>

/*
														Que-1 

 Create a table called employees with the following structure?
: emp_id (integer, should not be NULL and should be a primary key)Q
: emp_name (text, should not be NULL)Q
: age (integer, should have a check constraint to ensure the age is at least 18)Q
: email (text, should be unique for each employee)Q
: salary (decimal, with a default value of 30,000).
Write the SQL query to create the above table with all constraints.
*/
#												Ans-1

CREATE TABLE Employees (
    emp_id INTEGER NOT NULL PRIMARY KEY,
    emp_name TEXT NOT NULL,
    age INTEGER CHECK (age >= 18),
    email VARCHAR(50) UNIQUE,
    salary DECIMAL DEFAULT 30000
);


#													Que-2 

# Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints.

#													Ans-2
/*
Purpose of Constraints in Databases:-
Constraints in databases are rules or limitations that are applied to data to ensure its integrity and accuracy. They act as safeguards, preventing the entry of invalid or inconsistent data, and maintaining the reliability of the information stored within the database.

How Constraints Maintain Data Integrity:-
Enforcing Business Rules: Constraints can be used to enforce specific business rules, such as ensuring that all customer IDs are unique or that the age of employees is within a certain range.
Preventing Data Inconsistencies: By defining rules and limitations, constraints help prevent inconsistencies in data, such as duplicate entries, incorrect data types, or relationships that violate defined rules.
Improving Data Quality: By ensuring that only valid data is entered into the database, constraints contribute to improving the overall quality and reliability of the data.
Common Types of Constraints

Primary Key:
Uniquely identifies each row in a table.
Ensures that each row has a unique identifier.
Cannot be NULL.

Foreign Key:
Establishes a relationship between two tables.
Ensures that values in one table (child table) correspond to values in another table (parent table).
Maintains referential integrity between tables.

Unique:
Ensures that all values in a column or set of columns are unique.
Allows NULL values.

Not Null:
Prevents NULL values from being entered into a column.
Ensures that all rows have a value for the specified column.

Check:
Defines a condition that must be met for a row to be valid.
Allows you to specify custom validation rules for data.

Default:
Specifies a default value for a column if no value is provided during data entry.

Example
Consider a Customers table with the following columns:

CustomerID (Primary Key, Integer, Not Null)
FirstName (Text, Not Null)
LastName (Text, Not Null)
Age (Integer, Check (Age >= 18))

In this example:
CustomerID is the primary key, ensuring that each customer has a unique identifier.
FirstName and LastName cannot be NULL, ensuring that all customers have names.
The Check constraint ensures that only customers aged 18 or older are entered into the database.
*/

/*
														Que-3
Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.

														Ans-3

When we use primary key constraint then it does not contain neither null values nor duplicate values. Using primary key we get 
unique and not null values. But when we want not null values while duplicate values is possible then we would apply the NOT NULL
constraint to a column.
*/

/*
														Que-4
Explain the steps and SQL commands used to add or remove constraints on an existing table. 
Provide an example for both adding and removing a constraint.

														Ans-4

Adding Constraints
The `ALTER TABLE` statement is used for adding constraints.

1. Adding a NOT NULL Constraint:
ALTER TABLE table_name
MODIFY COLUMN column_name datatype NOT NULL;

Example:
Assume you have an `Employees` table and want to add a NOT NULL constraint to the `email` column 
(which is currently `VARCHAR(255)` and allows NULLs).
ALTER TABLE Employees
MODIFY COLUMN email VARCHAR(255) NOT NULL;


2. Adding a UNIQUE Constraint:
ALTER TABLE table_name
ADD CONSTRAINT constraint_name UNIQUE (column_name1, column_name2, ...);

Example: Add a unique constraint to the `email` column:
ALTER TABLE Employees
ADD CONSTRAINT UC_Email UNIQUE (email);
ALTER TABLE Employees
ADD CONSTRAINT UC_FirstName_LastName UNIQUE (first_name, last_name);


3. Adding a PRIMARY KEY Constraint:**
ALTER TABLE table_name
ADD CONSTRAINT PK_table_name PRIMARY KEY (column_name1, column_name2, ...);

Example: Add a primary key to the `emp_id` column:
ALTER TABLE Employees
ADD CONSTRAINT PK_Employees PRIMARY KEY (emp_id);


4. Adding a FOREIGN KEY Constraint:
ALTER TABLE child_table
ADD CONSTRAINT FK_child_table_parent_table
FOREIGN KEY (child_table_column) REFERENCES parent_table(parent_table_column);

Example:  `Employees` table references `Departments` table:
ALTER TABLE Employees
ADD CONSTRAINT FK_Emp_Dept
FOREIGN KEY (dept_id) REFERENCES Departments(dept_id);


5. Adding a CHECK Constraint:
ALTER TABLE table_name
ADD CONSTRAINT CK_constraint_name CHECK (condition);

Example: Ensure `age` is 18 or older:
ALTER TABLE Employees
ADD CONSTRAINT CK_Age CHECK (age >= 18);


6. Adding a DEFAULT Constraint:
ALTER TABLE table_name
ALTER COLUMN column_name SET DEFAULT default_value;

Example:** Default salary to 30000:
ALTER TABLE Employees
ALTER COLUMN salary SET DEFAULT 30000;


Removing Constraints 

Again, `ALTER TABLE` is used.

1. Removing a Constraint (General):
ALTER TABLE table_name
DROP CONSTRAINT constraint_name;

Example: Remove the `UC_Email` unique constraint:
ALTER TABLE Employees
DROP CONSTRAINT UC_Email;


2. Removing a PRIMARY KEY Constraint:
ALTER TABLE table_name
DROP PRIMARY KEY;

Example:
ALTER TABLE Employees
DROP PRIMARY KEY;


3. Removing a FOREIGN KEY Constraint:
ALTER TABLE child_table
DROP FOREIGN KEY FK_child_table_parent_table;

Example:
ALTER TABLE Employees
DROP FOREIGN KEY FK_Emp_Dept;


4. Removing a NOT NULL Constraint:
ALTER TABLE table_name
MODIFY COLUMN column_name datatype NULL;

Example:
ALTER TABLE Employees
MODIFY COLUMN email VARCHAR(255) NULL;


5. Removing a DEFAULT Constraint:
ALTER TABLE table_name
ALTER COLUMN column_name DROP DEFAULT;

Example:
ALTER TABLE Employees
ALTER COLUMN salary DROP DEFAULT;
*/

/*
                                             Que-5
Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
Provide an example of an error message that might occur when violating a constraint.
                                            Ans-5

Consequences of Violating Constraints in Data Manipulation
Constraints in a database are like rules that ensure data integrity and consistency. They define what data is allowed in a table and how different tables relate to each other. Attempting to insert, update, or delete data in a way that violates these constraints can have serious consequences:

1. Data Corruption:
- Constraints prevent invalid data from entering the database. Violating them can lead to corrupted data, where information is inaccurate, incomplete, or inconsistent.
- For example, a constraint might specify that a "price" column must always have a positive value. If you try to insert a row with a negative price, the database will reject the operation, preventing the corruption of financial data.

2. Application Errors:
- Applications rely on the database to provide reliable and consistent data. If constraints are violated and data becomes corrupted, applications may malfunction or produce incorrect results.
- For example, an e-commerce application might crash if it tries to calculate the total price of a shopping cart with a negative price for an item.

3. System Instability:
- In some cases, violating constraints can lead to system instability or even crashes. This is more likely to happen when dealing with complex constraints or large databases.
- For example, a cascade delete constraint might specify that deleting a row in one table automatically deletes related rows in another table. If this constraint is violated, it could lead to orphaned records and inconsistencies that destabilize the database.

4. Security Risks:
- Constraints can also play a role in security by preventing unauthorized data modifications. Violating them could open up security vulnerabilities and expose sensitive information.
- For example, a constraint might restrict the roles that a user can have. If this constraint is violated, a user might gain unauthorized access to sensitive data or functionalities.

5. Business Impact:
- Ultimately, violating constraints can have a significant impact on business operations. It can lead to incorrect decisions, financial losses, customer dissatisfaction, and reputational damage.
- For example, if a constraint on customer addresses is violated, it could lead to misdeliveries, lost orders, and frustrated customers.

Example Error Message:

When we attempt to violate a constraint, the database management system (DBMS) will typically return an error message. The specific message will vary depending on the DBMS and the type of constraint violated. Here's an example of an error message that might occur when violating a unique constraint:
ERROR: duplicate key value violates unique constraint "unique_customer_email"
DETAIL: Key (email)=(john.doe@example.com) already exists.


This message indicates that we tried to insert a new customer record with an email address that already exists in the database, violating the unique constraint on the "email" column.

In conclusion, constraints are essential for maintaining data integrity and consistency. Violating them can have serious consequences, ranging from data corruption to system instability and business impact. It's crucial to understand the constraints defined on your database and ensure that your data manipulation operations comply with them.
*/


#														Que-6
#You created a products table without constraints as follows:
CREATE TABLE products (
	product_id INT,
    product_name VARCHAR(50),
    price DECIMAL(10, 2));
/*
Now, you realise that?
: The product_id should be a primary keyQ
: The price should have a default value of 50.00
*/
#														Ans-6

# To add constraints we use command Alter Table:
alter table products
add constraint primary key (product_id);
alter table products
alter column price set default 50;

#                                                    Que-7
# You have two tables:
-- 1.
create table Students(
student_id int,
student_name char(20),
class_id int 
);
insert into Students values
(1, 'Alice', 101),
(2, 'Bob', 102),
(3, 'Charlie', 101);

-- 2.
create table Classes(
class_id int,
class_name char(20)
);
insert into Classes values
(101, 'Maths'),
(102, 'Science'),
(103, 'History');

# Write a query to fetch the student_name and class_name for each student using an INNER JOIN.
# Ans-7
SELECT s.student_name, c.class_name
FROM students s
INNER JOIN classes c ON s.class_id = c.class_id;

#                                               Que-8 
# Consider the following three tables:
-- 1.
CREATE TABLE Orders (
    order_id int ,
    order_date DATE,
    customer_id int
);

INSERT INTO Orders (order_id, order_date, customer_id) VALUES
(1, '2024-01-01', 101),
(2, '2024-01-03', 102);

-- 2.
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255) NOT NULL  
);
INSERT INTO Customers (customer_id, customer_name) VALUES
(101, 'Alice'),
(102, 'Bob');

-- 3.
CREATE TABLE product (
    product_id int,
    product_name char(30) NOT NULL,  
    order_id INT  
);
INSERT INTO Products VALUES
(1, 'Laptop', 1),
(2, 'Phone', null); 
/*
Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
listed even if they are not associated with an order 
Hint: (use INNER JOIN and LEFT JOIN)
*/
#                                              Ans-8
SELECT
    o.order_id,
    c.customer_name,
    p.product_name
FROM
    Products AS p  -- Start with Products to ensure all are included
LEFT JOIN
    Order_Details AS od ON p.product_id = od.product_id
LEFT JOIN
    Orders AS o ON od.order_id = o.order_id
LEFT JOIN
    Customers AS c ON o.customer_id = c.customer_id
ORDER BY
    o.order_id;  -- Optional: Order by order ID for clarity



#                                        Que-9
# Given the following tables:

CREATE TABLE Sales (
    sale_id INT PRIMARY KEY, 
    product_id INT,
    amount DECIMAL(10, 2) 
);
INSERT INTO Sales (sale_id, product_id, amount) VALUES
(1, 101, 500.00),
(2, 102, 300.00),
(3, 101, 700.00);
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) 
);
INSERT INTO Products (product_id, product_name) VALUES
(101, 'Laptop'),
(102, 'Phone');
# Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function.

#                                                 Ans-9
SELECT
    p.product_name,
    SUM(od.quantity * s.amount) AS total_sales_amount
FROM
    Products AS p
INNER JOIN
    Order_Details AS od ON p.product_id = od.product_id
INNER JOIN
    Sales AS s ON od.product_id = s.product_id  -- Assuming Sales table has amount
GROUP BY
    p.product_name;



#                                  Que-10
#  You are given three tables:

CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE, 
    customer_id INT
);
INSERT INTO Orders (order_id, order_date, customer_id) VALUES
(1, '2024-01-02', 1),
(2, '2024-01-05', 2);


CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255) 
);
INSERT INTO Customers (customer_id, customer_name) VALUES
(1, 'Alice'),
(2, 'Bob');


CREATE TABLE Order_Details (
    order_id INT,
    product_id INT,
    quantity INT
    );
INSERT INTO Order_Details (order_id, product_id, quantity) VALUES
(1, 101, 2),
(1, 102, 1),
(2, 101, 3);

# Write a query to display the order_id, customer_name, and the quantity of products ordered by each customer using an INNER JOIN between all three tables.

#                                            Ans-10
SELECT
    o.order_id,
    c.customer_name,
    od.quantity
FROM
    Orders AS o
INNER JOIN
    Customers AS c ON o.customer_id = c.customer_id
INNER JOIN
    Order_Details AS od ON o.order_id = od.order_id
ORDER BY
    o.order_id; -- Optional: Order by order ID for clarity



use sakila;
#                                    <<<  SQL Commands  >>>

# Que-1 Identify the primary keys and foreign keys in maven movies db. Discuss the differences
# Ans-1

-- Identify Primary Keys and Foreign Keys in Maven Movies DB
-- Tables and their Primary Keys:

SELECT table_name, column_name, constraint_name
FROM information_schema.key_column_usage
WHERE table_schema = 'maven_movies'  -- Replace with your database name if different
  AND constraint_name LIKE 'PRIMARY%'
ORDER BY table_name, ordinal_position;

-- Tables and their Foreign Keys:

SELECT table_name, column_name, constraint_name, referenced_table_name, referenced_column_name
FROM information_schema.referential_constraints AS rc
INNER JOIN information_schema.key_column_usage AS kcu
ON rc.constraint_name = kcu.constraint_name
WHERE kcu.table_schema = 'maven_movies' -- Replace with your database name if different
ORDER BY kcu.table_name, kcu.ordinal_position;

-- Example for a specific table (e.g., film):
DESCRIBE film;  -- Shows primary key (if any)

-- Example to check foreign keys referencing a specific table (e.g. film)
SELECT kcu.table_name, kcu.column_name, rc.constraint_name
FROM information_schema.referential_constraints AS rc
INNER JOIN information_schema.key_column_usage AS kcu
ON rc.constraint_name = kcu.constraint_name
WHERE rc.referenced_table_name = 'film';


# Que-2  List all details of actors.alter
# Ans-2
SELECT actor_id, first_name, last_name, last_update
FROM actor;

# Que-3 List all customer information from DB.alter
# Ans-3 
select customer_id, store_id, first_name, last_name, email, address_id, active, create_date, last_update
from customer;


# Que-4 -List different countries.
# Ans-4
SELECT DISTINCT country
FROM country;



# Que-5 -Display all active customers.
# Ans-5
SELECT *
FROM customer
WHERE active = 1;  -- Or WHERE active = TRUE; 

# Que-6 -List of all rental IDs for customer with ID 1.
# Ans-6
SELECT rental_id
FROM rental
WHERE customer_id = 1;

# Que-7 - Display all the films whose rental duration is greater than 5 .
# Ans-7
SELECT *  -- Or specify the columns you want to see (e.g., film_id, title, description)
FROM film
WHERE rental_duration > 5;

# Que-8 - List the total number of films whose replacement cost is greater than $15 and less than $20.
# Ans-8
SELECT COUNT(*) AS total_films
FROM film
WHERE replacement_cost BETWEEN 15 AND 20;

# Que-9 - Display the count of unique first names of actors.
# Ans-9
SELECT COUNT(DISTINCT first_name) AS unique_first_names
FROM actor;

# Que-10- Display the first 10 records from the customer table .
# Ans-10
SELECT *
FROM customer
LIMIT 10;

# Que-11 - Display the first 3 records from the customer table whose first name starts with ‘b’.
# Ans-11
SELECT *  -- Or specify the columns you want to retrieve
FROM customer
WHERE first_name LIKE 'b%'
LIMIT 3;

# Que-12 -Display the names of the first 5 movies which are rated as ‘G’.
# Ans-12
SELECT title
FROM film
WHERE rating = 'G'
LIMIT 5;

# Que-13-Find all customers whose first name starts with "a".
# Ans-13
SELECT *  -- Or list specific columns if you don't need all of them
FROM customer
WHERE first_name LIKE 'a%';

# Que-14- Find all customers whose first name ends with "a".
# Ans-14
SELECT *  -- Or specify the columns you want to retrieve
FROM customer
WHERE first_name LIKE '%a';

# Que-15- Display the list of first 4 cities which start and end with ‘a’ .
# Ans-15
SELECT city
FROM city
WHERE city LIKE 'a%a'
LIMIT 4;

# Que-16- Find all customers whose first name have "NI" in any position.
# Ans-16
SELECT *  -- Or list specific columns if you don't need all of them
FROM customer
WHERE first_name LIKE '%ni%';

# Que-17- Find all customers whose first name have "r" in the second position .
# Ans-17
SELECT *  -- Or specify the columns you want
FROM customer
WHERE first_name LIKE '_r%';

# Que-18 - Find all customers whose first name starts with "a" and are at least 5 characters in length.
# Ans-18
SELECT *  -- Or specify the columns you want
FROM customer
WHERE first_name LIKE 'a%' AND LENGTH(first_name) >= 5;

# Que-19- Find all customers whose first name starts with "a" and ends with "o".
# Ans-19
SELECT *  -- Or specify the columns you want
FROM customer
WHERE first_name LIKE 'a%o';

# Que-20 - Get the films with pg and pg-13 rating using IN operator.
# Ans-20
SELECT *  -- Or specify the columns you want (e.g., film_id, title, rating)
FROM film
WHERE rating IN ('PG', 'PG-13');

# Que-21 - Get the films with length between 50 to 100 using between operator.
# Ans-21
SELECT *  -- Or specify the columns you want (e.g., film_id, title, length)
FROM film
WHERE length BETWEEN 50 AND 100;

# Que-22 - Get the top 50 actors using limit operator.
# Ans-22
SELECT *  -- Or specify the columns you want (e.g., actor_id, first_name, last_name)
FROM actor
LIMIT 50;

# Que-23 - Get the distinct film ids from inventory table.
# Ans-23
SELECT DISTINCT film_id
FROM inventory;



#                                     <<<  Functions  >>>

#                                 Basic Aggregate Functions:


/*
Question 1:
Retrieve the total number of rentals made in the Sakila database.
Hint: Use the COUNT() function.
*/
SELECT COUNT(*) AS total_rentals
FROM rental;


/*
Question 2:
Find the average rental duration (in days) of movies rented from the Sakila database.
Hint: Utilize the AVG() function.
*/
SELECT AVG(rental_duration) AS average_rental_duration
FROM film;

 
                                  # String Functions:
 
 
 /*
Question 3:
Display the first name and last name of customers in uppercase.
Hint: Use the UPPER () function.
*/
SELECT UPPER(first_name) AS uppercase_first_name, UPPER(last_name) AS uppercase_last_name
FROM customer;
/*


Question 4:
Extract the month from the rental date and display it alongside the rental ID.
Hint: Employ the MONTH() function.
*/
SELECT rental_id, MONTH(rental_date) AS rental_month
FROM rental;

                                               # GROUP BY:


/*
Question 5:
Retrieve the count of rentals for each customer (display customer ID and the count of rentals).
Hint: Use COUNT () in conjunction with GROUP BY.
*/
SELECT customer_id, COUNT(*) AS rental_count
FROM rental
GROUP BY customer_id;


/*
Question 6:
Find the total revenue generated by each store.
Hint: Combine SUM() and GROUP BY.
*/
SELECT s.store_id, SUM(p.amount) AS total_revenue
FROM payment AS p
JOIN rental AS r ON p.rental_id = r.rental_id
JOIN customer AS c ON r.customer_id = c.customer_id
JOIN store AS s ON c.store_id = s.store_id
GROUP BY s.store_id;


/*
Question 7:
Determine the total number of rentals for each category of movies.
Hint: JOIN film_category, film, and rental tables, then use cOUNT () and GROUP BY.
*/
SELECT fc.category_id, c.name AS category_name, COUNT(r.rental_id) AS total_rentals
FROM film_category AS fc
JOIN film AS f ON fc.film_id = f.film_id
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN category AS c ON fc.category_id = c.category_id
GROUP BY fc.category_id, c.name
ORDER BY total_rentals DESC; -- Optional: Order by rental count


/*
Question 8:
Find the average rental rate of movies in each language.
Hint: JOIN film and language tables, then use AVG () and GROUP BY.
*/
SELECT l.name AS language_name, AVG(f.rental_rate) AS average_rental_rate
FROM film AS f
JOIN language AS l ON f.language_id = l.language_id
GROUP BY l.name;





#                                          <<<  Joins  >>>



/*
Questions 9 -
Display the title of the movie, customer s first name, and last name who rented it.
Hint: Use JOIN between the film, inventory, rental, and customer tables.
*/
SELECT f.title, c.first_name, c.last_name
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
JOIN customer AS c ON r.customer_id = c.customer_id;


/*
Question 10:
Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
Hint: Use JOIN between the film actor, film, and actor tables.
*/
SELECT a.name  -- Or a.actor_name, a.first_name || ' ' || a.last_name (if separate columns)
FROM actor AS a
JOIN film_actor AS fa ON a.actor_id = fa.actor_id
JOIN film AS f ON fa.film_id = f.film_id
WHERE f.title = "Gone with the Wind";  -- Or f.film_title, f.movie_title, etc.


/*
Question 11:
Retrieve the customer names along with the total amount they've spent on rentals.
Hint: JOIN customer, payment, and rental tables, then use SUM() and GROUP BY.
*/
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer AS c
JOIN rental AS r ON c.customer_id = r.customer_id
JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY c.first_name, c.last_name
ORDER BY total_spent DESC; -- Optional: Order by spending


/*
Question 12:
List the titles of movies rented by each customer in a particular city (e.g., 'London').
Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
*/
SELECT c.first_name, c.last_name, GROUP_CONCAT(f.title SEPARATOR ', ') AS movies_rented  -- Or LISTAGG for some databases
FROM customer AS c
JOIN address AS a ON c.address_id = a.address_id
JOIN city AS cy ON a.city_id = cy.city_id
JOIN rental AS r ON c.customer_id = r.customer_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film AS f ON i.film_id = f.film_id
WHERE cy.city = 'London'  -- Replace 'London' with the desired city
GROUP BY c.first_name, c.last_name
ORDER BY c.last_name, c.first_name; -- Optional: Order by customer name





#                                  <<<  Advanced Joins and GROUP BY:  >>>
/*
Question 13:
Display the top 5 rented movies along with the number of times they've been rented.
Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results.
*/
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film AS f
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 5;

/*
Question 14:
Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.
*/
SELECT c.customer_id, c.first_name, c.last_name
FROM customer AS c
JOIN rental AS r ON c.customer_id = r.customer_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN store AS s ON i.store_id = s.store_id  -- Join with the store table
WHERE s.store_id IN (1, 2)  -- Filter for rentals from store 1 or 2
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(DISTINCT s.store_id) = 2;  -- Ensure they've rented from BOTH stores





#                                 <<<   Windows Function:  >>>



# Que-1. Rank the customers based on the total amount they've spent on rentals.
# Ans-1
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.amount) AS total_spent,
       RANK() OVER (ORDER BY SUM(p.amount) DESC) AS customer_rank
FROM customer AS c
JOIN rental AS r ON c.customer_id = r.customer_id
JOIN payment AS p ON r.rental_id = p.rental_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_spent DESC;  -- Optional: Order by total spent


# Que-2. Calculate the cumulative revenue generated by each film over time.
# Ans-2
SELECT
    f.title,
    r.rental_date,  -- Or a suitable date column (e.g., payment_date)
    SUM(p.amount) OVER (PARTITION BY f.film_id ORDER BY r.rental_date) AS cumulative_revenue
FROM
    film AS f
JOIN
    inventory AS i ON f.film_id = i.film_id
JOIN
    rental AS r ON i.inventory_id = r.inventory_id
JOIN
    payment AS p ON r.rental_id = p.rental_id
ORDER BY
    f.title, r.rental_date;


# Que-3. Determine the average rental duration for each film, considering films with similar lengths.
# Ans-3
WITH FilmLengths AS (
    SELECT
        f.film_id,
        f.title,
        f.length,
        AVG(f.length) OVER () AS overall_avg_length,  -- Average length of all films
        (f.length - AVG(f.length) OVER ()) / (SELECT MAX(length) - MIN(length) FROM film) * 100 AS length_similarity_score -- Similarity score based on length
    FROM
        film AS f
),
GroupedFilmLengths AS (
    SELECT
        fl.film_id,
        fl.title,
        fl.length,
        CASE
            WHEN ABS(fl.length - fl.overall_avg_length) <= (SELECT AVG(length) * 0.1 FROM film) THEN 'Similar Length' -- 10% tolerance for similar length
            ELSE 'Different Length'
        END AS length_group
    FROM FilmLengths fl
),
AverageRentalDuration AS (
  SELECT
        gfl.title,
        AVG(TIMESTAMPDIFF(SECOND, r.rental_date, r.return_date) / 60) AS avg_rental_duration_minutes -- Average rental duration in minutes
    FROM
        GroupedFilmLengths AS gfl
    JOIN
        inventory AS i ON gfl.film_id = i.film_id
    JOIN
        rental AS r ON i.inventory_id = r.inventory_id
    GROUP BY
        gfl.title, gfl.length_group
)
SELECT * FROM AverageRentalDuration;


# Que-4. Identify the top 3 films in each category based on their rental counts.
# Ans-4
WITH FilmRentalCounts AS (
    SELECT
        f.title,
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count,
        ROW_NUMBER() OVER (PARTITION BY c.category_id ORDER BY COUNT(r.rental_id) DESC) AS rn
    FROM
        film AS f
    JOIN
        film_category AS fc ON f.film_id = fc.film_id
    JOIN
        category AS c ON fc.category_id = c.category_id
    LEFT JOIN  -- Important: Use LEFT JOIN to include even unrented films
        inventory AS i ON f.film_id = i.film_id
    LEFT JOIN  -- Important: Use LEFT JOIN to include even unrented films
        rental AS r ON i.inventory_id = r.inventory_id
    GROUP BY
        f.title, c.name
)
SELECT
    title,
    category_name,
    rental_count
FROM
    FilmRentalCounts
WHERE
    rn <= 3  -- Filter for the top 3 in each category
ORDER BY
    category_name, rental_count DESC;


# Que-5. Calculate the difference in rental counts between each customer's total rentals and the average rentals across all customers.
# Ans-5
WITH CustomerRentalCounts AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        COUNT(r.rental_id) AS total_rentals
    FROM
        customer AS c
    JOIN
        rental AS r ON c.customer_id = r.customer_id
    GROUP BY
        c.customer_id, c.first_name, c.last_name
),
AverageRentals AS (
    SELECT AVG(total_rentals) AS avg_rentals
    FROM CustomerRentalCounts
)
SELECT
    crc.customer_id,
    crc.first_name,
    crc.last_name,
    crc.total_rentals,
    ar.avg_rentals,
    crc.total_rentals - ar.avg_rentals AS rental_difference
FROM
    CustomerRentalCounts AS crc
CROSS JOIN  -- CROSS JOIN is appropriate here since it's a single average value
    AverageRentals AS ar
ORDER BY
    rental_difference DESC; -- Optional: Order by the difference


# Que-6. Find the monthly revenue trend for the entire rental store over time.
# Ans-6
SELECT
    DATE_TRUNC('month', r.rental_date) AS rental_month,  -- Extract the month and year
    SUM(p.amount) AS monthly_revenue
FROM
    rental AS r
JOIN
    payment AS p ON r.rental_id = p.rental_id
GROUP BY
    rental_month
ORDER BY
    rental_month;


# Que-7. Identify the customers whose total spending on rentals falls within the top 20% of all customers.
# Ans-7
WITH CustomerSpending AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_spending
    FROM
        customer AS c
    JOIN
        rental AS r ON c.customer_id = r.customer_id
    JOIN
        payment AS p ON r.rental_id = p.rental_id
    GROUP BY
        c.customer_id, c.first_name, c.last_name
),
SpendingPercentiles AS (
  SELECT
    PERCENTILE_CONT(0.80) WITHIN GROUP (ORDER BY total_spending) as top_20_percent_cutoff
  FROM CustomerSpending
)
SELECT
    cs.customer_id,
    cs.first_name,
    cs.last_name,
    cs.total_spending
FROM
    CustomerSpending AS cs
CROSS JOIN SpendingPercentiles sp
WHERE
    cs.total_spending >= sp.top_20_percent_cutoff
ORDER BY
    cs.total_spending DESC;


# Que-8. Calculate the running total of rentals per category, ordered by rental count.
# Ans-8
WITH CategoryRentalCounts AS (
    SELECT
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM
        film AS f
    JOIN
        film_category AS fc ON f.film_id = fc.film_id
    JOIN
        category AS c ON fc.category_id = c.category_id
    LEFT JOIN  -- Important: Use LEFT JOIN to include even unrented films
        inventory AS i ON f.film_id = i.film_id
    LEFT JOIN  -- Important: Use LEFT JOIN to include even unrented films
        rental AS r ON i.inventory_id = r.inventory_id
    GROUP BY
        c.name
),
RunningTotal AS (
  SELECT
        category_name,
        rental_count,
        SUM(rental_count) OVER (ORDER BY rental_count DESC) AS running_total
    FROM
        CategoryRentalCounts
)
SELECT * FROM RunningTotal;


# Que-9. Find the films that have been rented less than the average rental count for their respective categories.
# Ans-9
WITH FilmCategoryRentals AS (
    SELECT
        f.film_id,
        f.title,
        c.category_id,
        c.name AS category_name,
        COUNT(r.rental_id) AS rental_count
    FROM
        film AS f
    JOIN
        film_category AS fc ON f.film_id = fc.film_id
    JOIN
        category AS c ON fc.category_id = c.category_id
    LEFT JOIN  -- Important: Use LEFT JOIN to include even unrented films
        inventory AS i ON f.film_id = i.film_id
    LEFT JOIN  -- Important: Use LEFT JOIN to include even unrented films
        rental AS r ON i.inventory_id = r.inventory_id
    GROUP BY
        f.film_id, f.title, c.category_id, c.name
),
AverageCategoryRentals AS (
    SELECT
        category_id,
        AVG(rental_count) AS avg_category_rentals
    FROM
        FilmCategoryRentals
    GROUP BY
        category_id
)
SELECT
    fcr.title,
    fcr.category_name,
    fcr.rental_count
FROM
    FilmCategoryRentals AS fcr
JOIN
    AverageCategoryRentals AS acr ON fcr.category_id = acr.category_id
WHERE
    fcr.rental_count < acr.avg_category_rentals
ORDER BY
    fcr.category_name, fcr.rental_count; -- Optional: Order by category and rental count


# Que-10. Identify the top 5 months with the highest revenue and display the revenue generated in each month.
# Ans-10
WITH MonthlyRevenue AS (
    SELECT
        DATE_TRUNC('month', r.rental_date) AS rental_month,  -- Or equivalent date truncation function
        SUM(p.amount) AS monthly_revenue
    FROM
        rental AS r
    JOIN
        payment AS p ON r.rental_id = p.rental_id
    GROUP BY
        rental_month
),
RankedMonthlyRevenue AS (
    SELECT
        rental_month,
        monthly_revenue,
        RANK() OVER (ORDER BY monthly_revenue DESC) AS revenue_rank
    FROM
        MonthlyRevenue
)
SELECT
    rental_month,
    monthly_revenue
FROM
    RankedMonthlyRevenue
WHERE
    revenue_rank <= 5
ORDER BY
    rental_month;  -- Optional: Order chronologically
    
    
    
    
    

#                              <<<  Normalisation & CTE  >>>



# 1. First Normal Form (1NF): a. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.
# Ans
DESCRIBE film;  -- Or SHOW COLUMNS FROM film;
CREATE TABLE film_special_feature (
    film_id smallint UNSIGNED NOT NULL,  -- EXACTLY the same as in the film table
    special_feature VARCHAR(255) NOT NULL,
    FOREIGN KEY (film_id) REFERENCES film(film_id),
    PRIMARY KEY (film_id, special_feature)
);



# 2. Second Normal Form (2NF): a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it.
# Ans
DESCRIBE film;  -- Or SHOW COLUMNS FROM film;
CREATE TABLE film_release (
    film_id smallint UNSIGNED NOT NULL,
    release_year YEAR,
    FOREIGN KEY (film_id) REFERENCES film(film_id),
    PRIMARY KEY (film_id)
);



# 3. Third Normal Form (3NF): a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps to normalize the table to 3NF.
# Ans
DESCRIBE city;  -- Or SHOW COLUMNS FROM city;
CREATE TABLE city_country (
    city_id smallint UNSIGNED NOT NULL,
    country_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (city_id) REFERENCES city(city_id),
    PRIMARY KEY (city_id)
);



# 4. Normalization Process: a. Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF.
# Ans
CREATE TABLE film_special_feature (
    film_id INT UNSIGNED NOT NULL,
    special_feature VARCHAR(255) NOT NULL,
    FOREIGN KEY (film_id) REFERENCES film(film_id),
    PRIMARY KEY (film_id, special_feature)
);
CREATE TABLE film_director (
    film_id smallint UNSIGNED NOT NULL,
    director_name VARCHAR(255) NOT NULL,
    FOREIGN KEY (film_id) REFERENCES film(film_id),
    PRIMARY KEY (film_id, director_name)
);
CREATE TABLE film_genre (
    film_id smallint UNSIGNED NOT NULL,
    genre VARCHAR(255) NOT NULL,
    FOREIGN KEY (film_id) REFERENCES film(film_id),
    PRIMARY KEY (film_id, genre)
);
ALTER TABLE film
DROP COLUMN special_features,
DROP COLUMN director_name,
DROP COLUMN genre;



# 5. CTE Basics: a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have acted in from the actor and film_actor tables.
# Ans
WITH ActorFilmCounts AS (
    SELECT
        a.actor_id,
        a.first_name,
        a.last_name,
        COUNT(fa.film_id) AS film_count
    FROM
        actor AS a
    LEFT JOIN  -- Use LEFT JOIN to include actors even if they've been in no films
        film_actor AS fa ON a.actor_id = fa.actor_id
    GROUP BY
        a.actor_id, a.first_name, a.last_name
)
SELECT
    first_name,
    last_name,
    film_count
FROM
    ActorFilmCounts
ORDER BY
    film_count DESC; -- Optional: Order by film count



# 6. CTE with Joins: a. Create a CTE that combines information from the film and language tables to display the film title, language name, and rental rate.
# Ans
WITH FilmLanguageInfo AS (
    SELECT
        f.title,
        l.name AS language_name,
        f.rental_rate
    FROM
        film AS f
    JOIN
        language AS l ON f.language_id = l.language_id
)
SELECT
    title,
    language_name,
    rental_rate
FROM
    FilmLanguageInfo;



# 7. CTE for Aggregation: a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments) from the customer and payment tables.
# Ans
WITH CustomerRevenue AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        SUM(p.amount) AS total_revenue
    FROM
        customer AS c
    JOIN
        payment AS p ON c.customer_id = p.customer_id
    GROUP BY
        c.customer_id, c.first_name, c.last_name
)
SELECT
    customer_id,
    first_name,
    last_name,
    total_revenue
FROM
    CustomerRevenue
ORDER BY
    total_revenue DESC; -- Optional: Order by revenue



# 8. CTE with Window Functions: a. Utilize a CTE with a window function to rank films based on their rental duration from the film table.
# Ans
WITH FilmRentalDurations AS (
    SELECT
        f.film_id,
        f.title,
        AVG(TIMESTAMPDIFF(SECOND, r.rental_date, r.return_date)) / 60 AS avg_rental_duration_minutes,  -- Average duration in minutes
        RANK() OVER (ORDER BY AVG(TIMESTAMPDIFF(SECOND, r.rental_date, r.return_date)) DESC) AS rental_duration_rank
    FROM
        film AS f
    JOIN
        inventory AS i ON f.film_id = i.film_id
    JOIN
        rental AS r ON i.inventory_id = r.inventory_id
    GROUP BY
        f.film_id, f.title
)
SELECT
    film_id,
    title,
    avg_rental_duration_minutes,
    rental_duration_rank
FROM
    FilmRentalDurations
ORDER BY
    rental_duration_rank;  -- Optional: Order by rank



# 9. CTE and Filtering: a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer details
# Ans
WITH HighRentalCustomers AS (
    SELECT
        customer_id,
        COUNT(rental_id) AS rental_count
    FROM
        rental
    GROUP BY
        customer_id
    HAVING
        COUNT(rental_id) > 2
)
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    c.email,
    hrc.rental_count
FROM
    customer AS c
JOIN
    HighRentalCustomers AS hrc ON c.customer_id = hrc.customer_id
ORDER BY
    c.last_name, c.first_name; -- Optional: Order the results

 

# 10. CTE for Date Calculations: a. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table.
# Ans
WITH MonthlyRentals AS (
    SELECT
        DATE_FORMAT(rental_date, '%Y-%m-01') AS rental_month,  -- MySQL date formatting
        COUNT(rental_id) AS total_rentals
    FROM
        rental
    GROUP BY
        rental_month
)
SELECT
    rental_month,
    total_rentals
FROM
    MonthlyRentals
ORDER BY
    rental_month;



# 11. CTE and Self-Join: a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together, using the film_actor table.
# Ans
WITH ActorPairs AS (
    SELECT
        fa1.actor_id AS actor1_id,
        a1.first_name AS actor1_first_name,
        a1.last_name AS actor1_last_name,
        fa2.actor_id AS actor2_id,
        a2.first_name AS actor2_first_name,
        a2.last_name AS actor2_last_name,
        f.title AS film_title
    FROM
        film_actor AS fa1
    JOIN
        film_actor AS fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id  -- Avoid duplicates and comparing an actor to themselves
    JOIN
        actor AS a1 ON fa1.actor_id = a1.actor_id
    JOIN
        actor AS a2 ON fa2.actor_id = a2.actor_id
    JOIN
        film AS f ON fa1.film_id = f.film_id
)
SELECT
    actor1_first_name,
    actor1_last_name,
    actor2_first_name,
    actor2_last_name,
    film_title
FROM
    ActorPairs
ORDER BY
    film_title, actor1_last_name, actor2_last_name; -- Optional ordering



# 12. CTE for Recursive Search: a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering the reports_to column
# Ans
 WITH RECURSIVE EmployeeHierarchy AS (
    -- Anchor member: Select the direct reports of the specified manager
    SELECT staff_id, first_name, address_id
    FROM staff
    WHERE address_id = 101  -- Replace <manager_id> with the actual manager ID

    UNION ALL

    -- Recursive member: Select employees who report to someone already in the hierarchy
    SELECT e.staff_id, e.first_name, e.address_id
    FROM staff e
    INNER JOIN EmployeeHierarchy eh ON e.address_id = eh.staff_id
)

-- Final SELECT statement to retrieve all employees in the hierarchy
SELECT staff_id, first_name
FROM EmployeeHierarchy;

WITH RECURSIVE EmployeeHierarchy AS (
    SELECT staff_id, first_name, address_id
    FROM staff
    WHERE address_id = 101

    UNION ALL
	SELECT e.staff_id, e.first_name, e.address_id
    FROM staff e
    INNER JOIN EmployeeHierarchy eh ON e.address_id = eh.staff_id
)
SELECT staff_id, first_name
FROM EmployeeHierarchy;
    
    
    
    
    
    
    
    
    
    
    





