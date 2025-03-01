CREATE VIEW AllItems
AS
SELECT [Name], BrandName, DepartmentName, CategoryName, Price, Country, ItemsLeft
FROM Items AS I JOIN Brands AS B ON I.BrandId = B.Id JOIN Manufacturers AS M ON I.ManufacturerId = M.Id JOIN Categories AS C ON C.Id = I.CategoryId JOIN Departments AS D ON D.Id = C.DepartmentId;

CREATE VIEW AllClients
AS
SELECT *
FROM Clients;

CREATE VIEW AllOrders 
AS
SELECT FirstName, LastName, RegistrationDate, [Name], NumberOfItems, NumberOfItems*Price AS 'Total price'
FROM Clients AS C JOIN Orders AS O ON C.Id = O.ClientId JOIN SellsOrders AS SO ON SO.OrderId = O.Id JOIN Sells AS S ON S.Id = SO.SellId JOIN Items AS I ON I.Id = S.ItemId;

SELECT * FROM AllOrders

CREATE VIEW AllWorkers
AS
SELECT FirstName, LastName, PositionName, Salary, Telephone
FROM Employees AS E JOIN Positions AS P ON P.Id = E.PositionId