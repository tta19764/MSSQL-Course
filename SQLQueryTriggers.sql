CREATE TRIGGER DeleteClient ON Clients
FOR DELETE
AS 
PRINT 'You can not delete clients'
ROLLBACK

CREATE TRIGGER NewOrderSell ON SellsOrders
FOR INSERT
AS
IF (SELECT ItemsLeft FROM Items AS It JOIN Sells AS S ON S.ItemId = It.Id JOIN inserted AS ins ON ins.SellId = S.Id) < (SELECT NumberOfItems FROM Sells AS S JOIN inserted AS ins ON ins.SellId = S.Id)
BEGIN
	PRINT 'Not enough items for this sell'
	ROLLBACK
END
ELSE
BEGIN
	UPDATE Items
	SET ItemsLeft -= (SELECT NumberOfItems FROM inserted AS I JOIN Sells AS S ON S.Id = I.SellId)
	WHERE Id = (SELECT I.Id FROM Items AS I JOIN Sells AS S ON S.ItemId = I.Id JOIN inserted AS Ins ON S.Id = Ins.SellId);
END

CREATE TRIGGER ProperCancelSell ON SellsOrders
FOR DELETE
AS
UPDATE Items
SET ItemsLeft += (SELECT NumberOfItems FROM deleted AS D JOIN Sells AS S ON S.Id = D.SellId)
WHERE Id = (SELECT I.Id FROM Items AS I JOIN Sells AS S ON S.ItemId = I.Id JOIN deleted AS D ON S.Id = D.SellId); 

