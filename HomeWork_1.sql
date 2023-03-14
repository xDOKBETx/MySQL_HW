-- Базы данных и SQL, семинар 1, практическое задание:
-- 1. Создайте таблицу с мобильными телефонами, используя графический интерфейс. 
-- Необходимые поля таблицы: product_name (название товара), manufacturer (производитель), 
-- product_count (количество), price (цена). Заполните БД произвольными данными.
-- 2. Напишите SELECT-запрос, который выводит название товара, производителя и цену для товаров, количество которых превышает 2
-- 3. Выведите SELECT-запросом весь ассортимент товаров марки “Samsung”
-- 4.* С помощью SELECT-запроса с оператором LIKE / REGEXP найти:
-- 4.1.* Товары, в которых есть упоминание "Iphone"
-- 4.2.* Товары, в которых есть упоминание "Samsung"
-- 4.3.* Товары, в названии которых есть ЦИФРЫ
-- 4.4.* Товары, в названии которых есть ЦИФРА "8"

USE HomeWork_1;

CREATE TABLE mobile_phone
( 
    phone_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    manufacturer VARCHAR(30),
    product_count INTEGER,
    price DECIMAL
);

INSERT INTO mobile_phone
	(product_name, manufacturer, product_count, price)
VALUES
    ('Galaxy S23', 'Samsung', 8, 79999),
    ('50', 'Honor', 1, 26999),
    ('iPhone 13', 'Apple', 3, 64399),
    ('Redmi A1+', 'Xiaomi', 1, 4999),
    ('iPhone 14 Pro', 'Apple', 5, 125999),
    ('Redmi Note 10 Pro','Xiaomi', 4, 23999),
    ('Mate 50', 'HUAWEI', 7, 49999),
    ('nova 10', 'HUAWEI', 0, 31999),
    ('Galaxy S21', 'Samsung', 1, 65599),
    ('Master Edition', 'GT', 1, 25999);


-- SELECT-запрос, который выводит название товара, 
-- производителя и цену для товаров, количество которых превышает 2

SELECT 
    product_name as 'Название товара',
    manufacturer as 'Производитель',
    price as 'Цена'
FROM mobile_phone
WHERE product_count >2;


-- Выводим SELECT-запросом весь ассортимент товаров марки “Samsung”

SELECT * FROM mobile_phone
WHERE manufacturer = 'Samsung';

-- С помощью SELECT-запроса с оператором LIKE / REGEXP найти товары, в которых есть упоминание "Iphone"

SELECT * FROM mobile_phone
WHERE product_name LIKE 'iPhone%';


-- С помощью SELECT-запроса с оператором LIKE / REGEXP найти товары, в которых есть упоминание "Samsung"

SELECT * FROM mobile_phone
WHERE manufacturer LIKE 'Samsung';


-- С помощью SELECT-запроса с оператором LIKE / REGEXP найти товары, в названии которых есть ЦИФРЫ

SELECT * FROM mobile_phone
WHERE product_name REGEXP '[[:digit:]]';


-- С помощью SELECT-запроса с оператором LIKE / REGEXP найти товары, в названии которых есть ЦИФРА "8"

SELECT * FROM mobile_phone
WHERE product_name REGEXP '[8]';