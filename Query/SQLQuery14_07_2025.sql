create table sales (
	id				int primary key,
	product_name	nvarchar(50),
	category		nvarchar(30),
	price			decimal(10, 2),
	quantity		int,
	sale_date		date
);insert into sales (id, product_name, category, price, quantity, sale_date) values
(1, N'�������', N'�����������', 75000.00, 2, '2024-01-15'),
(2, N'��������', N'�����������', 45000.00, 5, '2024-01-16'),
(3, N'����������', N'������� �������', 32000.00, 1, '2024-01-17'),
(4, N'��������', N'�����������', 8000.00, 10, '2024-01-18'),
(5, N'�������������', N'������� �������', 15000.00, 3, '2024-01-19'),
(6, N'��������', N'������', 2000.00, 15, '2024-01-20'),
(7, N'���������', N'������', 5000.00, 8, '2024-01-21'),
(8, N'������', N'������� �������', 4000.00, 7, '2024-01-22'),
(9, N'�������', N'�����������', 25000.00, 4, '2024-01-23'),
(10, N'������', N'������', 3500.00, 12, '2024-01-24');

select * from sales;

--1. ��������� ������� �� ������ ��������� �������.
--�������� SQL-������, ������� ������� ��������� (category) � ����� ����� ������
--(total_revenue) �� ���.
select category, sum(price * quantity) as total_revenue from sales
group by category;

--2. ������� ��� �� ������ ���������.
--�������� SQL-������, ������� ������� ��������� (category) � ������� ��������� �����
--������� (avg_sale) � ���� ���������.
select category, convert(decimal(10, 2), round(avg(price), 2)) as avg_sale from sales
group by category;

--3. ��������� �������, � ������� ����� ������� ��������� 100 000.
--�������� SQL-������, ������� ������� ��������� (category) � ����� ��������
--(total_revenue) ������ 100 000.
select category, sum(price * quantity) as total_revenue from sales
group by category
having sum(price * quantity) > 110000;

--4. ����, � ������� ���� ������� ������ 5 �������.
--�������� SQL-������, ������� ������� ���� (sale_date), � ������� ����� ����������
--��������� ������� (total_quantity) ��������� 5.
select sale_date, quantity from sales
where quantity > 5;