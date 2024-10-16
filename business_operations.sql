DROP DATABASE IF EXISTS nessaspetcareservices;

CREATE DATABASE nessaspetcareservices;

USE nessaspetcareservices;

# Creating my Customers table

CREATE TABLE Customers (
	Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
	First_Name VARCHAR(50) NOT NULL,
	Last_Name VARCHAR(50) NOT NULL,
	Phone_Number VARCHAR(20) NOT NULL, 
	Email_Address VARCHAR(100), 
	CONSTRAINT UQ_Contact UNIQUE (Phone_Number, Email_Address),
	INDEX Customer_Name (First_Name, Last_Name),
	INDEX Customer_Contact (Phone_Number, Email_Address)
  );

# Creating my Pets table

CREATE TABLE Pets (
	Pet_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT NOT NULL,
    Pet_Name VARCHAR(50) NOT NULL,
    Species VARCHAR(50) NOT NULL,
    Breed VARCHAR(50),
    DOB DATE NOT NULL CHECK (Age >= 0),
    Gender VARCHAR(10) NOT NULL CHECK (Gender IN ('Male', 'Female', 'Other')),
    Weight DECIMAL(5,2) NOT NULL CHECK (Weight > 0),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX idx_customerid (CustomerID)  -- Adding index to CustomerID for faster lookups
);
