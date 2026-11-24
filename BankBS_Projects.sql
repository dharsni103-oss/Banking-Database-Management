create database BankDB;
use BankDB;
create table Customers(
CustomersID int primary Key,
CustomerName varchar(50),
Age int,
City varchar(30),
Phone varchar(15)
);
CREATE TABLE Accounts (
    AccountId INT PRIMARY KEY,
    CustomerId INT,
    AccountType VARCHAR(20),
    Balance DECIMAL(12,2),
    Branch VARCHAR(30),
    FOREIGN KEY (CustomerId)
    REFERENCES Customers(CustomersID)
);
create table Transaction(
TransactionId int primary key,
AccountId int,
TransactionType varchar(20),
Amount decimal(12,2),
TransactionDate Date,
foreign key(AccountId) references Accounts(AccountId)
);
DESC Customers;
CREATE TABLE Loans (
LoanID INT PRIMARY KEY,
CustomersID INT,
LoanType VARCHAR(30),
LoanAmount DECIMAL(12,2),
InterestRate DECIMAL(5,2),
Status VARCHAR(20),
FOREIGN KEY (CustomersID) REFERENCES Customers(CustomersID)
);
INSERT INTO Customers VALUES
(101, 'Arun',28,'Madurai',9876543210),
(102,'Priya',35,'Chennai',9876543211),
(103,'Kumar',42,'Coimbatore',9876543212),
(104,'Divya',25,'Madurai',9876543213),
(105,'Ravi', 50,'Chennai',9876543214),
(106,'Meena',31,'Trichy',9876543215),
(107,'Suresh',45,'Madurai',9876543216),
(108,'Anitha', 29,'Salem',9876543217);
INSERT INTO Accounts VALUES
(1001, 101, 'Saving', 25000,'Madurai'),
(1002, 102, 'Current', 75000,'Chennai'),
(1003, 103, 'Savings', 120000, 'Coimbatore'),
(1004, 104,'Savings', 15000, 'Madurai'),
(1005, 105, 'Current', 200000, 'Chennai'),
(1006, 106, 'Savings', 45000, 'Trichy'),
(1007, 107, 'Savings', 80000, 'Madurai'),
(1008, 108, 'Current', 60000, 'Salem'),
(1009, 101, 'Fixed Deposit', 100000, 'Madurai'),
(1010, 103, 'Current', 35000, 'Coimbatore');
INSERT INTO Transaction VALUES
(1, 1001, 'Deposit', 5000, '2026-01-01'),
(2, 1001, 'Withdrawal', 2000, '2026-01-02'),
(3, 1002, 'Deposit', 10000, '2026-01-03'),
(4, 1003, 'Withdrawal', 5000, '2026-01-04'),
(5, 1004, 'Deposit', 3000, '2026-01-05'),
(6, 1005, 'Withdrawal', 15000, '2026-01-06'),
(7, 1006, 'Deposit', 7000, '2026-01-07'),
(8, 1007, 'Withdrawal', 4000, '2026-01-08'),
(9, 1008, 'Deposit', 8000, '2026-01-09'),
(10, 1009, 'Deposit', 20000, '2026-01-10'),
(11, 1002, 'Withdrawal', 3000, '2026-01-11'),
(12, 1010, 'Deposit', 6000,'2026-01-12');
select * from transaction;
INSERT INTO Loans VALUES
(201, 101,' Home Loan', 500000, 8.5, 'Approved'),
(202, 102,' Personal Loan', 100000, 12.0, 'Approved'),
(203, 103,' Car Loan', 300000, 9.0, 'Pending'),
(204, 104, 'Education Loan', 200000, 7.5,' Approved'),
(205, 105,' Home Loan', 800000, 8.0, 'Approved'),
(206, 106, 'Personal Loan', 50000, 11.5, 'Rejected'),
(207, 107, 'Car Loan', 250000, 9.5,' Pending'),
(208, 108, 'Education Loan', 150000, 7.0, 'Approved');
select * from customers;
select CustomerName,City from customers;
select * from customers where city='Madurai';
select * from customers where age >30;
select * from customers where age between 25 and 40;
select * from customers where customername like "A%";
select * from Accounts where AccountType ="Savings";
set sql_safe_updates=0;
SELECT * FROM Accounts;
UPDATE Accounts SET AccountType = 'Savings' WHERE AccountId = 1001;
select * from Accounts where balance > 50000; 
select * from Transaction where TransactionType = 'Deposit';
select * from loans where status ="Approved";
DESC Customers;
DESC Accounts;
SELECT Customers.CustomerName, Accounts.Balance FROM Customers INNER JOIN Accounts ON Customers.CustomersID = Accounts.CustomerId;
SELECT Customers.CustomerName, Accounts.Balance FROM Customers LEFT JOIN Accounts ON Customers.CustomersID = Accounts.CustomerId;
SELECT Customers.CustomerName, Accounts.Balance FROM Customers RIGHT JOIN Accounts ON Customers.CustomersID = Accounts.CustomerId;
SELECT Customers.CustomerName, Accounts.AccountType, Accounts.Branch FROM Customers INNER JOIN Accounts ON Customers.CustomersID = Accounts.CustomerId;
SELECT Customers.CustomerName,Loans. * FROM Customers INNER JOIN Loans ON Customers.CustomersID = Loans.CustomersID;
SELECT SUM(Balance) AS Total_Balance FROM Accounts;
SELECT AVG(Balance) AS Average_Balance FROM Accounts;
SELECT MAX(Balance) AS Maximum_Balance, MIN(Balance) AS Minimum_Balance FROM Accounts;
SELECT City, COUNT(*) AS Total_Customers FROM Customers GROUP BY City;
SELECT AccountType, SUM(Balance) AS Total_Balance FROM Accounts GROUP BY AccountType;
SELECT AccountId, SUM(Amount) AS Total_Deposit FROM Transaction WHERE TransactionType = 'Deposit' GROUP BY AccountId;
SELECT CustomerId, COUNT(*) AS Total_Accounts FROM Accounts GROUP BY CustomerId HAVING COUNT(*) > 1;
SELECT Customers.CustomerName, Accounts.Balance
FROM Customers
INNER JOIN Accounts
ON Customers.CustomersID = Accounts.CustomerId
WHERE Accounts.Balance > (
    SELECT AVG(Balance)
    FROM Accounts
);
SELECT Customers.CustomerName, Accounts.Balance
FROM Customers
INNER JOIN Accounts
ON Customers.CustomersID = Accounts.CustomerId
WHERE Accounts.Balance = (
    SELECT MAX(Balance)
    FROM Accounts
);
SELECT Customers.CustomerName, Loans.* FROM Customers INNER JOIN Loans ON Customers.CustomersID = Loans.CustomersID WHERE Loans.LoanAmount > 200000;
SELECT DISTINCT Customers.CustomerName
FROM Customers
INNER JOIN Accounts
ON Customers.CustomersID = Accounts.CustomerId
WHERE Customers.CustomersID NOT IN (
    SELECT AccountId
    FROM Transaction
    WHERE TransactionType = 'Withdrawal'
);
SELECT DISTINCT Customers.CustomerName
FROM Customers
INNER JOIN Accounts
ON Customers.CustomersID = Accounts.CustomerId
WHERE Customers.CustomersID NOT IN (
    SELECT Accounts.CustomerId
    FROM Accounts
    INNER JOIN Transaction
    ON Accounts.AccountId = Transaction.AccountId
    WHERE Transaction.TransactionType = 'Withdrawal'
);
SELECT Customers.CustomerName,
       SUM(DISTINCT Accounts.Balance) AS Total_Balance,
       SUM(DISTINCT Loans.LoanAmount) AS Total_Loan
