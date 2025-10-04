CREATE FUNCTION Restaurant.fn_CalculateEmployeeSalary (@EmployeeId INT)
RETURNS INT
AS
BEGIN
   DECLARE @OrderCount INT;
   DECLARE @Rank INT;
   DECLARE @Salary INT;

   SELECT 
      @OrderCount = COUNT(*)
   FROM Restaurant.Orders
   WHERE EmployeeId = @EmployeeId;

   SELECT @Rank =
        CASE Position
            WHEN 'VIPOrdersWaiter' THEN 5
            WHEN 'StandardWaiter' THEN 4
            WHEN 'AssistantWaiter' THEN 3
            ELSE 1
        END
    FROM Restaurant.Employees
    WHERE EmployeeId = @EmployeeId;

	 SET @Salary = ISNULL(@OrderCount, 0) * ISNULL(@Rank, 0);

    RETURN @Salary;
END;    