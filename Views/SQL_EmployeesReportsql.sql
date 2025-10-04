CREATE VIEW Restaurant.EmployeesReport
AS
SELECT 
    e.EmployeeId,
    e.FirstName,
    e.LastName,
    e.Position,
    r.RestaurantId,
    r.Name AS RestaurantName,
    r.Address AS RestaurantAddress,
    r.PhoneNumber AS RestaurantPhone,
    r.OpeningHours
FROM Restaurant.Employees e
INNER JOIN Restaurant.Restaurants r
    ON e.RestaurantId = r.RestaurantId;
