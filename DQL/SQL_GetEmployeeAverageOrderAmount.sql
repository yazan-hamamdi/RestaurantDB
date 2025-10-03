CREATE PROCEDURE Restaurant.GetEmployeeAverageOrderAmount
    @EmployeeId INT
AS
BEGIN
    SELECT 
        e.EmployeeId,
        e.FirstName + ' ' + e.LastName AS EmployeeName,
        AVG(o.TotalAmount) AS AverageOrderAmount
    FROM Restaurant.Orders o
    INNER JOIN Restaurant.Employees e
        ON o.EmployeeId = e.EmployeeId
    WHERE o.EmployeeId = @EmployeeId
    GROUP BY e.EmployeeId, e.FirstName, e.LastName;
END;
