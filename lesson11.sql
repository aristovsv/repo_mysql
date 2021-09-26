
-- ЗАДАНИЕ 1
/* Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
 * catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы, 
 идентификатор первичного ключа и содержимое поля name.*/


USE shop;

CREATE TABLE logs (
  table_name VARCHAR(20) NOT NULL,
  pk_id INT UNSIGNED NOT NULL,
  name VARCHAR(255),
  created_at DATETIME DEFAULT NOW()
) ENGINE=ARCHIVE;

CREATE TRIGGER users_log AFTER INSERT ON users FOR EACH ROW
  INSERT INTO logs 
    SET 
      table_name = 'users',
      pk_id = NEW.id,
      name = NEW.name;

CREATE TRIGGER catalogs_log AFTER INSERT ON catalogs FOR EACH ROW
  INSERT INTO logs 
    SET 
      table_name = 'catalogs',
      pk_id = NEW.id,
      name = NEW.name;

CREATE TRIGGER products_log AFTER INSERT ON products FOR EACH ROW
  INSERT INTO logs 
    SET 
      table_name = 'products',
      pk_id = NEW.id,
      name = NEW.name;
      
INSERT INTO users VALUES (DEFAULT, 'Ilon', DEFAULT, DEFAULT, DEFAULT);
INSERT INTO catalogs VALUES (DEFAULT, 'new_item');
INSERT INTO products VALUES (DEFAULT, 'new', 'smt new', 123, 6, DEFAULT,DEFAULT);
SELECT * FROM users;
SELECT * FROM catalogs;
SELECT * FROM products;
SELECT * FROM logs;