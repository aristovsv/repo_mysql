-- ЗАДАНИЕ 1.1
/* В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. 
 * Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции */

USE sample;
SHOW tables;
SELECT * FROM users;

INSERT INTO users VALUES (1, 'Ilon', DEFAULT, DEFAULT, DEFAULT);
ALTER TABLE users ADD  
	(birthday_at DATE, 
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

TRUNCATE TABLE users;

START TRANSACTION;

INSERT INTO sample.users (name, birthday_at, created_at, updated_at) 
SELECT name, birthday_at, created_at, updated_at  FROM shop.users WHERE id = 1;

DELETE FROM shop.users WHERE id = 1;

COMMIT;

-- ROLLBACK;

SELECT * FROM users;

-- ЗАДАНИЕ 1.2
/*Создайте представление, которое выводит название name товарной позиции из таблицы products 
 * и соответствующее название каталога name из таблицы catalogs. */

CREATE VIEW v AS 
  SELECT products.name AS prod_name, catalogs.name AS cat_name 
    FROM products,catalogs 
      WHERE products.catalog_id = catalogs.id;
      
SELECT * FROM v;
DROP VIEW v;

-- ЗАДАНИЕ 2.1
/*Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
 * С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", 
 * с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", 
 * с 00:00 до 6:00 — "Доброй ночи". */


DROP FUNCTION IF EXISTS hello;
 
DELIMITER //

CREATE FUNCTION hello()
RETURNS TEXT DETERMINISTIC
BEGIN
    DECLARE t TIMESTAMP; 
    SELECT DATE_FORMAT(NOW(), "%d.%m.%Y") INTO t;
    CASE 
        WHEN t BETWEEN '06:00:00' AND '12:00:00' THEN RETURN "Доброе утро"; 
        WHEN t BETWEEN '12:00:00' AND '18:00:00' THEN RETURN "Добрый день"; 
		WHEN t BETWEEN '18:00:00' AND '00:00:00' THEN RETURN "Добрый вечер"; 
        ELSE RETURN "Доброй ночи";  
    END CASE;
END//

DELIMITER ;

SELECT hello();

-- ЗАДАНИЕ 2.2
/*В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
 *Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL 
 *неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. 
 *При попытке присвоить полям NULL-значение необходимо отменить операцию*/

DELIMITER //

CREATE TRIGGER trigger_chek_befor_insert BEFORE INSERT ON products 
FOR EACH ROW
	BEGIN
  		IF NEW.name IS NULL AND NEW.description IS NULL THEN 
  			SIGNAL SQLSTATE '45001' SET message_text = "products name or description can not be NULL"; 
 		END IF;
	END//

DELIMITER ;

INSERT INTO products (name) VALUES (NULL);

-- SQL Error [1644] [45001]: products name or description can not be NULL

SELECT * FROM products;
