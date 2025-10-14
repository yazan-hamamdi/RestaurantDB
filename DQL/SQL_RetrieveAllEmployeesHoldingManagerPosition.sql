SELECT 
   FirstName + ' ' + LastName AS CustomerName,
   Position
FROM Restaurant.Employees
WHERE Position = 'Manager';