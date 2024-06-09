CREATE OR REPLACE FUNCTION UpdateProductStock() RETURNS TRIGGER AS $$
BEGIN
    UPDATE Products
    SET Stock = Stock - NEW.Quantity
    WHERE ProductID = NEW.ProductID;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER AfterOrderCreated
AFTER INSERT ON OrderDetails
FOR EACH ROW
EXECUTE FUNCTION UpdateProductStock();


CREATE OR REPLACE FUNCTION UpdateOrderStatusTrigger() RETURNS TRIGGER AS $$
BEGIN
    IF NEW.Status = 'shipped' THEN
        PERFORM UpdateOrderStatus(NEW.OrderID, 'completed');
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER AfterOrderShipped
AFTER UPDATE OF Status ON Orders
FOR EACH ROW
WHEN (NEW.Status = 'shipped')
EXECUTE FUNCTION UpdateOrderStatusTrigger();

