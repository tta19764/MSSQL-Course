CREATE PROC OrdersCount
AS 
DECLARE @togather int
SELECT @togather = COUNT(*)
FROM Orders
RETURN @togather;

DECLARE @res int
EXEC @res = OrdersCount;
PRINT 'We currently have '+CAST(@res AS nvarchar(10))+' different orders!'

CREATE PROC ClientsCount
AS 
DECLARE @togather int
SELECT @togather = COUNT(*)
FROM Clients
RETURN @togather;

DECLARE @res int
EXEC @res = ClientsCount;
PRINT CAST(@res AS nvarchar(10))+' customers have already bought something from us!'

CREATE PROC CancelSell @sellId int, @orderId int
AS 
DELETE FROM SellsOrders
WHERE SellId = @sellId AND @orderId = OrderId
IF NOT EXISTS(SELECT * FROM SellsOrders WHERE OrderId = @orderId)
BEGIN
	DELETE FROM Orders
	WHERE Id = @orderId
END

DECLARE @sellId int, @orderId int
SET @sellId = 3
SET @orderId = 1
EXEC CancelSell @sellId, @orderId


CREATE PROC CancelOrder @orderId int
AS 
DELETE FROM SellsOrders
WHERE @orderId = OrderId
DELETE FROM Orders
WHERE Id = @orderId

SELECT * FROM Orders
Select * FROM SellsOrders

DECLARE @orderId int
SET @orderId = 2
EXEC CancelOrder @orderId