FROM Customers
LEFT JOIN Accounts
ON Customers.CustomersID = Accounts.CustomerId
LEFT JOIN Loans
ON Customers.CustomersID = Loans.CustomersID
GROUP BY Customers.CustomersID, Customers.CustomerName;
SELECT Customers.CustomerName,
       COALESCE(A.Total_Balance, 0) AS Total_Balance,
       COALESCE(L.Total_Loan, 0) AS Total_Loan
FROM Customers
LEFT JOIN (
    SELECT CustomerId, SUM(Balance) AS Total_Balance
    FROM Accounts
    GROUP BY CustomerId
) A ON Customers.CustomersID = A.CustomerId
LEFT JOIN (
    SELECT CustomerId, SUM(LoanAmount) AS Total_Loan
    FROM Loans
    GROUP BY CustomerId
) L ON Customers.CustomersID = L.CustomerId;
DESC Customers;
DESC Accounts;
DESC Loans;
SELECT Customers.CustomerName,
       COALESCE(A.Total_Balance, 0) AS Total_Balance,
       COALESCE(L.Total_Loan, 0) AS Total_Loan
FROM Customers

LEFT JOIN (
    SELECT CustomerId, SUM(Balance) AS Total_Balance
    FROM Accounts
    GROUP BY CustomerId
) A
ON Customers.CustomersID = A.CustomerId

LEFT JOIN (
    SELECT CustomersID, SUM(LoanAmount) AS Total_Loan
    FROM Loans
    GROUP BY CustomersID
) L
ON Customers.CustomersID = L.CustomersID;