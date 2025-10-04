WITH ReservationOrderCounts AS (
    SELECT 
        ReservationId,
        COUNT(OrderId) AS OrderCount
    FROM Restaurant.Orders
    GROUP BY ReservationId
)
SELECT 
    r.ReservationId,
    r.ReservationDate,
    r.PartySize,
    roc.OrderCount
FROM ReservationOrderCounts roc
JOIN Restaurant.Reservations r 
    ON roc.ReservationId = r.ReservationId
WHERE roc.OrderCount >= 2;