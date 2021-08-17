create database example;
use example

create table users (id SERIAL, name varchar(100) not null);

show tables

create database sample;
use sample

show tables


-- ÊÎÌÀÍÄÛ ÈÇ ÊÎÍÑÎËÈ

-- C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump -u root -p
-- Usage: mysqldump [OPTIONS] database [tables]
-- OR     mysqldump [OPTIONS] --databases [OPTIONS] DB1 [DB2 DB3...]
-- OR     mysqldump [OPTIONS] --all-databases [OPTIONS]
-- For more options, use mysqldump --help

-- C:\Program Files\MySQL\MySQL Server 8.0\bin>mysqldump -u root -p example > C:\GB\MySQL_dump\example_170821.sql
-- Enter password: *********

-- C:\Program Files\MySQL\MySQL Server 8.0\bin>mysql -u root -p sample <C:\GB\MySQL_dump\example_170821.sql
-- Enter password: *********

-- C:\Program Files\MySQL\MySQL Server 8.0\bin>

