1. Написать функцию, которая удаляет всю информацию об указанном пользователе из БД vk. 
   Пользователь задается по id. Удалить нужно все сообщения, лайки, медиа записи, 
   профиль и запись из таблицы users. Функция должна возвращать номер пользователя. */
   
      
DROP FUNCTION IF EXISTS delete_user;
DELIMITER $$

CREATE FUNCTION delete_user(id_delete INT) RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE id_deleted INT;    
    DELETE FROM messages WHERE from_user_id = id_delete OR to_user_id = id_delete;
    DELETE FROM likes user_id WHERE user_id = id_delete;
    DELETE FROM media user_id WHERE user_id = id_delete;
    DELETE FROM profiles user_id WHERE user_id = id_delete;
    DELETE FROM users id WHERE id = id_delete;
    RETURN id_delete;
END$$

DELIMITER ;      
/* Вызов функции: */
SELECT delete_user(10);
   
/*  2. Предыдущую задачу решить с помощью процедуры и обернуть используемые команды в транзакцию внутри процедуры. */
DROP PROCEDURE IF EXISTS delete_user;
SET SQL_SAFE_UPDATES = 0;
DELIMITER $$

CREATE PROCEDURE delete_user(id_delete INT)
BEGIN
    DECLARE num_deleted INT;
    DECLARE rollbacked INT DEFAULT 0;

    START TRANSACTION;

    DELETE FROM messages WHERE from_user_id = id_delete OR to_user_id = id_delete;
    DELETE FROM likes WHERE user_id = id_delete;
    DELETE FROM media WHERE user_id = id_delete;
    DELETE FROM profiles WHERE user_id = id_delete;
    DELETE FROM users WHERE id = id_delete;  
    
    SET num_deleted = ROW_COUNT();
      IF num_deleted = 0 THEN
         ROLLBACK;
         SET rollbacked = 1;
         SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Пользователя с таким id в базе нет';
    END IF;
       IF rollbacked = 0 THEN
	COMMIT;
       END IF;
END$$

DELIMITER ;
/* Вызов процедуры: */
CALL delete_user(13);


/* *3. Написать триггер, который проверяет новое появляющееся сообщество. 
       Длина названия сообщества (поле name) должна быть не менее 5 символов. 
       Если требование не выполнено, то выбрасывать исключение с пояснением. */
       
DROP TRIGGER IF EXISTS checking_new_community;
DELIMITER $$

CREATE TRIGGER checking_new_community
BEFORE INSERT ON communities
FOR EACH ROW
BEGIN
  IF CHAR_LENGTH(NEW.name) < 5 THEN
    SIGNAL SQLSTATE "45000"
    SET MESSAGE_TEXT = "Название сообщества должно содержать не менее 5 символов";
  END IF;
END$$

DELIMITER ;

/* Проверка триггера: */
INSERT INTO communities (name) VALUES ("nem");
SELECT * FROM communities;
