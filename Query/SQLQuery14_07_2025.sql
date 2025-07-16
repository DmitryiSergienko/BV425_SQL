create table sales (
	id				int primary key,
	product_name	nvarchar(50),
	category		nvarchar(30),
	price			decimal(10, 2),
	quantity		int,
	sale_date		date
);insert into sales (id, product_name, category, price, quantity, sale_date) values
(1, N'Ноутбук', N'Электроника', 75000.00, 2, '2024-01-15'),
(2, N'Смартфон', N'Электроника', 45000.00, 5, '2024-01-16'),
(3, N'Кофемашина', N'Бытовая техника', 32000.00, 1, '2024-01-17'),
(4, N'Наушники', N'Электроника', 8000.00, 10, '2024-01-18'),
(5, N'Микроволновка', N'Бытовая техника', 15000.00, 3, '2024-01-19'),
(6, N'Футболка', N'Одежда', 2000.00, 15, '2024-01-20'),
(7, N'Кроссовки', N'Одежда', 5000.00, 8, '2024-01-21'),
(8, N'Чайник', N'Бытовая техника', 4000.00, 7, '2024-01-22'),
(9, N'Монитор', N'Электроника', 25000.00, 4, '2024-01-23'),
(10, N'Джинсы', N'Одежда', 3500.00, 12, '2024-01-24');

select * from sales;

--1. Суммарная выручка по каждой категории товаров.
--Напишите SQL-запрос, который выведет категорию (category) и общую сумму продаж
--(total_revenue) по ней.
select category, sum(price * quantity) as total_revenue from sales
group by category;

--2. Средний чек по каждой категории.
--Напишите SQL-запрос, который выведет категорию (category) и среднюю стоимость одной
--продажи (avg_sale) в этой категории.
select category, convert(decimal(10, 2), round(avg(price), 2)) as avg_sale from sales
group by category;

--3. Категории товаров, у которых общая выручка превышает 100 000.
--Напишите SQL-запрос, который выведет категории (category) с общей выручкой
--(total_revenue) больше 100 000.
select category, sum(price * quantity) as total_revenue from sales
group by category
having sum(price * quantity) > 110000;

--4. Даты, в которые было продано больше 5 товаров.
--Напишите SQL-запрос, который выведет даты (sale_date), в которые общее количество
--проданных товаров (total_quantity) превышает 5.
select sale_date, quantity from sales
where quantity > 5;