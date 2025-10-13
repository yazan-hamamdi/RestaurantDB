CREATE OR ALTER FUNCTION Restaurant.fn_CalculateEmployeeSalary (@EmployeeId INT)
RETURNS INT
AS
BEGIN
    DECLARE @Salary INT;

    SELECT @Salary = ISNULL(COUNT(o.OrderId), 0) *
        CASE e.Position
            WHEN 'VIPOrdersWaiter' THEN 5
            WHEN 'StandardWaiter' THEN 4
            WHEN 'AssistantWaiter' THEN 3
            ELSE 1
        END
    FROM Restaurant.Employees e
    LEFT JOIN Restaurant.Orders o
        ON e.EmployeeId = o.EmployeeId
    WHERE e.EmployeeId = @EmployeeId
    GROUP BY e.EmployeeId, e.Position;

    RETURN @Salary;
END;