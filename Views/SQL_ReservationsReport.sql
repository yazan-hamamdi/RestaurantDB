CREATE VIEW Restaurant.ReservationsReport
AS
SELECT 
    r.ReservationId,
    r.ReservationDate,
    r.PartySize,
    c.CustomerId,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    c.Email AS CustomerEmail,
    c.PhoneNumber AS CustomerPhone,
    res.RestaurantId,
    res.Name AS RestaurantName,
    res.Address AS RestaurantAddress,
    res.PhoneNumber AS RestaurantPhone,
    res.OpeningHours
FROM Restaurant.Reservations r
INNER JOIN Restaurant.Customers c 
    ON r.CustomerId = c.CustomerId
INNER JOIN Restaurant.Restaurants res 
    ON r.RestaurantId = res.RestaurantId;
