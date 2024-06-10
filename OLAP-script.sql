DROP TABLE IF EXISTS FactSales;
DROP TABLE IF EXISTS FactReviews;
DROP TABLE IF EXISTS DimDate;
DROP TABLE IF EXISTS DimProduct;
DROP TABLE IF EXISTS DimCustomer;

CREATE TABLE DimDate (
    DateID SERIAL PRIMARY KEY,
    Date DATE,
    Year INT,
    Quarter INT,
    Month INT,
    Day INT
);

CREATE TABLE DimProduct (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    CategoryName VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    IsCurrent BOOLEAN
);

CREATE TABLE DimCustomer (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100),
    Address TEXT,
    Role VARCHAR(20),
    StartDate DATE,
    EndDate DATE,
    IsCurrent BOOLEAN
);

CREATE TABLE FactSales (
    SalesID SERIAL PRIMARY KEY,
    DateID INT,
    ProductID INT,
    CustomerID INT,
    Quantity INT,
    TotalPrice DECIMAL(10, 2),
    CONSTRAINT fk_date FOREIGN KEY (DateID) REFERENCES DimDate(DateID),
    CONSTRAINT fk_product FOREIGN KEY (ProductID) REFERENCES DimProduct(ProductID),
    CONSTRAINT fk_customer FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID)
);

CREATE TABLE FactReviews (
    ReviewID SERIAL PRIMARY KEY,
    DateID INT,
    ProductID INT,
    CustomerID INT,
    Rating INT,
    Comment TEXT,
    CONSTRAINT fk_date_rev FOREIGN KEY (DateID) REFERENCES DimDate(DateID),
    CONSTRAINT fk_product_rev FOREIGN KEY (ProductID) REFERENCES DimProduct(ProductID),
    CONSTRAINT fk_customer_rev FOREIGN KEY (CustomerID) REFERENCES DimCustomer(CustomerID)
);
