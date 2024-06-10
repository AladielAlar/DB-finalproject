DROP TABLE IF EXISTS TempDate;
DROP TABLE IF EXISTS TempProduct;
DROP TABLE IF EXISTS TempCustomer;
DROP TABLE IF EXISTS TempSales;
DROP TABLE IF EXISTS TempReviews;

CREATE TEMP TABLE TempDate AS
SELECT DISTINCT OrderDate AS Date, 
       EXTRACT(YEAR FROM OrderDate) AS Year, 
       EXTRACT(QUARTER FROM OrderDate) AS Quarter, 
       EXTRACT(MONTH FROM OrderDate) AS Month, 
       EXTRACT(DAY FROM OrderDate) AS Day
FROM Orders;

CREATE TEMP TABLE TempProduct AS
SELECT P.ProductID, 
       P.ProductName, 
       C.CategoryName, 
       CURRENT_DATE AS StartDate, 
       NULL AS EndDate, 
       TRUE AS IsCurrent
FROM Products P
JOIN Categories C ON P.CategoryID = C.CategoryID;

CREATE TEMP TABLE TempCustomer AS
SELECT UserID AS CustomerID, 
       FirstName, 
       LastName, 
       Email, 
       Address, 
       Role, 
       CURRENT_DATE AS StartDate, 
       NULL AS EndDate, 
       TRUE AS IsCurrent
FROM Users;

CREATE TEMP TABLE TempSales AS
SELECT O.OrderID, 
       OD.ProductID, 
       O.UserID, 
       OD.Quantity, 
       OD.Quantity * OD.Price AS TotalPrice
FROM Orders O
JOIN OrderDetails OD ON O.OrderID = OD.OrderID;

CREATE TEMP TABLE TempReviews AS
SELECT ReviewID, 
       ProductID, 
       UserID, 
       Rating, 
       Comment
FROM Reviews;

COPY TempDate TO 'C:\\Project2\\TempDate.csv' CSV HEADER;
COPY TempProduct TO 'C:\\Project2\\TempProduct.csv' CSV HEADER;
COPY TempCustomer TO 'C:\\Project2\\TempCustomer.csv' CSV HEADER;
COPY TempSales TO 'C:\\Project2\\TempSales.csv' CSV HEADER;
COPY TempReviews TO 'C:\\Project2\\TempReviews.csv' CSV HEADER;

DROP TABLE IF EXISTS TempDate;
DROP TABLE IF EXISTS TempProduct;
DROP TABLE IF EXISTS TempCustomer;
DROP TABLE IF EXISTS TempSales;
DROP TABLE IF EXISTS TempReviews;


