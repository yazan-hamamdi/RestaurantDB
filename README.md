# RestaurantDB - Restaurant Management System

A comprehensive relational database system designed to manage 
restaurant operations including reservations, orders, menu 
management, and employee tracking.

##  Key Features
- Multi-branch restaurant management
- Real-time table reservation system
- Order tracking and billing
- Employee performance analytics
- Revenue reporting and forecasting
- Audit logging for compliance

##  Technology Stack
- **Database**: MS SQL Server 2019+
- **Tools**: SQL Server Management Studio (SSMS)
- **Version Control**: Git/GitHub

## Database Schema (ERD)
  <img width="1000" height="900" alt="RestaurantSchema" src="https://github.com/user-attachments/assets/2d7b3a36-75b3-400b-a029-06d98adfbadd" />

Sample Data (Seeding)
The database is pre-populated with realistic fictional data:
 50 Restaurants
 30 Menu Items
 30 Orders
 40 Order Items
 Multiple Employees & Customers

### How to Seed
Execute scripts in order:
 DML/SQL_SeedRestaurants.sql
 DML/SQL_SeedTables.sql
 DML/SQL_SeedEmployees.sql
 DML/SQL_SeedCustomers.sql
 DML/SQL_SeedReservations.sql
 DML/SQL_SeedMenuItems,OrderItems,Orders.sql
 
1. List of Managers

Purpose: List all employees holding the “Manager” position.
Rationale:Help management monitor managers in each branch.
Useful for HR reports or access control.
File Path: DQL -> SQL_RetrieveAllEmployeesHoldingManagerPosition

2. Reservation’s Order with CTEs

Purpose: Identify reservations that have two or more orders using a CTE.
Rationale:Analyze high-activity reservations or tables.
Detect customers placing multiple orders in a single session.
File Path: DQL -> SQL_ReservationOrderCounts

3. Restaurant Popularity using Aggregation

Purpose: Rank restaurants by reservation frequency.
Rationale:Evaluate branch popularity.
Support expansion or marketing campaign decisions.
File Path: DQL -> SQL_GetPopularMenuItemsByMonth

## Views

4. Retrieve Reservations Report with Views
   
Purpose: Create a View showing reservations information along with restaurant and customer details.
Rationale:Simplify reporting by combining multiple data sources into a single view.
Improve readability in BI tools or reporting interfaces.
File Path: Views -> SQL_ReservationsReport

5. Retrieve Employees Details with Views

Purpose: Create a View showing employees with their associated restaurant information.
Rationale:Simplify retrieving employee and restaurant data in a single query.
Support HR and management reports.
File Path: Views -> SQL_EmployeesReportsql

## Stored Procedures
6. List of Reservations

Purpose: Retrieve all reservations for a specific customer.
Rationale:Track customer activity and reservation history.
Facilitate customer service by monitoring past and upcoming reservations.
File Path: StoredProcedures -> SQL_RetrieveAllReservationsForSpecificCustomers

7. List of Orders and Menu Items

Purpose: List all orders placed for a specific reservation along with associated menu items.
Rationale:Analyze orders per reservation.
Understand what was actually ordered to track customer preferences.
File Path: StoredProcedures -> SQL_GetOrderedMenuItems

8. List of Ordered Menu Items

Purpose: List all menu items ordered under a specific reservation.
Rationale:Analyze customer preferences in individual orders.
Generate reports on most frequently ordered dishes for events or special reservations.
File Path: StoredProcedures -> SQL_GetReservationOrders

9. Calculate Average Order Amount

Purpose: Calculate the average order amount made by a specific employee.
Rationale:Evaluate employee performance based on sales.
Identify high-performing employees in generating orders.
File Path: StoredProcedures -> SQL_GetEmployeeAverageOrderAmount

10. Popular Menu Item Analysis using Joins and Window Functions

