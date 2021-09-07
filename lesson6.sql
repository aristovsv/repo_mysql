CREATE DATABASE IF NOT EXISTS vk_full;
USE vk_full;

SHOW tables

SELECT * FROM users 

-- ЗАДАНИЕ 1

SELECT from_user_id, count(*) AS mes_send FROM messages WHERE to_user_id = 1 GROUP BY from_user_id ORDER BY mes_send DESC LIMIT 1;

-- ЗАДАНИЕ 2

SELECT SUM(like_type) AS Likes FROM posts_likes 
	WHERE user_id IN (SELECT id FROM users 
		WHERE id IN (SELECT user_id FROM profiles WHERE (YEAR(NOW())-YEAR(birthday)) < 10));
	
	
-- ЗАДАНИЕ 3



SELECT "F" AS gender, sum(like_type) AS likes_amount FROM posts_likes
	WHERE user_id IN (SELECT id FROM users 
		WHERE id IN (SELECT user_id FROM profiles WHERE gender = 'f'))
		UNION
SELECT "M" AS gender, sum(like_type) AS likes_amount FROM posts_likes
	WHERE user_id IN (SELECT id FROM users 
		WHERE id IN (SELECT user_id FROM profiles WHERE gender = 'm'))
LIMIT 1;

		
		
	








