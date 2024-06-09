
CREATE ROLE admin;

CREATE ROLE customer;

GRANT ALL PRIVILEGES ON TABLE Users, Categories, Products, Orders, OrderDetails, Reviews, PaymentMethods, Transactions TO admin;

GRANT SELECT ON TABLE Users, Categories, Products, Orders, OrderDetails, Reviews, PaymentMethods TO customer;
