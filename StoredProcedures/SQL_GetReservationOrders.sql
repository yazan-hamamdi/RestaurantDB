CREATE PROCEDURE Restaurant.GetReservationOrders
@ReservationId INT
AS
  BEGIN
    SELECT
	  o.OrderId,
	  o.OrderDate,
	  o.TotalAmount,
	  i.Name as "MenuItemName",
	  i.Price
    FROM Restaurant.Orders o 
	JOIN Restaurant.OrderItems oi
	  ON o.OrderId = oi.OrderId
    JOIN Restaurant.MenuItems i
	  ON i.ItemId = oi.ItemId
	WHERE o.ReservationId = @ReservationId
  END;