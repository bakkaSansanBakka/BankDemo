create database BankDemo;
go

use BankDemo
go


/*Tables creation section*/

create table Cities 
(
	Id nvarchar(6) primary key,
	Name nvarchar(50) not null,
	Country nvarchar(50) not null,
)

insert into Cities (Id, Name, Country)
	values ('MSK', 'Minsk', 'Republic of Belarus'),
			('BST', 'Brest', 'Republic of Belarus'),
			('GML', 'Gomel', 'Republic of Belarus'),
			('MGL', 'Mogilev', 'Republic of Belarus'),
			('VTBK', 'Vitebsk', 'Republic of Belarus'),
			('GDN', 'Grodno', 'Republic of Belarus')

select * from Cities
go

create table Banks 
(
	Id nvarchar(10) primary key,
	Name nvarchar(30) not null,
)

insert into Banks (Id, Name)
	values ('BAPB', 'Belagroprombank'),
			('AKBB', 'Belarusbank'),
			('BLBB', 'Belinvestbank'),
			('ALFA', 'Alpha-Bank'),
			('POIS', 'Paritetbank'),
			('PJCB', 'Priorbank')

select * from Banks
go

create table Banks_Branches
(
	Id integer primary key,
	Bank nvarchar(10) not null,
	City nvarchar(6) not null,
	Address nvarchar(100) not null,
	foreign key (Bank) references Banks(Id),
	foreign key (City) references Cities(Id),
)

insert into Banks_Branches(Id, Bank, City, Address)
	values (1001, 'AKBB', 'MSK', 'Minsk, pr. Nezavisemosti, 91'),
			(2001, 'AKBB', 'MGL', 'Mogilev, pr. Pushkinskiy, 34-41'),
			(1045, 'BAPB', 'MSK', 'Minsk, pr. Pobediteley, 84'),
			(4341, 'ALFA', 'VTBK', 'Vitebsk, ul. Cosmonavtov, 11'),
			(6627, 'BLBB', 'GDN', 'Grodno, el. Mitskevicha, 3'),
			(3441, 'POIS', 'GML', 'Gomel, pr. Lenina, 29A'),
			(4567, 'PJCB', 'BST', 'Brest, b-r Shevchenko, 6/1')

select * from Banks_Branches
go

create table Social_Statuses
(
	Id nvarchar(10) primary key,
	Name nvarchar(100) not null,
)

insert into Social_Statuses (Id, Name)
	values ('ST_EMP', 'State employee'),
			('PENS', 'Pensioner'),
			('DIS', 'Disabled person'),
			('VET', 'Veteran'),
			('LGFAM', 'Have a large family'),
			('ORPH', 'Orphan')

select * from Social_Statuses
go

create table Clients
(
	Id integer identity(1,1) primary key,
	Surname nvarchar(100) not null,
	Firstname nvarchar(30) not null,
	Patronymic nvarchar(100),
	Passport_number nvarchar(9) not null unique,
	Phone_number nvarchar(13) not null,
)

insert into Clients (Surname, Firstname, Patronymic, Passport_number, Phone_number)
	values ('Steblov', 'Alexander', 'Vasilievich', 'MP5682315', '80296724144'),
			('Kureichik', 'Natalia', 'Georgievna', 'AB6281552', '+375446776635'),
			('Burak', 'Tatiana', 'Nikolaevna', 'BM6788127', '+375295288241'),
			('Vasiliev', 'Petr', 'Leonidovich', 'HB5689124', '80253565251'),
			('Shibko', 'Anastasia', 'Alexandrovna', 'MC5689781', '80294556121'),
			('Klukach', 'Pavel', 'Nikolaevich', 'MP4545215', '+375442234567'),
			('Paramonov', 'Aleksei', 'Evgenievna', 'HB5625356', '80254544227')

select * from Clients;
go

create table Clients_Social_Statuses
(
	Id integer identity(1,1) primary key,
	Client_Id integer not null,
	Status_Id nvarchar(10) not null,
	foreign key (Client_Id) references Clients(Id),
	foreign key (Status_Id) references Social_Statuses(Id),
)

insert into Clients_Social_Statuses(Client_Id, Status_Id)
	values (1, 'PENS'),
			(2, 'LGFAM'),
			(3, 'PENS'),
			(4, 'ORPH'),
			(5, 'ST_EMP'),
			(6, 'ST_EMP'),
			(7, 'DIS'),
			(7, 'VET')

