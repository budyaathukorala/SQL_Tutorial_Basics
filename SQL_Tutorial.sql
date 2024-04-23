USE sql_store;

-- SELECT CLAUSE --

SELECT 
    name, 
    unit_price, 
    unit_price*1.1 AS 'new price'
FROM products;

-- WHERE CLAUSE --

SELECT*
FROM orders
where order_date >= '2019-01-01';

-- AND,OR,NOT OPERATORS --

SELECT order_id,product_id,quantity,unit_price,quantity*unit_price AS 'total_price'
FROM order_items
WHERE order_id = 6 AND quantity*unit_price > 30;

-- IN Operator --

SELECT * 
FROM products
WHERE quantity_in_stock IN (49,38,72);

SELECT * 
FROM products
WHERE quantity_in_stock NOT IN (49,38,72);

-- Between Operators -- (to get a range of information)

SELECT*
FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';  -- (Given values are also included to the range)

-- LIKE Operator -- (extract rows using string patterns)

-- % describe all the characters
-- _ describe single character

SELECT*
FROM customers
WHERE address LIKE '%trail%' OR 
	  address LIKE '%avenue%';

SELECT*
FROM customers
WHERE phone LIKE '___________9';

-- IS NULL OPERATOR --

SELECT*
from orders
WHERE shipped_date IS NULL;

SELECT*
from orders
WHERE shipped_date IS NOT NULL;

-- ORDER BY CLAUSE -- (USED TO SORT DATA)

-- ORDER BY by default it gives sorted data in ASC order --

SELECT order_id, product_id, quantity, unit_price, quantity*unit_price AS total_price
FROM order_items
WHERE order_id = 2
ORDER BY quantity*unit_price DESC;

-- LIMIT OPERATOR -- (Limit the number of record returned from the query)

-- Get top 3 loyal customers --
SELECT*
FROM customers
ORDER BY points DESC
LIMIT 3;

SELECT*
FROM customers
WHERE points
LIMIT 6,3; -- (skip first 6 records and get next 3 records) --

-- INNER JOIN -- (Select columns from multiple tables)

SELECT order_id,o.product_id,quantity,o.unit_price,name
FROM order_items o
JOIN products p ON o.product_id = p.product_id;

-- JOINING ACROSS -- (joining tables in multiple databases)

-- SELF JOIN -- (join table with itself)

-- JOINING MULTIPLE TABLES -- (Joining more than two tables)

USE sql_invoicing;

SELECT p.payment_id,p.client_id,c.name,pm.name
FROM payments p
JOIN clients c 
          ON p.client_id = c.client_id
JOIN payment_methods pm
          ON p.payment_method = pm.payment_method_id;
          
-- OUTER JOIN --

-- left join gives all the records of left table whether the condition true or not
-- right join gives all the records of right table whether the condition true or not

USE sql_store;

SELECT p.product_id,p.name,oi.quantity
FROM products p
LEFT JOIN order_items oi ON p.product_id = oi.product_id;

-- USING clause -- 

USE sql_invoicing;

SELECT
   p.data,
   c.name AS client,
   p.amount,
   pm.name AS payment_method
FROM payments p
JOIN clients c USING (client_id)
JOIN payment_methods pm
         ON p.payment_method = pm.payment_method_id;

-- CROSS JOIN -- (Combine every record of the first table with every record of the second table)

USE sql_store;

SELECT
   c.first_name AS customer,
   p.name AS product
FROM customers c
CROSS JOIN products p
ORDER BY c.first_name;

-- UNIONS -- (combine rows of multiple tables)

SELECT customer_id,first_name,points,'BRONZ' AS type
FROM customers
WHERE points < 2000
UNION
SELECT customer_id,first_name,points,'SILVER' AS type
FROM customers
WHERE points BETWEEN 2000 AND 3000
UNION
SELECT customer_id,first_name,points,'GOLD' AS type
FROM customers
WHERE points > 3000;

-- Inserting a Single row --

INSERT INTO customers
values()