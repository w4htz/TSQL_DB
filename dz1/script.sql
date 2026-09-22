-- 1. СОЗДАНИЕ БАЗЫ ДАННЫХ
CREATE DATABASE ShopDB;
GO

USE ShopDB;
GO

-- 2. СОЗДАНИЕ ТАБЛИЦ

-- Таблица 1: Категории товаров
CREATE TABLE Categories (
    CategoryID INT PRIMARY KEY IDENTITY(1,1),
    CategoryName VARCHAR(50) NOT NULL
);

-- Таблица 2: Товары
CREATE TABLE Products (
    ProductID INT PRIMARY KEY IDENTITY(1,1),
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL,
    CategoryID INT FOREIGN KEY REFERENCES Categories(CategoryID)
);

-- Таблица 3: Клиенты
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE
);

-- Таблица 4: Заказы (Связана с Customers)
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY IDENTITY(1,1),
    OrderDate DATETIME DEFAULT GETDATE(),
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID)
);

-- Таблица 5: Детали заказа (Связана с Orders и Products)
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY IDENTITY(1,1),
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT NOT NULL
);

-- Таблица 6: Изолированная таблица (Логи архива, без связей)
CREATE TABLE ArchiveLogs (
    LogID INT PRIMARY KEY IDENTITY(1,1),
    LogMessage VARCHAR(255) NOT NULL,
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- 3. ЗАПОЛНЕНИЕ ТЕСТОВЫМИ ДАННЫМИ
INSERT INTO Categories (CategoryName) VALUES ('Электроника'), ('Книги');
INSERT INTO Products (ProductName, Price, CategoryID) VALUES ('Смартфон', 59999.00, 1), ('Учебник по SQL', 1200.00, 2);
INSERT INTO Customers (FirstName, LastName, Email) VALUES ('Иван', 'Иванов', 'ivan@example.com'), ('Анна', 'Петрова', 'anna@example.com');
INSERT INTO Orders (CustomerID) VALUES (1), (2);
INSERT INTO OrderItems (OrderID, ProductID, Quantity) VALUES (1, 1, 1), (2, 2, 2);
INSERT INTO ArchiveLogs (LogMessage) VALUES ('Система успешно запущена'), ('Резервное копирование завершено');
GO

-- 4. ВЫБОРКА ПО ОДНОЙ СТРОКЕ ИЗ КАЖДОЙ ТАБЛИЦЫ
SELECT TOP 1 * FROM Categories;
SELECT TOP 1 * FROM Products;
SELECT TOP 1 * FROM Customers;
SELECT TOP 1 * FROM Orders;
SELECT TOP 1 * FROM OrderItems;
SELECT TOP 1 * FROM ArchiveLogs;
GO