select * from Clients_Social_Statuses
go

create table Accounts
(
	Id nvarchar(20) primary key,
	Client_Id integer not null,
	Bank_Id nvarchar(10) not null,
	Balance money not null,
	foreign key (Client_Id) references Clients(Id),
	foreign key (Bank_Id) references Banks(Id),
)

insert into Accounts (Id, Client_Id, Bank_Id, Balance)
	values ('40820810140405682315', 1, 'AKBB', 1000),
			('40845810156236281552', 2, 'BAPB', 2000),
			('40821810189127881273', 3, 'POIS', 2000),
			('40834810140407881272', 3, 'AKBB', 1000),
			('40878810156325689124', 4, 'PJCB', 2300),
			('40852810156325689781', 5, 'PJCB', 1500),
			('40882810140404545215', 6, 'AKBB', 1650),
			('40871810189814545215', 6, 'ALFA', 7000),
			('40889810128935625356', 7, 'BLBB', 2000)

select * from Accounts
go

create table Cards
(
	Id nvarchar(16) primary key,
	Client_Id integer not null,
	Bank_Id nvarchar(10) not null,
	Balance money not null,
	Account_Id nvarchar(20) not null,
	foreign key (Client_Id) references Clients(Id),
	foreign key (Bank_Id) references Banks(Id),
	foreign key (Account_Id) references Accounts(Id),
)

insert into Cards (Id, Client_Id, Bank_Id, Balance, Account_Id)
	values ('6752672357907782', 1, 'AKBB', 600, '40820810140405682315'),
			('5632782990211991', 1, 'AKBB', 400, '40820810140405682315'),
			('8912901290196712', 2, 'BAPB', 1000, '40845810156236281552'),
			('7812561281927737', 3, 'AKBB', 300, '40834810140407881272'),
			('7221738219235623', 4, 'PJCB', 800, '40878810156325689124'),
			('9012627173428192', 4, 'PJCB', 100, '40878810156325689124'),
			('5635829389182811', 5, 'PJCB', 1000, '40852810156325689781'),
			('6711561189237812', 6, 'AKBB', 2000, '40871810189814545215'),
			('9014721967188921', 7, 'BLBB', 900, '40889810128935625356')

select * from Cards
go

create procedure Drop_All_Tables
as
	if object_id(N'Cards', N'U') is not null
	   drop table Cards;
	if object_id(N'Accounts', N'U') is not null
	   drop table Accounts;
	if object_id(N'Clients_Social_Statuses', N'U') is not null
	   drop table Clients_Social_Statuses;
	if object_id(N'Clients', N'U') is not null
	   drop table Clients;
	if object_id(N'Social_Statuses', N'U') is not null
	   drop table Social_Statuses;
	if object_id(N'Banks_Branches', N'U') is not null
	   drop table Banks_Branches;
	if object_id(N'Banks', N'U') is not null
	   drop table Banks;
	if object_id(N'Cities', N'U') is not null
	   drop table Cities;
go

/*EXEC Drop_All_Tables*/


/*Task section*/

/*1. select banks that have branches in a certain city*/
declare @city nvarchar(50) = 'Minsk'

select * from Banks_Branches 
	join Banks on Banks_Branches.Bank = Banks.Id
	join Cities on Cities.Id = Banks_Branches.City
where Cities.Name = @city
go

/*2. select cards with cardholder name, card balance and bank name*/
select Cards.Id, Clients.Surname + ' ' + Clients.Firstname + ' ' + Clients.Patronymic as Fullname, Cards.Balance, Banks.Name as Bank_Name
from Cards join Clients on Cards.Client_Id = Clients.Id
	join Banks on Cards.Bank_Id = Banks.Id
order by Fullname
go

/*3. select bank accounts whose balances don't match sum of card balances and show difference*/
select Accounts.Id as Account_Id, Accounts.Balance as Account_Balance,
	sum(Cards.Balance) as Card_Balance_Sum, Accounts.Balance - sum(Cards.Balance) as Balances_Difference
from Accounts join Cards on Accounts.Id = Cards.Account_Id
group by Accounts.Id, Accounts.Balance
	having Accounts.Balance != sum(Cards.Balance)
