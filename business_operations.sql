DROP DATABASE IF EXISTS nessaspetcareservices;

CREATE DATABASE nessaspetcareservices;

USE nessaspetcareservices;

# Creating the Customers table

CREATE TABLE Customers (
	Customer_ID INT PRIMARY KEY AUTO_INCREMENT,
	First_Name VARCHAR(50) NOT NULL,
	Last_Name VARCHAR(50) NOT NULL,
	Phone_Number VARCHAR(20) NOT NULL, 
	Email_Address VARCHAR(100), 
	CONSTRAINT UQ_Contact UNIQUE (Phone_Number, Email_Address), -- Unique phone # and email per customer 
	INDEX Customer_Name (First_Name, Last_Name), -- Index on customer full name for faster queries
	INDEX Customer_Contact (Phone_Number, Email_Address) -- Index on customer contact for faster queries
  );

# Creating the Pets table

CREATE TABLE Pets (
	Pet_ID INT PRIMARY KEY AUTO_INCREMENT,
    Customer_ID INT NOT NULL,
    Pet_Name VARCHAR(50) NOT NULL,
    Species VARCHAR(50) NOT NULL,
    Breed VARCHAR(50),
    DOB DATE NOT NULL,
    Gender VARCHAR(10) NOT NULL CHECK (Gender IN ('Male', 'Female', 'Other')), -- Check keyword restricts various different answers
    Weight DECIMAL(5,2) NOT NULL CHECK (Weight > 0), -- Checks to make sure weight is above 0 and no negatives get inserted
    FOREIGN KEY (Customer_ID) REFERENCES Customers(Customer_ID) ON DELETE RESTRICT ON UPDATE CASCADE
);

# Creating the Services table

CREATE TABLE Services (
    Service_ID INT PRIMARY KEY AUTO_INCREMENT,
    Service_Name VARCHAR(150) NOT NULL UNIQUE,
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0), -- Ensuring no negative prices
    Category VARCHAR(50) NOT NULL CHECK (Category IN ('Grooming', 'Boarding', 'Walking', 'Training')) -- Restrict categories to specific types
);

# Creating Appointments table

CREATE TABLE Appointments (
    Appointment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Pet_ID INT NOT NULL,
    Service_ID INT NOT NULL,
    Appointment_Date DATE NOT NULL,
    Appointment_Time TIME NOT NULL,
    Status VARCHAR(20) NOT NULL DEFAULT 'Scheduled' CHECK (Status IN ('Scheduled', 'Completed', 'Canceled')), -- Added a default so all appts get added as scheduled, it can be updated later
    Notes TEXT, -- Optional notes field
    FOREIGN KEY (Pet_ID) REFERENCES Pets(Pet_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (Service_ID) REFERENCES Services(Service_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
    INDEX Appointment_Search (Appointment_Date, Pet_ID)  -- Index to improve search performance on appointment dates
);