Purpose: Identify the most popular menu item for each restaurant for a given month.
Rationale:Understand customer preferences per branch.
Optimize menu offerings and marketing based on actual demand.
File Path: StoredProcedures -> SQL_RestaurantPopularity

11. sp_ResrvedTablesReport

Functionality: Generate a report of all tables reserved within a specified date range.
Inputs: StartDate, EndDate
Output: List of reserved tables with restaurant and reservation details.
Rationale:Help management track occupancy levels daily or weekly.
Improve table scheduling and resource allocation.
File Path: StoredProcedures -> sp_ResrvedTablesReport

12. sp_AddNewOrder

Functionality: Add a new order with validation of reservation and employee existence.
Inputs: ReservationId, EmployeeId, OrderDate, TotalAmount
Output: OrderId or error message.
Rationale:Ensure data integrity before inserting an order.
Streamline creating new orders from the system.
File Path: StoredProcedures -> sp_AddNewOrder

13. sp_FutureReservedTables

Functionality: Retrieve tables with future reservations, store them temporarily, and join with the Restaurants table.
Rationale:Display a list of upcoming reservations for branches.
Facilitate planning and resource allocation in advance.
File Path: StoredProcedures -> sp_FutureReservedTables

## Database Functions
14. fn_CalculateRevenue

Functionality: Calculate total revenue generated by a specific restaurant.
Input: RestaurantId
Output: Total sales for the specified restaurant.
Rationale:Monitor financial performance of each branch.
Integrate into monthly revenue reports.
File Path: Functions -> fn_CalculateRevenu

15. fn_CalculateEmployeeSalary

Functionality: Calculate a specific employee’s salary based on the number of orders and rank.
Input: EmployeeId
Output: Calculated salary.
Rationale:Compute incentives based on performance.
Link financial rewards to actual employee activity.
File Path: Functions -> fn_CalculateEmployeeSalary

## Triggers
16. trg_LogReservation

Type: AFTER INSERT on Reservations table
Functionality: Log a record in the AuditLog table whenever a new reservation is added.
Logged Fields: RestaurantId, TableId, ReservationDate, ChangeDate
Rationale:Track all reservation operations in the system.
Improve auditing and historical tracking.
Maintain historical records for any changes in reservations.

## Performance and Optimization Notes
 1. Use of CTEs (Common Table Expressions)

Used in Reservation’s Order with CTEs to identify reservations with two or more orders.
Benefits:

   a.Improves readability and code organization.

   b.Simplifies writing complex queries incrementally.

   c.Reduces the need for additional temporary tables in memory.

 2. Use of JOINS

Inner and Left Joins were used extensively, e.g.:
Linking orders to menu items (Orders ↔ MenuItems).
Linking employees to restaurants (Employees ↔ Restaurants).

Benefits:

   a.Efficiently combine data from multiple tables.

   b.Reduce the number of separate queries, improving overall performance.

   c.Ensure data integrity through direct relationships.

3. Use of Aggregation Functions

Functions like SUM(), AVG(), COUNT() were used to calculate revenues, averages, and rankings.

Benefits:

   a.Perform statistical analysis directly in the database without external processing.

   b.Enable generating reports quickly and efficiently.

4. Use of Window Functions

Functions like RANK() and ROW_NUMBER() were used for analyzing most popular items.

Benefits:

   a.Perform advanced analytics on the same dataset without subqueries.

   b.Useful for ranking results or identifying top-selling items per restaurant.

 5. Use of Triggers

A trigger was created to log new reservations in the AuditLog table.

Benefits:

   a.Automatic logging ensures auditing without extra application logic.

   b.Increases transparency in tracking changes.

   c.Preserves historical data for reservations.

 6. General Performance Practices

   a.SET NOCOUNT ON in stored procedures to reduce overhead from system messages.

   b.Validation of data existence before insert using IF EXISTS to prevent errors.

   c.Use of Indexes on frequently joined or searched columns (JOIN / WHERE).

   d.Organizing code with Views to simplify reuse and secure data access.
