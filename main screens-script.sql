SELECT UserID, FirstName, LastName, Email, Address, Role
FROM Users;

SELECT CategoryID, CategoryName
FROM Categories;

SELECT ProductID, ProductName, Description, Price, Stock
FROM Products
WHERE CategoryID = 1;

SELECT OrderID, OrderDate, Status
FROM Orders
WHERE UserID = 2;

SELECT OrderID, ProductID, Quantity, Price
FROM OrderDetails
WHERE OrderID = 1;

SELECT ReviewID, ProductID, UserID, Rating, Comment, ReviewDate
FROM Reviews;

SELECT PaymentMethodID, PaymentMethodName
FROM PaymentMethods;
