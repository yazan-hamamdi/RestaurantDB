CREATE TRIGGER Restaurant.trg_LogReservation
ON Restaurant.Reservations
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    INSERT INTO Restaurant.AuditLog (RestaurantId, TableId, ReservationDate, ChangeDate)
    SELECT 
        i.RestaurantId,
        i.TableId,
        i.ReservationDate,
        GETDATE() AS ChangeDate
    FROM inserted i;
END;
