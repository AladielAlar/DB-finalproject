CREATE TEMP TABLE TempUsers (
    UserID SERIAL PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Password VARCHAR(100) NOT NULL,
    Address TEXT,
    Role VARCHAR(20) NOT NULL
);

CREATE TEMP TABLE TempCategories (
    CategoryID SERIAL PRIMARY KEY,
    CategoryName VARCHAR(100) NOT NULL
);

CREATE TEMP TABLE TempProducts (
    ProductID SERIAL PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    Stock INT NOT NULL,
    CategoryID INT
);

CREATE TEMP TABLE TempOrders (
    OrderID SERIAL PRIMARY KEY,
    UserID INT,
    OrderDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Status VARCHAR(50) NOT NULL
);

CREATE TEMP TABLE TempOrderDetails (
    OrderDetailID SERIAL PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);

CREATE TEMP TABLE TempReviews (
    ReviewID SERIAL PRIMARY KEY,
    ProductID INT,
    UserID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    ReviewDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TEMP TABLE TempPaymentMethods (
    PaymentMethodID SERIAL PRIMARY KEY,
    PaymentMethodName VARCHAR(50) NOT NULL
);

CREATE TEMP TABLE TempTransactions (
    TransactionID SERIAL PRIMARY KEY,
    OrderID INT,
    PaymentMethodID INT,
    Amount DECIMAL(10, 2) NOT NULL,
    TransactionDate TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

COPY TempUsers(UserID, FirstName, LastName, Email, Password, Address, Role) 
FROM 'C:\\Project\\Users.csv' 
DELIMITER ',' CSV HEADER;

COPY TempCategories(CategoryID, CategoryName) 
FROM 'C:\\Project\\Categories.csv' 
DELIMITER ',' CSV HEADER;

COPY TempProducts(ProductID, ProductName, Description, Price, Stock, CategoryID) 
FROM 'C:\\Project\\Products.csv' 
DELIMITER ',' CSV HEADER;

COPY TempOrders(OrderID, UserID, OrderDate, Status) 
FROM 'C:\\Project\\Orders.csv' 
DELIMITER ',' CSV HEADER;

COPY TempOrderDetails(OrderDetailID, OrderID, ProductID, Quantity, Price) 
FROM 'C:\\Project\\OrderDetails.csv' 
DELIMITER ',' CSV HEADER;

COPY TempReviews(ReviewID, ProductID, UserID, Rating, Comment, ReviewDate) 
FROM 'C:\\Project\\Reviews.csv' 
DELIMITER ',' CSV HEADER;

COPY TempPaymentMethods(PaymentMethodID, PaymentMethodName) 
FROM 'C:\\Project\\PaymentMethods.csv' 
DELIMITER ',' CSV HEADER;

COPY TempTransactions(TransactionID, OrderID, PaymentMethodID, Amount, TransactionDate) 
FROM 'C:\\Project\\Transactions.csv' 
DELIMITER ',' CSV HEADER;

INSERT INTO Users (FirstName, LastName, Email, Password, Address, Role) 
SELECT TU.FirstName, TU.LastName, TU.Email, TU.Password, TU.Address, TU.Role
FROM TempUsers TU
LEFT JOIN Users U ON TU.Email = U.Email
WHERE U.Email IS NULL;

INSERT INTO Categories (CategoryName) 
SELECT TC.CategoryName
FROM TempCategories TC
LEFT JOIN Categories C ON TC.CategoryName = C.CategoryName
WHERE C.CategoryName IS NULL;

INSERT INTO Products (ProductName, Description, Price, Stock, CategoryID) 
SELECT TP.ProductName, TP.Description, TP.Price, TP.Stock, TP.CategoryID
FROM TempProducts TP
LEFT JOIN Products P ON TP.ProductName = P.ProductName AND TP.Description = P.Description
WHERE P.ProductName IS NULL;

INSERT INTO Orders (UserID, OrderDate, Status) 
SELECT TempOrders.UserID, TempOrders.OrderDate, TempOrders.Status
FROM TempOrders
LEFT JOIN Orders ON TempOrders.OrderID = Orders.OrderID
WHERE Orders.OrderID IS NULL;


INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price) 
SELECT TOD.OrderID, TOD.ProductID, TOD.Quantity, TOD.Price
FROM TempOrderDetails TOD
LEFT JOIN OrderDetails OD ON TOD.OrderID = OD.OrderID AND TOD.ProductID = OD.ProductID
WHERE OD.OrderID IS NULL AND OD.ProductID IS NULL;

INSERT INTO Reviews (ProductID, UserID, Rating, Comment, ReviewDate) 
SELECT TR.ProductID, TR.UserID, TR.Rating, TR.Comment, TR.ReviewDate
FROM TempReviews TR
LEFT JOIN Reviews R ON TR.ProductID = R.ProductID AND TR.UserID = R.UserID
WHERE R.ProductID IS NULL AND R.UserID IS NULL;

INSERT INTO PaymentMethods (PaymentMethodName) 
SELECT TPM.PaymentMethodName
FROM TempPaymentMethods TPM
LEFT JOIN PaymentMethods PM ON TPM.PaymentMethodName = PM.PaymentMethodName
WHERE PM.PaymentMethodName IS NULL;

INSERT INTO Transactions (OrderID, PaymentMethodID, Amount, TransactionDate) 
SELECT TT.OrderID, TT.PaymentMethodID, TT.Amount, TT.TransactionDate
FROM TempTransactions TT
LEFT JOIN Transactions T ON TT.OrderID = T.OrderID
WHERE T.OrderID IS NULL;

DROP TABLE TempUsers;
DROP TABLE TempCategories;
DROP TABLE TempProducts;
DROP TABLE TempOrders;
DROP TABLE TempOrderDetails;
DROP TABLE TempReviews;
DROP TABLE TempPaymentMethods;
DROP TABLE TempTransactions;
