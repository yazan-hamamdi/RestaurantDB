CREATE PROCEDURE Restaurant.sp_ResrvedTablesReport
    @StartDate DATETIME,
    @EndDate DATETIME
AS
BEGIN
    SELECT 
        rsv.ReservationId,
        rsv.ReservationDate,
        rsv.PartySize,
        t.TableId,
        res.Name AS RestaurantName,
        res.Address AS RestaurantAddress
    FROM Restaurant.Reservations rsv
    JOIN Restaurant.Tables t
        ON rsv.TableId = t.TableId
    JOIN Restaurant.Restaurants res
        ON rsv.RestaurantId = res.RestaurantId
    WHERE rsv.ReservationDate BETWEEN @StartDate AND @EndDate
    ORDER BY rsv.ReservationDate, res.Name;
END;
