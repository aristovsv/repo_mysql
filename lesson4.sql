CREATE DATABASE IF NOT EXISTS vk;
USE vk;

CREATE TABLE users(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(150) NOT NULL,
	last_name VARCHAR(150) NOT NULL,
	email VARCHAR(150) NOT NULL UNIQUE,
	phone CHAR(11) NOT NULL,
	password_hash CHAR(65) DEFAULT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	INDEX (phone),
	INDEX (email)
);

DESC users 

CREATE TABLE profiles(
	user_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	gender ENUM('f', 'm', 'x') NOT NULL,
	birthday DATE NOT NULL,
	photo_id BIGINT UNSIGNED,
	city VARCHAR(130),
	country VARCHAR(130),
	FOREIGN KEY(user_id) REFERENCES users(id) 
);

CREATE TABLE messages(
	id SERIAL PRIMARY KEY, 
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	txt TEXT NOT NULL,
	is_delivered BOOLEAN DEFAULT FALSE,
	created_at DATETIME NOT NULL DEFAULT NOW(),
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	INDEX messages_from_user_id_idx (from_user_id),
	INDEX messages_to_user_id_idx (to_user_id),
	CONSTRAINT fk_messages_from_user_id FOREIGN KEY (from_user_id) REFERENCES users(id),
	CONSTRAINT fk_messages_to_user_id FOREIGN KEY (to_user_id) REFERENCES users(id) 
);

CREATE TABLE friend_requests(
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	accepted BOOLEAN DEFAULT FALSE,
	PRIMARY KEY (from_user_id, to_user_id),
	KEY (from_user_id),
	KEY (to_user_id),
	FOREIGN KEY (from_user_id) REFERENCES users(id),
	FOREIGN KEY (to_user_id) REFERENCES users(id)
);

CREATE TABLE communities(
	id SERIAL PRIMARY KEY,
	name VARCHAR(150) NOT NULL,
	description VARCHAR (255),
	admin_id BIGINT UNSIGNED NOT NULL,
	KEY(admin_id), 
	FOREIGN KEY (admin_id) REFERENCES users(id)
);

