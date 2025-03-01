CREATE FUNCTION SearchBrand(@name nvarchar(50))
RETURNS TABLE
AS
RETURN
(
	SELECT BrandName, [Name]
	FROM Items AS I JOIN Brands AS B ON B.Id = I.BrandId
	WHERE BrandName LIKE @name
);

DECLARE @name nvarchar(50)
SET @name = 'Samsung'

SELECT * FROM SearchBrand(@name)

SELECT BrandName, [Name]
FROM Items AS I JOIN Brands AS B ON B.Id = I.BrandId
WHERE BrandName LIKE @name

CREATE FUNCTION SearchManufacturer(@country nvarchar(50))
RETURNS TABLE
AS
RETURN
(
	SELECT Country, [Name]
	FROM Items AS I JOIN Manufacturers AS M ON M.Id = I.ManufacturerId
	WHERE Country LIKE @country
);

DECLARE @country nvarchar(50)
SET @country = 'China'

SELECT * FROM SearchManufacturer(@country)

CREATE FUNCTION LastMonthSells()
RETURNS TABLE
AS
RETURN
(
	SELECT O.Id, FirstName, LastName, RegistrationDate, I.[Name], NumberOfItems, Price
	FROM Clients AS C JOIN Orders AS O ON C.Id = O.ClientId JOIN SellsOrders AS SO ON SO.OrderId = O.Id JOIN Sells AS S ON S.Id = So.SellId JOIN Items AS I ON I.Id = S.ItemId
	WHERE MONTH(RegistrationDate) = MONTH(GETDATE()) AND YEAR(RegistrationDate) = YEAR(GETDATE())
);

SELECT * FROM LastMonthSells();

CREATE FUNCTION LastMonthEncome()
RETURNS money
BEGIN
	DECLARE @summ money
	SELECT @summ = SUM(NumberOfItems * Price)
	FROM Orders AS O JOIN SellsOrders AS SO ON SO.OrderId = O.Id JOIN Sells AS S ON S.Id = SO.SellId JOIN Items AS I ON I.Id= s.ItemId
	WHERE MONTH(RegistrationDate) = MONTH(GETDATE()) AND YEAR(RegistrationDate) = YEAR(GETDATE())
	RETURN @summ
END

SELECT dbo.LastMonthEncome() AS Total;

