use retail_db
select top 10 * from orders
--Exercise 1
CREATE TABLE orders_part (
	order_id INT IDENTITY PRIMARY KEY,
	order_date DATE DEFAULT GETDATE(),
	order_customer_id INT,
	order_status VARCHAR(15)
);

SELECT DATA_TYPE FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'orders' AND COLUMN_NAME = 'order_status';

