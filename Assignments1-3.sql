--Assignment 1 - Getting Started
CREATE TABLE users (
    user_id INT IDENTITY PRIMARY KEY,
    user_first_name VARCHAR(30) NOT NULL,
    user_last_name VARCHAR(30) NOT NULL,
    user_email_id VARCHAR(50) NOT NULL,
    user_email_validated BIT DEFAULT 0,
    user_password VARCHAR(200),
    user_role VARCHAR(1) NOT NULL DEFAULT 'U', --U and A
    is_active BIT DEFAULT 0,
    created_dt DATE DEFAULT GETDATE()
);

--Assignment 2 - CRUD Operations
CREATE TABLE courses(
	course_id INT IDENTITY PRIMARY KEY,
	course_name VARCHAR(60),
	course_author VARCHAR(40),
	course_status VARCHAR(9),
	course_published_dt DATE DEFAULT GETDATE()
);
-- Exercise 2: Insert Data
INSERT INTO courses (course_name, course_author, course_status, course_published_dt) VALUES
    ('Programming using Python', 'Bob Dillon', 'published', '2020-09-30'),
    ('Data Engineering using Python', 'Bob Dillon', 'published', '2020-07-15')

INSERT INTO courses (course_name, course_author, course_status) VALUES
    ('data Engineering using Scala', 'Elvis Presley', 'draft')


INSERT INTO courses (course_name, course_author, course_status, course_published_dt) VALUES
    ('Programming using Scala', 'Elvis Presley', 'published', '2020-05-12'),
    ('Programming using Java', 'Mike Jack', 'inactive', '2020-08-10'),
	('Web Applications- Python Flask', 'Bob Dillon', 'inactive', '2020-07-20')

INSERT INTO courses (course_name, course_author, course_status) VALUES
    ('Web Applications- Java Spring', 'Mike Jack', 'draft'),
	('Pipeline Orchestration- Python', 'Bob Dillon', 'draft')

INSERT INTO courses (course_name, course_author, course_status, course_published_dt) VALUES
    ('Streaming Pieplines- Python', 'Bob Dillon', 'published', '2020-10-05'),
    ('Web Applications- Scala Play', 'Elvis Presley', 'inactive', '2020-09-30'),
	('Web Applications- Python Django', 'Bob Dillon', 'published', '2020-06-23'),
	('Server Automation- Ansible', 'Uncle Sam', 'published', '2020-07-25')

--Exercise 3: Updating data
UPDATE courses
SET
	course_status = 'published',
	course_published_dt = getdate()
WHERE course_status = 'draft' AND course_name LIKE '%Scala%' OR course_name LIKE '%Python%' ;

--Exercise 4: Deleting Data
DELETE FROM courses where course_status = 'inactive'

--Assignment 3: Queries --
select * from courses
USE retail_db;
SELECT TOP 20 * FROM retail_db.dbo.order_items;

-- Exercise 3.1: Customer order count
SELECT c.customer_id,c.customer_fname, c.customer_lname, COUNT(o.order_id) as [ordercount]
FROM customers c
JOIN orders o on customer_id = order_customer_id
WHERE o.order_date >= '2014-01-01' AND o.order_date < '2014-02-01'
GROUP BY 
c.customer_id,
c.customer_fname,
c.customer_lname
ORDER BY 
ordercount DESC,
c.customer_id ASC;

--Exercise 3.2 Dormant Customers
SELECT c.*
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.order_customer_id
AND o.order_date >= '2014-01-01' AND o.order_date < '2014-02-01'
WHERE o.order_id IS NULL
ORDER BY 
c.customer_id ASC

-- Exercise 3.3 Revenue Per Customer
SELECT c.customer_id, c.customer_fname, c.customer_lname, 
SUM(oi.order_item_quantity * oi.order_item_product_price) as [Revenue Generated]
FROM customers c 
JOIN orders o ON c.customer_id = o.order_customer_id
JOIN order_items oi ON o.order_id = oi.order_item_id
WHERE o.order_date >= '2014-01-01' AND o.order_date < '2014-02-01'
GROUP BY 
c.customer_id, c.customer_fname, c.customer_lname
ORDER BY
[Revenue Generated]

--Exercise 3.4 - rework
SELECT c.*, SUM(oi.order_item_quantity * oi.order_item_product_price) AS category_revenue
FROM categories c
JOIN products p ON c.category_id = p.product_category_id
JOIN order_items oi ON p.product_id = oi.order_item_product_id
JOIN orders o ON oi.order_item_id = o.order_id
WHERE o.order_date >= '2014-01-01' AND o.order_date < '2014-02-01'
AND o.order_status IN ('COMPLETE', 'CLOSED')
GROUP BY
c.category_id,
c.category_name,
c.category_department_id
ORDER BY
c.category_id ASC

-- Exercise 3.5: Product Count per Department
SELECT  d.*, COUNT(p.product_id) as product_count
FROM departments d
LEFT JOIN categories c on d.department_id = c.category_department_id
LEFT JOIN products p on c.category_id = p.product_category_id
GROUP BY 
d.department_id,
d.department_name
ORDER BY 
d.department_id ASC;





-- Assignment 5