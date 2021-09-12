CREATE DATABASE IF NOT EXISTS vk_full;
USE vk_full;

SHOW tables

SELECT * FROM users 

-- ЗАДАНИЕ 1 Пусть задан некоторый пользователь. 
-- Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).


SELECT u.first_name, COUNT(m.from_user_id) AS mes_send FROM users u 
JOIN messages m ON u.id = m.from_user_id 
	WHERE  to_user_id = 1 GROUP BY from_user_id ORDER BY mes_send DESC LIMIT 1;




-- ЗАДАНИЕ 2 Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.

	

SELECT SUM(pl.like_type) AS Likes FROM posts_likes pl
JOIN users u ON pl.user_id = u.id
JOIN profiles p ON u.id  = p.user_id 
		WHERE (YEAR(NOW()) - YEAR(p.birthday)) < 10;


		
-- ЗАДАНИЕ 3 Определить кто больше поставил лайков (всего): мужчины или женщины.



SELECT 'F' AS gender, SUM(pl.like_type) AS Likes_amount FROM posts_likes pl
JOIN users u ON pl.user_id = u.id
JOIN profiles p ON u.id = p.user_id 
WHERE gender = 'f'
UNION 		
SELECT 'M' AS gender, SUM(pl.like_type) AS Likes_amount FROM posts_likes pl
JOIN users u ON pl.user_id = u.id
JOIN profiles p ON u.id = p.user_id 
WHERE gender = 'm'
LIMIT 1;







