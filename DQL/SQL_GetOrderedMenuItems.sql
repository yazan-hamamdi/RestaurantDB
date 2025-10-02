CREATE PROCEDURE Restaurant.GetOrderedMenuItems
    @ReservationId INT
AS
BEGIN
    SELECT 
        mi.ItemId,
        mi.Name AS MenuItemName,
        mi.Price,
        oi.Quantity,
        (oi.Quantity * mi.Price) AS ItemTotal
    FROM Restaurant.OrderItems oi
    INNER JOIN Restaurant.MenuItems mi 
        ON oi.ItemId = mi.ItemId
    INNER JOIN Restaurant.Orders o 
        ON oi.OrderId = o.OrderId
    WHERE o.ReservationId = @ReservationId;
END;
