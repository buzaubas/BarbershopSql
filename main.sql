-- 1

--select BarberName as 'Name', BarberSurname as 'Surname' from Barbers;

-- 2

--select * from Barbers where BarberPosition = 'Senior';

-- 3

--select * from Barbers where BarberService like '%Traditional shave%';

-- 4

--create procedure FindBarberService
--					@service nvarchar(MAX)
--as 
--select * from Barbers where contains (BarberService, @service);

--declare @find nvarchar(MAX);
--set @find = 'Traditional shave';

--exec FindBarberService @find;

-- 5

--create procedure FindBarberExperience
--					@years int
--as 
--select * from Barbers where (GETDATE() - BarberAcceptanceDate) = @years;

--declare @find int;
--set @find = 4;

--exec FindBarberExperience @find;

-- 6

--select count(1) as 'Number of Seniors' from Barbers where BarberPosition = 'Senior';

--select count(1) as 'Number of Juniors' from Barbers where BarberPosition = 'Junior';

-- 7

--create procedure FindRegularClient
--					@visits int
--as
--select * from Clients as cl where (select count(1) from Archive where ClientId = cl.ClientId) = @visits;

--declare @find int;
--set @find = 3;

--exec FindRegularClient @find;

-- 8

--CREATE TRIGGER Barbers_Chief_DELETE
--ON Barbers
--INSTEAD OF DELETE
--AS
--BEGIN
--	IF (select count(1) from Barbers where BarberPosition = 'Chief') = 1
--		PRINT 'Only cheif in barbershop, cannot delete'
--	ELSE
--		DELETE FROM Barbers WHERE BarberId = (SELECT  BarberId FROM deleted);
--END

-- 9 WARNING NOT COMPLETED

CREATE TRIGGER Barbers_Young21_INSERT
ON Barbers
INSTEAD OF INSERT
AS
BEGIN
	IF (select DATEDIFF(year, GETDATE(), select BarberBirthday from Barbers where BarberId = (select BarberId from inserted))) <= 21
		PRINT 'Age below 21'
	ELSE
		INSERT INTO Barbers select * from inserted
END