go

/*4. select cards count for each social status*/
select Social_Statuses.Name as Social_Status, count(Cards.Account_Id) as Cards_Amount
from Social_Statuses join Clients_Social_Statuses on Social_Statuses.Id = Clients_Social_Statuses.Status_Id
	join Clients on Clients.Id = Clients_Social_Statuses.Client_Id
	join Cards on Cards.Client_Id = Clients_Social_Statuses.Client_Id
group by Social_Statuses.Name
go

select social_status.Name as Social_Status, 
	(select count(Cards.Account_Id) from Social_Statuses join Clients_Social_Statuses on Social_Statuses.Id = Clients_Social_Statuses.Status_Id
		join Clients on Clients.Id = Clients_Social_Statuses.Client_Id
		join Cards on Cards.Client_Id = Clients_Social_Statuses.Client_Id
	where Social_Statuses.Name = social_status.Name) as Cards_Amount
from Social_Statuses as social_status
order by social_status.Name
go

/*5. create procedure that adds 10$ to account with certain social status */
create procedure Add_Dollars_To_Account_With_Status @status_id nvarchar(10)
as
declare @dollars_amount int = 10, @dollar_BYN_cost float = 2.5
begin try
	if not exists (select Social_Statuses.Id from Social_Statuses where Social_Statuses.Id = @status_id)
		raiserror ('The entered social status code does not exist in database.', 16, 2)
	if not exists (select Accounts.Id from Accounts 
						join Clients_Social_Statuses on Accounts.Client_Id = Clients_Social_Statuses.Client_Id
						join Social_Statuses on Social_Statuses.Id = Clients_Social_Statuses.Status_Id
					where Social_Statuses.Id = @status_id)
		raiserror ('The entered social status does not have linked accounts.', 16, 2)
	update Accounts set Balance = Balance + @dollars_amount * @dollar_BYN_cost
	where Accounts.Client_Id in (select Clients_Social_Statuses.Client_Id from Clients_Social_Statuses 
									join Social_Statuses on Social_Statuses.Id = Clients_Social_Statuses.Status_Id
								where Social_Statuses.Id = @status_id)
end try
begin catch
	print error_message()
end catch
go

/*before*/
select Accounts.Id as Account_Id, Accounts.Balance, Social_Statuses.Name as Social_Status
from Accounts join Clients_Social_Statuses on Clients_Social_Statuses.Client_Id = Accounts.Client_Id
	join Social_Statuses on Social_Statuses.Id = Clients_Social_Statuses.Status_Id
go

/*procedure call*/
declare @status_id nvarchar(10) = 'PENS'
exec Add_Dollars_To_Account_With_Status @status_id
go

/*after*/
select Accounts.Id as Account_Id, Accounts.Balance, Social_Statuses.Name as Social_Status
from Accounts join Clients_Social_Statuses on Clients_Social_Statuses.Client_Id = Accounts.Client_Id
	join Social_Statuses on Social_Statuses.Id = Clients_Social_Statuses.Status_Id
go

/*execute procedure with invalid status id*/
declare @status_id nvarchar(10) = 'INVALID'
exec Add_Dollars_To_Account_With_Status @status_id
go

/*6. select available funds on account for each client*/
select Clients.Surname + ' ' + Clients.Firstname + ' ' + Clients.Patronymic as Client,
	Accounts.Id as Account, Accounts.Balance as Account_Balance, count(Cards.Id) as Cards_Amount,
	sum(Cards.Balance) as Cards_Balance_Sum,
	Accounts.Balance - isnull(sum(Cards.Balance), 0) as Available_Funds
from 
	Accounts join Clients on Accounts.Client_Id = Clients.Id
	left join Cards on Cards.Account_Id = Accounts.Id
group by Clients.Surname, Clients.Firstname, Clients.Patronymic,
		Accounts.Id, Accounts.Balance
go

