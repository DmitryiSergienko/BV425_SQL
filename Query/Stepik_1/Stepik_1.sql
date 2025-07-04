create database Stepik_1

create table billing (
  payer_email VARCHAR(255) NULL,
  recipient_email VARCHAR(255) NULL,
  sum DECIMAL(18,2) NULL,
  currency VARCHAR(3) NULL,
  billing_date DATE NULL,
  comment TEXT NULL);

BULK INSERT billing
FROM 'C:\Users\Sergienko\source\repos\SQL\Query\Stepik_1\billing.csv' --����� ������� ���� ���������� ����
WITH (
    FIELDTERMINATOR = ',', 
    ROWTERMINATOR = '\n',
    FIRSTROW = 2 -- ���������� ���������
);

select * from billing -- ������� #1
where payer_email = 'vasya@mail.com';

insert into billing values ( -- ������� #2
    'pasha@mail.com','katya@mail.com', 300.00, 'EUR', '2016-02-14', 'Valentines day present'); 

update billing  -- ������� #3
set payer_email = 'igor@mail.com'
where payer_email = 'alex@mail.com';
 
delete from billing -- ������� #4
where payer_email IS NULL 
    OR recipient_email IS NULL
    OR payer_email = ''
    OR recipient_email = '';