USE EcommerceDB;
GO

DELETE FROM COSTUMERS;
GO

INSERT INTO COSTUMERS (
    CustomerID, FirstName, LastName, Email, Address, City, Country, PhoneNumber
    )
VALUES 
(1, 'Lia', 'Jackson', 'lia.jackson@example.com',
 '15 Main Street', 'Tokyo', 'Japan', '+8112345678'),

(2, 'Emma', 'Johnson', 'emma.johnson@example.com',
 '24 Park Road', 'Berlin', 'Germany', '+4915112345678'),

(3, 'Daniel', 'Smith', 'daniel.smith@example.com',
 '8 Oxford Street', 'London', 'United Kingdom', '+447911123456'),

(4, 'Sofia', 'Rossi', 'sofia.rossi@example.com',
 '12 Via Roma', 'Milan', 'Italy', '+393331234567'),

(5, 'Liam', 'Brown', 'liam.brown@example.com',
 '45 King Street', 'Manchester', 'United Kingdom', '+447700123456');
GO

SELECT * FROM COSTUMERS;


