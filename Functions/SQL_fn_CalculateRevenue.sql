CREATE FUNCTION Restaurant.fn_CalculateRevenue (@RestaurantId INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @TotalRevenue DECIMAL(10,2);
    SELECT 
        @TotalRevenue = SUM(o.TotalAmount)
    FROM Restaurant.Orders o
    JOIN Restaurant.Reservations r
        ON o.ReservationId = r.ReservationId
    WHERE r.RestaurantId = @RestaurantId;
    RETURN ISNULL(@TotalRevenue, 0);
END;
