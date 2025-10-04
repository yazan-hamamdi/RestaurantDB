CREATE PROCEDURE Restaurant.GetCustomerReservations
@Customerid INT
AS
 BEGIN
 SELECT 
     r.ReservationId,
     r.ReservationDate,
     r.PartySize
 FROM Restaurant.Reservations r
 INNER JOIN Restaurant.Customers c 
     ON r.CustomerId = c.CustomerId
 WHERE c.CustomerId = @CustomerId;
 END;
