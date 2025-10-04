CREATE PROCEDURE Restaurant.GetPopularMenuItemsByMonth
    @Month INT,
    @Year INT
AS
BEGIN
    WITH MenuItemPopularity AS (
        SELECT 
            r.RestaurantId,
            r.Name AS RestaurantName,
            mi.ItemId,
            mi.Name AS MenuItemName,
            SUM(oi.Quantity) AS TotalOrdered,
            RANK() OVER (
                PARTITION BY r.RestaurantId 
                ORDER BY SUM(oi.Quantity) DESC
            ) AS ItemRank
        FROM Restaurant.Orders o
        JOIN Restaurant.OrderItems oi 
            ON o.OrderId = oi.OrderId
        JOIN Restaurant.MenuItems mi 
            ON oi.ItemId = mi.ItemId
        JOIN Restaurant.Restaurants r 
            ON mi.RestaurantId = r.RestaurantId
        WHERE MONTH(o.OrderDate) = @Month
          AND YEAR(o.OrderDate) = @Year
        GROUP BY r.RestaurantId, r.Name, mi.ItemId, mi.Name
    )
    SELECT 
        RestaurantId,
        RestaurantName,
        ItemId,
        MenuItemName,
        TotalOrdered
    FROM MenuItemPopularity
    WHERE ItemRank = 1
    ORDER BY RestaurantName;
END;
