CREATE PROCEDURE Restaurant.sp_AddNewOrder
    @ReservationId INT,
    @EmployeeId INT,
    @OrderDate DATETIME,
    @TotalAmount DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    IF NOT EXISTS (
        SELECT 1 
        FROM Restaurant.Reservations 
        WHERE ReservationId = @ReservationId
    )
    BEGIN
        RAISERROR('Error: The specified ReservationId does not exist', 16, 1);
        RETURN;
    END
    IF NOT EXISTS (
        SELECT 1 
        FROM Restaurant.Employees 
        WHERE EmployeeId = @EmployeeId
    )
    BEGIN
        RAISERROR('Error: The specified EmployeeId does not exist', 16, 1);
        RETURN;
    END

    INSERT INTO Restaurant.Orders (ReservationId, EmployeeId, OrderDate, TotalAmount)
    VALUES (@ReservationId, @EmployeeId, @OrderDate, @TotalAmount);
    DECLARE @NewOrderId INT = SCOPE_IDENTITY();

    SELECT 
        @NewOrderId AS NewOrderId,
        'Order added successfully.' AS Message;
END;
