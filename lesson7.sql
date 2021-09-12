USE shop;

-- ЗАДАНИЕ 1 Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине

INSERT INTO orders VALUES
(DEFAULT, 2, DEFAULT, DEFAULT),
(DEFAULT, 4, DEFAULT, DEFAULT);


INSERT INTO orders VALUES
(DEFAULT, 1, DEFAULT, DEFAULT),
(DEFAULT, 5, DEFAULT, DEFAULT);

INSERT INTO orders VALUES
(DEFAULT, 4, DEFAULT, DEFAULT);

SELECT * FROM orders;

SELECT u.id, u.name FROM users u 
INNER JOIN orders o ON u.id = o.user_id GROUP BY u.id;

-- ЗАДАНИЕ 2 Выведите список товаров products и разделов catalogs, который соответствует товару.

SELECT p.name AS product_name, c.name AS catalog_name FROM products p 
JOIN catalogs c ON p.catalog_id = c.id;



