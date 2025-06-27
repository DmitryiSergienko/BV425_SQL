create database Products

create table employees(
	id				int identity(1,1) primary key,	--���������� ������������� (��������� ����)
	name			nvarchar(50),					--��� ����������
	salary			decimal(10, 2),					--��������
	department		nvarchar(100)					--�����
)

insert into employees(name, salary, department)
values
	(N'���� ������', 75000.00, N'IT'),
	(N'������� �������', 60000.00, N'���������'),
	(N'����� �������', 55000.00, N'HR'),
	(N'������� ��������', 80000.00, N'IT'),
	(N'���� ��������', 48000.00, N'�������'),
	(N'������ ��������', 65000.00, N'IT'),
	(N'����� ��������', 52000.00, N'HR'),
	(N'��������� �����', 90000.00, N'���������'),
	(N'��������� �������', 43000.00, N'�������'),
	(N'����� �������', 70000.00, N'IT');

select * from employees

select name, salary from employees

select * from employees
where salary > 50000

select * from employees
order by salary desc

select top (3) * from employees
order by salary desc