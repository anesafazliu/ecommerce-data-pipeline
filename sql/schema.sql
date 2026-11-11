CREATE DATABASE EcommerceDB;
GO

USE EcommerceDB;
GO

CREATE TABLE COSTUMERS (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Address VARCHAR(200) NOT NULL,
    City VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL
);
GO

CREATE TABLE CATEGORIES 
(
    CategoryID INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(200) NULL,
    ParentCategoryID INT NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE()

    CONSTRAINT FK_Categories_Parent
    FOREIGN KEY (ParentCategoryID) 
    REFERENCES CATEGORIES(CategoryID)
);
GO

CREATE TABLE PRODUCTS
(
    ProductId INT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL,
    Description VARCHAR(300) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    StockQuality INT NOT NULL,
    Supplier VARCHAR(100) NOT NULL,
    SKU VARCHAR(50) NOT NULL UNIQUE,
    IsActive BIT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT CK_Products_Price
    CHECK (Price >=0),

    CONSTRAINT CK_Products_Stock
    CHECK (StockQuality >= 0)
);
GO

CREATE TABLE ProductCategories
(
    ProductId INT NOT NULL,
    CategoryID INT NOT NULL,
    PRIMARY KEY (ProductId, CategoryID),

    FOREIGN KEY (ProductId) REFERENCES PRODUCTS(ProductId),
    FOREIGN KEY (CategoryID) REFERENCES CATEGORIES(CategoryID)
);
GO

CREATE TABLE PAYMENTS
( 
    PaymentID INT PRIMARY KEY,
    PaymentDate DATETIME NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    StatusPayment VARCHAR(30) NOT NULL,
    TransactionID VARCHAR(100) NOT NULL UNIQUE,
    Currency VARCHAR(10) NOT NULL,

    CHECK (Amount >= 0)
);
GO

CREATE TABLE ORDERS
(
    OrderID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    PaymentID INT NOT NULL,
    OrderDate DATETIME NOT NULL,
    StatusOrder VARCHAR(30) NOT NULL,

    ShippingAddress VARCHAR(200) NOT NULL,
    SgippingCity VARCHAR(50) NOT NULL,
    ShippingCountry VARCHAR(50) NOT NULL,
    
    ShippingCost DECIMAL(10,2) NOT NULL,
    DiscountAmount DECIMAL(10,2) NOT NULL DEFAULT 0,
    TaxAmount DECIMAL(10,2) NOT NULL DEFAULT 0,
    TotalAmount DECIMAL(10,2) NOT NULL,

    UpdatedAt DATETIME NOT NULL DEFAULT GETDATE(),

    FOREIGN KEY (CustomerID) REFERENCES COSTUMERS(CustomerID),
    FOREIGN KEY (PaymentID) REFERENCES PAYMENTS(PaymentID)
);
GO

CREATE TABLE OrderItes
(
    OrderItemID INT PRIMARY KEY,
    OrderID INT NOT NULL,
    ProductId INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    Discount DECIMAL(10,2) NOT NULL,

    FOREIGN KEY (OrderID) REFERENCES ORDERS(OrderID),
    FOREIGN KEY (ProductID) REFERENCES PRODUCTS(ProductId),

    CHECK (Quantity > 0),
    CHECK (UnitPrice >= 0),
    CHECK (Discount >= 0)
);
GO
