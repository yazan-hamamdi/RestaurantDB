CREATE SCHEMA Restaurant;
GO

CREATE TABLE Restaurant.Restaurants (
    RestaurantId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL,
    Address NVARCHAR(255),
    PhoneNumber NVARCHAR(20),
    OpeningHours NVARCHAR(100)
);

CREATE TABLE Restaurant.Employees (
    EmployeeId INT PRIMARY KEY IDENTITY(1,1),
    RestaurantId INT NOT NULL,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Position NVARCHAR(50),
    FOREIGN KEY (RestaurantId) REFERENCES Restaurant.Restaurants(RestaurantId)
);

CREATE TABLE Restaurant.Tables (
    TableId INT PRIMARY KEY IDENTITY(1,1),
    RestaurantId INT NOT NULL,
    Capacity INT NOT NULL,
    FOREIGN KEY (RestaurantId) REFERENCES Restaurant.Restaurants(RestaurantId)
);

CREATE TABLE Restaurant.Customers (
    CustomerId INT PRIMARY KEY IDENTITY(1,1),
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100),
    PhoneNumber NVARCHAR(20)
);

CREATE TABLE Restaurant.Reservations (
    ReservationId INT PRIMARY KEY IDENTITY(1,1),
    CustomerId INT NOT NULL,
    RestaurantId INT NOT NULL,
    TableId INT NOT NULL,
    ReservationDate DATETIME NOT NULL,
    PartySize INT,
    FOREIGN KEY (CustomerId) REFERENCES Restaurant.Customers(CustomerId),
    FOREIGN KEY (RestaurantId) REFERENCES Restaurant.Restaurants(RestaurantId),
    FOREIGN KEY (TableId) REFERENCES Restaurant.Tables(TableId)
);

CREATE TABLE Restaurant.Orders (
    OrderId INT PRIMARY KEY IDENTITY(1,1),
    ReservationId INT NOT NULL,
    EmployeeId INT NULL,
    OrderDate DATETIME NOT NULL DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2),
    FOREIGN KEY (ReservationId) REFERENCES Restaurant.Reservations(ReservationId),
    FOREIGN KEY (EmployeeId) REFERENCES Restaurant.Employees(EmployeeId)
);

CREATE TABLE Restaurant.MenuItems (
    ItemId INT PRIMARY KEY IDENTITY(1,1),
    RestaurantId INT NOT NULL,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    Price DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (RestaurantId) REFERENCES Restaurant.Restaurants(RestaurantId)
);

CREATE TABLE Restaurant.OrderItems (
    OrderItemId INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT NOT NULL,
    ItemId INT NOT NULL,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    FOREIGN KEY (OrderId) REFERENCES Restaurant.Orders(OrderId),
    FOREIGN KEY (ItemId) REFERENCES Restaurant.MenuItems(ItemId)
);
