CREATE DATABASE TZ_21_07_2025;
GO

USE TZ_21_07_2025;
GO

CREATE TABLE users(
	id						INT IDENTITY(1,1) PRIMARY KEY,
	login					NVARCHAR(50) NOT NULL UNIQUE,
	password				NVARCHAR(100) CHECK (LEN(Password) >= 8),
	name					NVARCHAR(100) NOT NULL,
	surname					NVARCHAR(100),
	patronymic				NVARCHAR(100),
	mail					NVARCHAR(255) NOT NULL UNIQUE,
	phone_number			NVARCHAR(20),
	registration_date		DATETIME DEFAULT DATEADD(HOUR, 3, GETUTCDATE())
);

CREATE TABLE products(
	id						INT IDENTITY(1,1) PRIMARY KEY,
	name					NVARCHAR(200) NOT NULL,
	description				NVARCHAR(1000) NOT NULL,
	price					DECIMAL(18,2) NOT NULL CHECK (price > 0),
	date_added				DATETIME DEFAULT DATEADD(HOUR, 3, GETUTCDATE())
);

CREATE TABLE warehouses(
	id						INT IDENTITY(1,1) PRIMARY KEY,
	name					NVARCHAR(200) NOT NULL,
	description				NVARCHAR(1000) NOT NULL,
	address					NVARCHAR(500)
);

