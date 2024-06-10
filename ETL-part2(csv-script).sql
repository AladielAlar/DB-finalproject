COPY DimDate (Date, Year, Quarter, Month, Day)
FROM 'C:\\Project2\\TempDate.csv' CSV HEADER;

COPY DimProduct (ProductID, ProductName, CategoryName, StartDate, EndDate, IsCurrent)
FROM 'C:\\Project2\\TempProduct.csv' CSV HEADER;

COPY DimCustomer (CustomerID, FirstName, LastName, Email, Address, Role, StartDate, EndDate, IsCurrent)
FROM 'C:\\Project2\\TempCustomer.csv' CSV HEADER;

COPY FactSales (DateID, ProductID, CustomerID, Quantity, TotalPrice)
FROM 'C:\\Project2\\TempSales.csv' CSV HEADER;

COPY FactReviews (DateID, ProductID, CustomerID, Rating, Comment)
FROM 'C:\\Project2\\TempReviews.csv' CSV HEADER;
