create database Products

create table employees(
	id				int identity(1,1) primary key,	--Уникальный идентификатор (первичный ключ)
	name			nvarchar(50),					--Имя сотрудника
	salary			decimal(10, 2),					--Зарплата
	department		nvarchar(100)					--Отдел
)

insert into employees(name, salary, department)
values
	(N'Иван Петров', 75000.00, N'IT'),
	(N'Алексей Смирнов', 60000.00, N'Маркетинг'),
	(N'Мария Иванова', 55000.00, N'HR'),
	(N'Дмитрий Кузнецов', 80000.00, N'IT'),
	(N'Анна Соколова', 48000.00, N'Финансы'),
	(N'Сергей Васильев', 65000.00, N'IT'),
	(N'Ольга Морозова', 52000.00, N'HR'),
	(N'Александр Белов', 90000.00, N'Маркетинг'),
	(N'Екатерина Козлова', 43000.00, N'Финансы'),
	(N'Павел Новиков', 70000.00, N'IT');

select * from employees

select name, salary from employees

select * from employees
where salary > 50000

select * from employees
order by salary desc

select top (3) * from employees
order by salary desc