CREATE TABLE communities_users(
	community_id BIGINT UNSIGNED NOT NULL,
	user_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(community_id, user_id),
	KEY (community_id),
	KEY (user_id),
	FOREIGN KEY (community_id) REFERENCES communities(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE media_types(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE media(
	id SERIAL PRIMARY KEY,
	user_id BIGINT UNSIGNED NOT NULL,
	media_types_id INT UNSIGNED NOT NULL,
	file_name VARCHAR(255),
	file_size BIGINT UNSIGNED,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	KEY (media_types_id),
	KEY (user_id),
	FOREIGN KEY (media_types_id) REFERENCES media_types(id),
	FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE communities_requests(
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_communities_id BIGINT UNSIGNED NOT NULL,
	accepted BOOLEAN DEFAULT FALSE,
	PRIMARY KEY (from_user_id, to_communities_id),
	KEY (from_user_id),
	KEY (to_communities_id),
	FOREIGN KEY (from_user_id) REFERENCES users(id),
	FOREIGN KEY (to_communities_id) REFERENCES communities(id)
);

CREATE TABLE comment_media(
	from_user_id BIGINT UNSIGNED NOT NULL,
	media_id BIGINT UNSIGNED NOT NULL,
	text TEXT NOT NULL,
	comment_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (from_user_id, media_id),
	KEY (from_user_id),
	KEY (media_id),
	FOREIGN KEY (media_id) REFERENCES media(id),
	FOREIGN KEY (from_user_id) REFERENCES users(id)
);

CREATE TABLE share_media(
	from_user_id BIGINT UNSIGNED NOT NULL,
	to_user_id BIGINT UNSIGNED NOT NULL,
	share_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (from_user_id, to_user_id),
	KEY (from_user_id),
	KEY (to_user_id),
	FOREIGN KEY (from_user_id) REFERENCES users(id),
	FOREIGN KEY (to_user_id) REFERENCES users(id)
);


-- ЗАДАНИЕ 1

SHOW CREATE TABLE users;

INSERT INTO users VALUES (DEFAULT,'Anton', 'Ivanov', 'antonivanov@mail.com', '78965258411', DEFAULT, DEFAULT);
INSERT INTO users VALUES (DEFAULT, 'Mariya', 'Terentieva', 'mariyaterentieva@gmail.com', '89215478695',DEFAULT, DEFAULT),
(DEFAULT, 'Yana', 'Balashova', 'yanabalashova@mail.com', '89115687422', DEFAULT, DEFAULT),
(DEFAULT, 'Olga', 'Ovsanikova', 'olgaovsyanikova@mail.com', '89115887441', 'uijynhgbvfgd5jod8hbd4mcn4je', DEFAULT),
(DEFAULT, 'Luba', 'Borodina', 'lubaborodina@gmail.com', '89215548963', DEFAULT, DEFAULT),
(DEFAULT, 'Kseniya', 'Edrikova', 'kseniyaedrikova@mail.com', '89211022148', DEFAULT, DEFAULT),
(DEFAULT, 'Oksana', 'Maiorkina', 'oksanamaiorkina@gmail.com', '89055569201', 'hhfy67dnvhgkoud8jgnd2k4', DEFAULT),
(DEFAULT, 'Tanya', 'Sergeeva', 'tanyasergeeva@mail.com', '89218574410', DEFAULT, DEFAULT),
(DEFAULT, 'Sveta', 'Ponkratenko', 'svetaponkratenko@mail.com', '89068802451', 'lkvn8djfhfy47dbkjgoet5e', DEFAULT),
(DEFAULT, 'Lena', 'Sedova', 'lenasedova@mail.com', '89110015541', 'kkfjgu88ujdbvpomfsmddvd', DEFAULT),
(DEFAULT, 'Mariya', 'Kirshina', 'mariyakirshina@gmail.com', '89115147002', DEFAULT, DEFAULT),
(DEFAULT, 'Alekseiy', 'Shafranskiy', 'alekseiyshafranskiy@gmail.com', '89055144103', 'jjfhu25dsvxvcblbpyubc', DEFAULT),
(DEFAULT, 'Marina', 'Korshunova', 'marinakorshunova@mail.com', '89312201547', DEFAULT, DEFAULT),
(DEFAULT, 'Nadya', 'Vladimirova', 'nadyavladimirova@gmail.com', '89318744590', DEFAULT, DEFAULT),
(DEFAULT, 'Lena', 'Varnashova', 'lenavarnashova@mail.com', '89112665023', 'pjfbvhyfsdz43gf8667cxs', DEFAULT),
(DEFAULT, 'Lena', 'Yashkova', 'lenayashkova@gmail.com', '89218874035', 'lfhvxds43gr76jbo988wcnv', DEFAULT);

INSERT INTO users VALUES  (DEFAULT, 'Igor', 'Mezencev', 'igormezencev@mail.com', '89115410236', DEFAULT, DEFAULT),
(DEFAULT, 'Ruslan', 'Verhov', 'ruslanverhov@gmail.com', '89056639412', DEFAULT, DEFAULT);

SELECT * FROM users;

INSERT profiles VALUES (1,'m','1992-01-21', 1, 'Saint-Petersburg', 'Russia');

SELECT * FROM users;

INSERT profiles VALUES (2,'f','1981-11-16', 2, 'Saint-Petersburg', 'Russia'),
(3,'f','1986-02-26', 3, 'Omsk', 'Russia'),
(4,'f','1999-05-02', 4, 'Kiev', 'Ukrain'),
(5,'f','1996-12-01', 5, 'Tula', 'Russia'),
(6,'f','1995-04-11', 6, 'Saint-Petersburg', 'Russia'),
(7,'f','2000-05-23', 7, 'Moscow', 'Russia'),
(8,'f','1988-03-12', 8, 'Vologda', 'Russia'),
(9,'f','1976-06-15', 9, 'Grodno', 'Belorussia'),
(10,'f','1996-03-21', 10, 'Moscow', 'Russia'),
(11,'f','1989-05-09', 11, 'Minsk', 'Belorussia'),
(12,'m','1986-09-13', 12, 'Saint-Petersburg', 'Russia'),
(13,'f','1981-06-25', 13, 'Moscow', 'Russia'),
(14,'f','2001-08-14', 14, 'Saint-Petersburg', 'Russia'),
(15,'f','1987-04-22', 15, 'Gdansk', 'Poland'),
(16,'f','1988-11-08', 16, 'Saint-Petersburg', 'Russia'),
(17,'m','1984-11-28', 17, 'Saint-Petersburg', 'Russia'),
(18,'m','1993-10-05', 18, 'Moscow', 'Russia');

SELECT * FROM messages;
SHOW CREATE TABLE messages;
SELECT * FROM users;

INSERT INTO messages VALUES (DEFAULT, 3, 9, 'привет, как дела?', 1, DEFAULT, DEFAULT);
INSERT INTO messages VALUES (DEFAULT, 9, 3, 'привет, все отлично, только вернулась', 1, DEFAULT, DEFAULT),
(DEFAULT, 3, 9, 'фильм понравился?', 1, DEFAULT, DEFAULT),
(DEFAULT, 5, 16, 'встречаемся в метро', 1, DEFAULT, DEFAULT),
(DEFAULT, 16, 5, 'ок, на выходе с эскалатора', 1, DEFAULT, DEFAULT),
(DEFAULT, 17, 13, 'от тебя ничего не пришло', 0, DEFAULT, DEFAULT),
(DEFAULT, 10, 6, 'Ксю, привет, все отлично', 1, DEFAULT, DEFAULT),
(DEFAULT, 6, 10, 'я очень рада)))', 1, DEFAULT, DEFAULT),
(DEFAULT, 1, 7, 'с прошедшим тебя', 0, DEFAULT, DEFAULT),
(DEFAULT, 2, 14, 'буду около 18', 1, DEFAULT, DEFAULT);

INSERT INTO friend_requests VALUES (3, 9, 1),
(9, 3, 1),
(5, 16, 1),
(16, 5, 1),
(17, 13, 1),
(13, 17, 1),
(10, 6, 1),
(6, 10, 1),
(1, 7, 1),
(7, 1, 1),
(2, 14, 1),
(14, 2, 1),
(12, 13, 0);

INSERT INTO communities VALUES (DEFAULT, 'Город', 'Все про города', 2),
(DEFAULT, 'Приколы', 'Смешные картинки', 4),
(DEFAULT, 'СПБГУ', 'все про наш универ', 2),
(DEFAULT, 'Бары и рестораны', 'ночная жизнь города', 7),
(DEFAULT, 'Лучшие книги', 'обзор литературных новинок', 9),
(DEFAULT, 'Кинотеатры', 'расписание фильмов', 9),
(DEFAULT, 'Авто', 'Все про машины', 14),
(DEFAULT, 'Велогород', 'последние новости велосипедизации', 11),
(DEFAULT, 'Шиномонтаж', 'быстро и не дорого', 14),
(DEFAULT, 'Кухни на заказ', 'кухни от самых известных брендов', 18);

INSERT INTO communities_users VALUES (1, 16, DEFAULT), (1, 13, DEFAULT), (1, 10, DEFAULT), 
(2, 1, DEFAULT), (2, 13, DEFAULT), (2, 17, DEFAULT), (2, 10, DEFAULT),
(3, 1, DEFAULT), (3, 8, DEFAULT),
(4, 5, DEFAULT), (4, 9, DEFAULT), (4, 12, DEFAULT),
(6, 17, DEFAULT), (6, 8, DEFAULT),(6, 1, DEFAULT),
(7, 12, DEFAULT), (7, 3, DEFAULT), (7, 4, DEFAULT), (7, 18, DEFAULT),
(8, 1, DEFAULT), (8, 16, DEFAULT),
(9, 11, DEFAULT),
(10, 6, DEFAULT), (10, 12, DEFAULT), (10, 7, DEFAULT);

INSERT INTO media_types VALUES (DEFAULT, 'изображение');
INSERT INTO media_types VALUES (DEFAULT, 'музыка');
INSERT INTO media_types VALUES (DEFAULT, 'документ');

TRUNCATE TABLE media_types;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE media_types;
SET FOREIGN_KEY_CHECKS = 1;

INSERT INTO media_types VALUES (DEFAULT, 'изображение'), (DEFAULT, 'музыка'), (DEFAULT, 'документ');

INSERT INTO media VALUES (DEFAULT, 1, 1, 'first.jpg', 100, DEFAULT),
(DEFAULT, 12, 1, 'photo.jpg', 1024, DEFAULT),
(DEFAULT, 3, 3, 'presentation.pdf', 1524, DEFAULT),
(DEFAULT, 3, 1, 'car.jpg', 962, DEFAULT),
(DEFAULT, 15, 2, 'album.mp3', 1257, DEFAULT),
(DEFAULT, 7, 2, 'song.mp3', 154, DEFAULT),
(DEFAULT, 8, 1, 'tv.jpg', 1654, DEFAULT),
(DEFAULT, 9, 1, 'spb.jpg', 45100, DEFAULT),
(DEFAULT, 13, 1, 'msk.jpg', 8857, DEFAULT),
(DEFAULT, 2, 1, 'train.jpg', 5487, DEFAULT),
(DEFAULT, 18, 1, 'iq.jpg', 451, DEFAULT);

SELECT * FROM media;

INSERT INTO comment_media VALUES (1, 2, 'отличная фотка', DEFAULT),
(16, 2, 'это где?', DEFAULT),
(14, 2, 'а мне не очень', DEFAULT),
(6, 6, 'последний альбом хороший', DEFAULT),
(13, 6, 'звук не очень', DEFAULT),
(12, 8, 'Питер лучший город', DEFAULT),
(9, 8, 'только ветренный', DEFAULT),
(7, 3, 'отличный материал', DEFAULT),
(8, 3, 'скинь мне плиз', DEFAULT),
(14, 11, 'сильный результат', DEFAULT);

INSERT INTO communities_requests VALUES (16, 1, 1), (13, 1, 1), (10, 1, 1), (6, 1, 0),
(1, 2 , 1), (13, 2, 1), (17, 2, 1), (10, 2, 1),
(1, 3, 1), (8, 3, 1),
(5, 4, 1), (9, 4, 1), (12, 4, 1),
(6, 5, 0), (12, 5 ,0),
(17, 6, 1), (8, 6, 1), (1, 6, 1),
(12, 7, 1), (3, 7, 1), (4, 7, 1), (18, 7, 1),
(1, 8, 1), (16, 8, 1),
(11, 9, 1),
(6, 10, 1), (12, 10, 1), (7, 10, 1);

INSERT INTO share_media VALUES (1, 3, DEFAULT), (1, 4, DEFAULT),
(9, 6, DEFAULT), (9, 10, DEFAULT), (9, 11, DEFAULT),
(12, 16, DEFAULT), (12, 13, DEFAULT),
(7, 6, DEFAULT), (7, 2, DEFAULT), (7, 12, DEFAULT);


-- ЗАДАНИЕ 2

SELECT DISTINCT first_name FROM users ORDER BY first_name ASC;


-- ЗАДАНИЕ 3

ALTER TABLE profiles ADD COLUMN is_active TINYINT(1) DEFAULT '1';
SELECT * FROM profiles;

INSERT INTO users VALUES (DEFAULT,'Irina', 'Sevchenko', 'irinashevchenko@mail.com', '79115863320', DEFAULT, DEFAULT);
SELECT * FROM users;

INSERT profiles VALUES (19,'f','2010-12-18', 19, 'Saint-Petersburg', 'Russia', DEFAULT);
SELECT * FROM profiles;

UPDATE profiles
SET is_active = 0
WHERE (YEAR(CURRENT_DATE) - YEAR(birthday)) < 18;
SELECT * FROM profiles;


-- ЗАДАНИЕ 4

DELETE FROM messages
WHERE created_at < CURRENT_TIMESTAMP();
