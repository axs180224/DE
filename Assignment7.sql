use retail_db
--Exercise 1: Simple subquery

SELECT category_name FROM categories c
WHERE c.category_id IN
(SELECT product_category_id  FROM products
GROUP BY product_category_id
HAVING COUNT(1) > 5
);

select * from customers

--Exercise 2: Subquery in WHERE 
SELECT o.* FROM orders o WHERE o.order_customer_id IN
(SELECT customer_id FROM customers c
GROUP BY c.customer_id HAVING COUNT(1) > 10)

--Exercise 3: Subquery in SELECT CLAUSE

--Exercise 5: Basic

SELECT product_category_id, 
FROM products


SELECT COUNT(user_gender)
FROM users
WHERE user_gender = 'M'

SELECT COUNT(*) user_gender
FROM users
WHERE user_gender IS NULL