SELECT 
    res.RestaurantId,
    res.Name AS RestaurantName,
    COUNT(r.ReservationId) AS ReservationCount,
     DENSE_RANK() OVER (ORDER BY COUNT(r.ReservationId) DESC) AS PopularityRank
FROM Restaurant.Restaurants res
LEFT JOIN Restaurant.Reservations r
    ON res.RestaurantId = r.RestaurantId
GROUP BY res.RestaurantId, res.Name
ORDER BY ReservationCount DESC;
