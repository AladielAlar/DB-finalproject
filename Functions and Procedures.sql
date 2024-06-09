CREATE FUNCTION GetProductInfo(productId INT) RETURNS TABLE (
    ProductName VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10, 2),
    Stock INT
) AS $$
BEGIN
    RETURN QUERY SELECT ProductName, Description, Price, Stock FROM Products WHERE ProductID = productId;
END;
$$ LANGUAGE plpgsql;


CREATE FUNCTION CalculateOrderTotal(orderId INT) RETURNS DECIMAL(10, 2) AS $$
DECLARE
    totalAmount DECIMAL(10, 2);
BEGIN
    SELECT SUM(Quantity * Price) INTO totalAmount FROM OrderDetails WHERE OrderID = orderId;
    RETURN totalAmount;
END;
$$ LANGUAGE plpgsql;


CREATE PROCEDURE UpdateOrderStatus(
    orderId INT,
    newStatus VARCHAR(50)
) AS $$
BEGIN
    UPDATE Orders SET Status = newStatus WHERE OrderID = orderId;
END;
$$ LANGUAGE plpgsql;


CREATE PROCEDURE CreateOrder(
    userId INT,
    productId INT,
    quantity INT,
    paymentMethodId INT
) AS $$
DECLARE
    orderId INT;
BEGIN
    INSERT INTO Orders (UserID, Status) VALUES (userId, 'pending') RETURNING OrderID INTO orderId;
    
    INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price)
    VALUES (orderId, productId, quantity, (SELECT Price FROM Products WHERE ProductID = productId));
    
    INSERT INTO Transactions (OrderID, PaymentMethodID, Amount)
    VALUES (orderId, paymentMethodId, (SELECT Price * quantity FROM Products WHERE ProductID = productId));
END;
$$ LANGUAGE plpgsql;

