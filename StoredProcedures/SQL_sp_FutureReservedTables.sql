CREATE PROCEDURE Restaurant.sp_FutureReservedTables
AS
BEGIN
    SET NOCOUNT ON;

    CREATE TABLE #TempReservedTables (
        TableId INT,
        RestaurantId INT,
        ReservationId INT,
        ReservationDate DATETIME,
        PartySize INT
    );

    INSERT INTO #TempReservedTables (TableId, RestaurantId, ReservationId, ReservationDate, PartySize)
    SELECT 
        t.TableId,
        t.RestaurantId,
        rsv.ReservationId,
        rsv.ReservationDate,
        rsv.PartySize
    FROM Restaurant.Reservations rsv
    INNER JOIN Restaurant.Tables t
        ON rsv.TableId = t.TableId
    WHERE rsv.ReservationDate > GETDATE();

    SELECT 
        tmp.TableId,
        tmp.ReservationId,
        tmp.ReservationDate,
        tmp.PartySize,
        res.RestaurantId,
        res.Name AS RestaurantName,
        res.Address AS RestaurantAddress,
        res.PhoneNumber AS RestaurantPhone,
        res.OpeningHours
    FROM #TempReservedTables tmp
    JOIN Restaurant.Restaurants res
        ON tmp.RestaurantId = res.RestaurantId
    ORDER BY tmp.ReservationDate;
END;
