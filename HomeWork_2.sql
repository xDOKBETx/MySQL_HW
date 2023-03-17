-- 1. Создать БД vk, исполнив скрипт _vk_db_creation.sql (в материалах к уроку)

-- Запускаю скрипт _vk_db_creation.sql, проверяю, была ли создана БД vk:
SHOW DATABASES;
USE vk;
SHOW FULL TABLES;

-- 2. Написать скрипт, добавляющий в созданную БД vk 2-3 новые таблицы 
--    (с перечнем полей, указанием индексов и внешних ключей) (CREATE TABLE)

-- Подключаюсь к базе данных vk
USE vk;

-- Создаю таблицу публикаций
DROP TABLE IF EXISTS publication;
CREATE TABLE publication (
    id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Создаю таблицу комментариев к публикациям
DROP TABLE IF EXISTS comments;
CREATE TABLE comments (
    id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    publication_id BIGINT UNSIGNED NOT NULL,
    body TEXT,
    created_at DATETIME DEFAULT NOW(),
    
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (publication_id) REFERENCES publication(id)
);

-- Создаю таблицу лайков к публикациям
DROP TABLE IF EXISTS publicationt_likes;
CREATE TABLE publication_likes (
    id SERIAL,
    user_id BIGINT UNSIGNED NOT NULL,
    publication_id BIGINT UNSIGNED NOT NULL,
    created_at DATETIME DEFAULT NOW(),
    
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (publication_id) REFERENCES publication(id)
);

-- 	3. Заполнить 2 таблицы БД vk данными (по 10 записей в каждой таблице) (INSERT)

-- Подключаюсь к базе данных vk
USE vk;

-- Заполняю таблицу users данными
INSERT INTO users (firstname, lastname, email, password_hash, phone)
VALUES ('Ксения ', 'Соловьева', 'er@gmail.com', 'DjCwExCXzKZnhevR', '89213713615'),
	   ('Макар', ' Кузин', 'o0my@gmail.com', 'guhcKNVxRGAdGhT5', '89211526626'),
	   ('Максим', ' Герасимов', '715qy08@gmail.com', 'IKYTkVi2cZihrzO8', '89213219197'),
	   ('Назар', ' Иванов', 'vubx0t@mail.ru', 'WJs34unPbvki1hSV', '89218902738'),
	   ('Дарья', ' Титова', 'wnhborq@outlook.com', 'xs1Rq0ng7MaDuNm0', '89210936090'),
	   ('Анна', ' Пирогова', 'gq@yandex.ru', 'bI3znYdEaDsVrxpB', '89215281557'),
	   ('Платон', ' Кузнецов', 'ic0pu@outlook.com', 'HwHwyXoCM8g96rvv', '89217889861'),
	   ('Роман ', 'Волков', 'o7khr@yandex.ru', 'uUOpZwQlYFvNPWVr', '89215283563'),
	   ('Артём ', 'Ширяев', '2shlaq@outlook.com', 'KDt4c5pld25YFxto', '89215726728'),
	   ('Артём ', 'Иванов', 'cdbw@yandex.ru', '7KxmvCvnkRxOGD4u', '89215741310');

-- Просматриваю новые записи таблицы users, изберательно первые шесть строк 
SELECT firstname, lastname, email, password_hash, phone
  FROM users
 WHERE id < 6;

-- Заполняю таблицу publication данными
INSERT INTO publication (user_id, body)
VALUES (1, 'Супер супер утро рассказало супер связи'), 
       (2, 'Девочка учиться просто так'), 
	   (3, 'Все боги существуют'),
       (4, 'Официальное название: утопление'),
	   (5, '- А я пикирующий опоссум'),
       (6, 'Мимо шёл сопливый бородавочник, явно не в духе'),
       (7, 'И спустя 3 прослушивания все же получила роль'),
       (8, 'Мне отказали, а потом они перенесли кастинг в Нью-Йорк'),
       (9, 'Мой брат учиться просто так'),
       (10, 'Комнатных животных заводят люди самых разных возрастов и профессий');       
       
-- Просматриваю таблицу publication 
SELECT user_id, body
  FROM publication;
    
  /* 	4.* Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных 
		(поле is_active = true). При необходимости предварительно добавить такое поле 
        в таблицу profiles со значением по умолчанию = false (или 0) (ALTER TABLE + UPDATE)
*/

-- Подключаюсь к базе данных vk
USE vk;

-- Добавляю столбец is_active в таблицу profiles
ALTER TABLE profiles
 ADD COLUMN is_active BOOLEAN NOT NULL DEFAULT false;
 
-- Отключаю на время сеанса режим безопасных обновлений 
SET SQL_SAFE_UPDATES = 0;

-- Обновляю поле is_active таблицы profiles
UPDATE profiles
   SET is_active = true
WHERE TIMESTAMPDIFF(YEAR, birthday, CURDATE()) < 18;

-- 	5.* Написать скрипт, удаляющий сообщения «из будущего» (дата позже сегодняшней) (DELETE)

-- Подключаюсь к базе данных vk
USE vk;

-- Обновляю поле created_at (увеличиваю настоящюю дату на один день) для user_id = 10
UPDATE comments
   SET created_at = DATE_ADD(created_at, INTERVAL 1 DAY)
   WHERE user_id = 10;

-- Удаляю cообщение старше настоящего времени
DELETE FROM comments
 WHERE created_at > CURRENT_TIMESTAMP();  