/*7. create procedure that transfers certain amount of money from account to card of this account*/
create procedure Transfer_From_Account_To_Card @sum_of_money money, @card_number nvarchar(16)
as
begin try
	if not exists (select Cards.Id from Cards where Cards.Id = @card_number)
		raiserror ('Entered card number does not exist.', 16, 2)

	declare @account nvarchar(20), @account_balance money, @cards_balance money
	set @account = (select Accounts.Id from Accounts join Cards on Cards.Account_Id = Accounts.Id where Cards.Id = @card_number)
	set @account_balance = (select Accounts.Balance from Accounts join Cards on Cards.Account_Id = Accounts.Id where Cards.Id = @card_number)
	set @cards_balance = (select sum(Cards.Balance) from Cards join Accounts on Accounts.Id = Cards.Account_Id where Accounts.Id = @account)

	if @sum_of_money < @account_balance - @cards_balance
		begin 
			begin transaction
				update Cards set Balance = Balance + @sum_of_money where Id = @card_number
			commit
		end
	else
		raiserror ('Provided amount of money is bigger than account funds.', 16, 2)
end try
begin catch
	print error_message()
end catch
go

/*before*/
declare @sum_of_money money = 100, @card_number nvarchar(16) = '6711561189237812'

select Accounts.Id as Account_Id,
		Accounts.Balance as Account_Balance,
		Cards.Id as Card,
		Cards.Balance as Cards_Balance 
from Accounts join Cards on Cards.Account_Id = Accounts.Id
where Cards.Id = @card_number

/*procedure call*/
exec Transfer_From_Account_To_Card @sum_of_money, @card_number

/*after*/
select Accounts.Id as Account_Id,
		Accounts.Balance as Account_Balance,
		Cards.Id as Card,
		Cards.Balance as Cards_Balance 
from Accounts join Cards on Cards.Account_Id = Accounts.Id
where Cards.Id = @card_number
go

/*execute procedure with non-existent card number*/
declare @sum_of_money money = 100, @card_number nvarchar(16) = '1'
exec Transfer_From_Account_To_Card @sum_of_money, @card_number
go

/*execute procedure with provided amount of money bigger than available funds*/
declare @sum_of_money money = 100000, @card_number nvarchar(16) = '6711561189237812'
exec Transfer_From_Account_To_Card @sum_of_money, @card_number
go

/*8. create triggers on tables Accounts and Cards */
create trigger instead_of_update_Accounts 
on Accounts instead of update
as
	declare @account_balance_inserted money, @account nvarchar(20), @cards_sum_balance money
	select @account_balance_inserted = inserted.Balance, @account = inserted.Id from inserted
	set @cards_sum_balance = (select sum(Cards.Balance) from Cards join Accounts on Accounts.Id = Cards.Account_Id where Accounts.Id = @account)

	if update(Balance)
		begin
			if @account_balance_inserted < @cards_sum_balance
				raiserror('Changing the value of account balance is not allowed because the sum of cards balances linked to this account is less than provided balance value', 16, 2)
			else 
				begin
					update Accounts set Balance = @account_balance_inserted where Id = @account
				end
		end
go

/*check if trigger works*/
select * from Accounts
update Accounts set Balance = 1100 where Id = '40820810140405682315'
select * from Accounts
go

/*attempt to set balance value less than cards balance sum*/
update Accounts set Balance = 100 where Id = '40820810140405682315'
go

/*Cards trigger*/
create trigger instead_of_update_Cards 
on Cards instead of update
as
	declare @card_balance_inserted money,
			@account nvarchar(20),
			@card nvarchar(16),
			@account_balance money,
			@cards_sum_balance_after_insert money

	select @card_balance_inserted = inserted.Balance, @account = inserted.Account_Id, @card = inserted.Id from inserted
	set @account_balance = (select Balance from Accounts where Id = @account)
	set @cards_sum_balance_after_insert = (select sum(Cards.Balance) from Cards 
											join Accounts on Accounts.Id = Cards.Account_Id
											where Accounts.Id = @account and Cards.Id != @card) + @card_balance_inserted

	if update(Balance)
		begin
			if @cards_sum_balance_after_insert > @account_balance
				raiserror('Changing the value of card balance is not allowed because the sum of cards balances linked to account would become greater than account balance value', 16, 2)
			else 
				begin
					update Cards set Balance = @card_balance_inserted where Id = @card
				end
		end
go

/*check if trigger works*/
select * from Cards
update Cards set Balance = 200 where Id = '5632782990211991'
select * from Cards
go

/*attempt to set balance value greater than account balance*/
update Cards set Balance = 3000 where Id = '5632782990211991'