CREATE TABLE warehouse_products(
	warehouse_id			INT NOT NULL,
	product_id				INT NOT NULL,
	quantity				INT NOT NULL CHECK (quantity >= 0)
	PRIMARY KEY (product_id, warehouse_id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (warehouse_id) REFERENCES warehouses(id) ON DELETE CASCADE
);

CREATE TABLE categories (
    id						INT IDENTITY(1,1) PRIMARY KEY,
    name					NVARCHAR(200) NOT NULL UNIQUE,
	description				NVARCHAR(1000) NOT NULL
);

CREATE TABLE product_categories (
    product_id				INT NOT NULL,
    category_id				INT NOT NULL,
    PRIMARY KEY (product_id, category_id),
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES categories(id) ON DELETE CASCADE
);

CREATE TABLE status_orders(
	id						INT IDENTITY(1,1) PRIMARY KEY,
	name					NVARCHAR(50) NOT NULL UNIQUE,
	description				NVARCHAR(1000) NOT NULL
);
INSERT INTO status_orders (name, description) VALUES 
    (N'Ожидает оплаты',		N'Заказ создан, ожидается оплата от покупателя.'),
    (N'В обработке',		N'Оплата получена, заказ собирается и подготавливается к отправке.'),
    (N'Доставлен',			N'Заказ успешно доставлен покупателю.');

CREATE TABLE orders(
	id						INT IDENTITY(1,1) PRIMARY KEY,
	user_id					INT NOT NULL,
	order_placement_date	DATETIME DEFAULT DATEADD(HOUR, 3, GETUTCDATE()),
	total_amount			DECIMAL(18,2) NOT NULL CHECK (total_amount > 0),
	status_id				INT NOT NULL,
	address					NVARCHAR(500),
	-- Внешние ключи
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (status_id) REFERENCES status_orders(id) ON DELETE CASCADE
);

CREATE TABLE order_products(
	id						INT IDENTITY(1,1) PRIMARY KEY,
	order_id				INT NOT NULL,
	product_id				INT NOT NULL,
	quantity				INT NOT NULL CHECK (quantity > 0),
	price					DECIMAL(18,2) NOT NULL CHECK (price > 0),
	-- Внешние ключи
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

CREATE TABLE order_history(
	id						INT IDENTITY(1,1) PRIMARY KEY,
	order_id				INT NOT NULL,
	old_status				INT, 
	new_status				INT NOT NULL,
	date_of_change			DATETIME DEFAULT DATEADD(HOUR, 3, GETUTCDATE()),
	comment					NVARCHAR(1000),
	-- Связь с заказом
    FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
	FOREIGN KEY (old_status) REFERENCES status_orders(id) ON DELETE NO ACTION,
	FOREIGN KEY (new_status) REFERENCES status_orders(id) ON DELETE NO ACTION
);

-- === USERS ===
INSERT INTO users (login, password, name, surname, patronymic, mail, phone_number, registration_date) VALUES
('ivan_ivanov',     'pass1234',		N'Иван',         N'Иванов',       N'Иванович',     'ivanov@mail.ru',           '+79011234567', '2025-01-10 08:30:00'),
('petr_petrov',     'pass5678',		N'Пётр',         N'Петров',       N'Петрович',     'petrov@mail.ru',           '+79022345678', '2025-01-12 10:15:00'),
('anna_smirnova',   'anna2025',		N'Анна',         N'Смирнова',     N'Олеговна',     'anna.s@domain.com',        '+79033456789', '2025-01-14 13:45:00'),
('sergey_kozlov',   'kozlov777',		N'Сергей',       N'Козлов',       N'Сергеевич',    'kozlov_s@email.ru',        '+79044567890', '2025-01-16 16:20:00'),
('maria_fedorova',  'masha123',		N'Мария',        N'Фёдорова',     N'Алексеевна',   'fedorova.m@site.com',      '+79055678901', '2025-01-18 19:05:00'),
('no_pass',   NULL,		N'Empty',       N'Empty',       N'Empty',    'empty@email.ru',        '+79044567890', '2025-01-16 16:20:00');

-- === CATEGORIES ===
INSERT INTO categories (name, description) VALUES
(N'Электроника',         N'Устройства и гаджеты: смартфоны, ноутбуки, планшеты и аксессуары.'),
(N'Одежда',               N'Повседневная и сезонная одежда для мужчин, женщин и детей.'),
(N'Книги',                N'Художественная литература, учебники, научно-популярные книги и детские издания.'),
(N'Бытовая техника',      N'Техника для дома: холодильники, стиральные машины, пылесосы и утюги.'),
(N'Спорт и отдых',        N'Инвентарь и экипировка для спорта, туризма, фитнеса и активного отдыха.');

-- === PRODUCTS ===
-- Убрано поле Date_Added из списка — оно заполнится автоматически
INSERT INTO products (name, description, price) VALUES
(N'Смартфон XYZ',               N'Современный смартфон с 6.5" экраном и 128 ГБ памяти',     29990.00),
(N'Футболка хлопковая',         N'Чёрная футболка из 100% хлопка, размер M',                990.00),
(N'Книга: SQL для начинающих',  N'Обучение SQL с нуля, 320 страниц',                        1450.00),
(N'Микроволновая печь',         N'MW-2000, 20 л, 800 Вт, белая',                            5990.00),
(N'Теннисная ракетка',          N'Профессиональная ракетка, вес 280 г',                     4500.00);

INSERT INTO warehouses (name, description, address) VALUES
(N'Склад Москва Центральный',  N'Основной склад в Москве, приём, хранение и отгрузка', N'г. Москва, ул. Заводская, д. 10'),
(N'Склад СПб Север',           N'Региональный склад на севере страны',               N'г. Санкт-Петербург, пр. Ленина, д. 45'),
(N'Склад Екатеринбург Урал',   N'Центральный склад на Урале',                        N'г. Екатеринбург, ул. Промышленная, д. 7');

INSERT INTO warehouse_products (warehouse_id, product_id, quantity) VALUES
-- Склад Москва (ID=1)
(1, 1, 10), -- Смартфон XYZ
(1, 2, 50), -- Футболка хлопковая
(1, 3, 20), -- Книга: SQL для начинающих
(1, 4, 5),  -- Микроволновая печь
(1, 5, 8),  -- Теннисная ракетка

-- Склад СПб (ID=2)
(2, 1, 3),  -- Смартфон XYZ
(2, 2, 30), -- Футболка хлопковая
(2, 3, 10), -- Книга: SQL для начинающих
(2, 5, 5),  -- Теннисная ракетка

-- Склад Екатеринбург (ID=3)
(3, 2, 20), -- Футболка хлопковая
(3, 3, 15), -- Книга: SQL для начинающих
(3, 4, 3),  -- Микроволновая печь
(3, 5, 6);  -- Теннисная ракетка

-- === PRODUCT_CATEGORIES ===
INSERT INTO product_categories (product_id, category_id) VALUES
(1, 1), -- Смартфон → Электроника
(2, 2), -- Футболка → Одежда
(3, 3), -- Книга → Книги
(4, 4), -- Микроволновка → Бытовая техника
(5, 5); -- Ракетка → Спорт и отдых

-- === ORDERS ===
INSERT INTO orders (user_id, total_amount, status_id, address, order_placement_date) VALUES
(1, 29990.00, 1, N'г. Москва, ул. Ленина, д. 10, кв. 1', '2025-02-10 08:30:00'),
(2, 990.00,   2, N'г. Санкт-Петербург, Невский пр., д. 25, кв. 5', '2025-01-10 08:30:00'),
(3, 1450.00, 3, N'г. Казань, ул. Баумана, д. 12, кв. 44', '2025-01-11 08:30:00'),
(4, 5990.00, 1, N'г. Новосибирск, ул. Гоголя, д. 33, кв. 12', '2025-01-12 08:30:00'),
(5, 4500.00, 2, N'г. Екатеринбург, ул. Мира, д. 7, кв. 99', '2025-01-13 08:30:00'),
(1, 1450.00, 1, N'г. Москва, ул. Ленина, д. 10, кв. 1', '2025-01-14 08:30:00'),
(3, 4500.00, 2, N'г. Казань, ул. Баумана, д. 12, кв. 44', '2025-01-15 08:30:00'),
(3, 990.00,  3, N'г. Казань, ул. Баумана, д. 12, кв. 44', '2025-01-16 08:30:00'),
(4, 990.00,  2, N'г. Новосибирск, ул. Гоголя, д. 33, кв. 12', '2025-01-17 08:30:00'),
(5, 29990.00, 1, N'г. Екатеринбург, ул. Мира, д. 7, кв. 99', '2025-01-18 08:30:00'),
(5, 5990.00,  2, N'г. Екатеринбург, ул. Мира, д. 7, кв. 99', '2025-01-19 08:30:00'),
(5, 1450.00,  1, N'г. Екатеринбург, ул. Мира, д. 7, кв. 99', '2025-01-20 08:30:00');

-- === ORDER_PRODUCTS ===
INSERT INTO order_products (order_id, product_id, quantity, price) VALUES
-- Заказ 1: смартфон + книга
(1, 1, 1, 29990.00),  -- Смартфон XYZ
(1, 3, 1, 1450.00),   -- Книга: SQL для начинающих
-- Заказ 2: 2 футболки
(2, 2, 2, 990.00),    -- Футболка хлопковая (цена за штуку)
-- Заказ 3: книга + ракетка
(3, 3, 1, 1450.00),   -- Книга
(3, 5, 1, 4500.00),   -- Теннисная ракетка
-- Заказ 4: микроволновка
(4, 4, 1, 5990.00),   -- Микроволновая печь
-- Заказ 5: 2 ракетки
(5, 5, 2, 4500.00);   -- Теннисная ракетка (2 шт)

-- === ORDER_HISTORY ===
INSERT INTO order_history (order_id, old_status, new_status, comment) VALUES
(1, NULL, 1, N'Создан новый заказ'),
(2, NULL, 1, N'Создан новый заказ'),
(2, 1,    2, N'Покупатель подтвердил оплату'),
(3, NULL, 1, N'Создан новый заказ'),
(3, 1,    2, N'Оплата получена'),
(3, 2,    3, N'Заказ доставлен клиенту'),
(4, NULL, 1, N'Создан новый заказ'),
(5, NULL, 1, N'Создан новый заказ'),
(5, 1,    2, N'Оплата подтверждена'),
(6, NULL, 1, N'Повторный заказ: книга по SQL'),
(7, NULL, 2, N'Срочная обработка — приоритетный заказ'),
(8, NULL, 3, N'Заказ доставлен — подарок другу'),
(9, NULL, 2, N'Добавлен в корзину повторно — акция'),
(10, NULL, 1, N'Новый смартфон — обновление техники'),
(11, NULL, 2, N'Микроволновка — в подарок родителям'),
(12, NULL, 1, N'Книга — для учёбы и сертификации');

-- Для отображения, если нужно
SELECT * FROM users;
SELECT * FROM categories;
SELECT * FROM products;
SELECT * FROM warehouses;
SELECT * FROM warehouse_products;
SELECT * FROM product_categories;
SELECT * FROM status_orders;
SELECT * FROM orders;
SELECT * FROM order_products;
SELECT * FROM order_history;

-- Для очистки, если нужно
DROP TABLE IF EXISTS order_history;
DROP TABLE IF EXISTS product_categories;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS order_products;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS warehouse_products;
DROP TABLE IF EXISTS warehouses;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS status_orders;