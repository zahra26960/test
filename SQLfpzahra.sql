/*eCommerce Database
This simple database is designed for small eCommerce sites.
It includes tables for users, products, orders, and order items.
Additionally, it features views to simplify common queries such as
product listings and order summaries.*/
CREATE TABLE Users (
    
	user_id SERIAL PRIMARY KEY,
    Username VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    PasswordHash CHAR(64) NOT NULL,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create Products table
CREATE TABLE Products (
   product_id SERIAL PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Description TEXT,
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT NOT NULL
);

-- Create Orders table
CREATE TABLE Orders (
    order_id SERIAL PRIMARY KEY,
    user_id INT,
	status VARCHAR(50),
    OrderDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Create Order_Details table
CREATE TABLE Order_Details (
	order_details_id SERIAL PRIMARY KEY,
     order_id INT,
    product_id INT,
    Quantity INT NOT NULL,
    PriceAtPurchase DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY ( order_id) REFERENCES Orders( order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
-- View for listing all products
CREATE VIEW ProductListView AS
SELECT product_id, name, description, price
FROM Products;

-- View for summarizing orders

CREATE VIEW OrderSummaryView AS
SELECT O.order_id, O.OrderDate, O.status, O.TotalAmount, U.Username AS customer_name
FROM Orders O
JOIN Users U ON O.user_id = U.user_id;