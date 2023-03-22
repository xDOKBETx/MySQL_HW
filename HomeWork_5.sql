USE vk;


-- 1. Создайте представление с произвольным SELECT-запросом из прошлых уроков [CREATE VIEW]

CREATE VIEW copy_users AS
    SELECT id, firstname, lastname
    FROM vk.users
    JOIN profiles ON (
    users.id = profiles.user_id
   ) 
    WHERE gender = 'f'
    ORDER BY id;
    

--   2. Выведите данные, используя написанное представление [SELECT]

SELECT id, firstname, lastname
    FROM copy_users;
    

--   3. Удалите представление [DROP VIEW]

   
DROP VIEW copy_users;

/* 
4. * Сколько новостей (записей в таблице media) у каждого пользователя? 
Вывести поля: news_count (количество новостей), user_id (номер пользователя), 
user_email (email пользователя). Попробовать решить с помощью СТЕ или с помощью обычного JOIN.
*/

-- Через CTE
WITH cte AS (
     SELECT 
          COUNT(*) as news_count, 
          user_id
     FROM media 
     GROUP BY user_id 
)
SELECT 
     news_count, 
     user_id , 
     email 
FROM cte
JOIN users ON users.id  = cte.user_id;

-- Через JOIN
SELECT
     COUNT(*) as news_count,
     user_id,
     email 
FROM media
JOIN users ON users.id = media.user_id 
GROUP BY user_id;
