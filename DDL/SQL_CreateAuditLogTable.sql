CREATE TABLE Restaurant.AuditLog (
    AuditId INT PRIMARY KEY IDENTITY(1,1),
    RestaurantId INT NOT NULL,
    TableId INT NOT NULL,
    ReservationDate DATETIME NOT NULL,
    ChangeDate DATETIME NOT NULL DEFAULT GETDATE()
);
