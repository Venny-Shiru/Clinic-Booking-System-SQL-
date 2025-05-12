-- Clinic Booking System

-- Step 1: Create the database
CREATE DATABASE clinic_db;
USE clinic_db;

-- Step 2: Create Tables

CREATE TABLE Patients (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    DateOfBirth DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    Phone VARCHAR(15) UNIQUE,
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Doctors (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Specialty VARCHAR(100),
    Phone VARCHAR(15) UNIQUE,
    Email VARCHAR(100) UNIQUE
);

CREATE TABLE Appointments (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDateTime DATETIME NOT NULL,
    Status ENUM('Scheduled', 'Completed', 'Cancelled') DEFAULT 'Scheduled',
    Notes TEXT,
    CONSTRAINT fk_patient FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    CONSTRAINT fk_doctor FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

CREATE TABLE Rooms (
    RoomID INT AUTO_INCREMENT PRIMARY KEY,
    RoomNumber VARCHAR(10) NOT NULL UNIQUE,
    RoomType VARCHAR(50)
);

CREATE TABLE AppointmentRoom (
    AppointmentID INT,
    RoomID INT,
    PRIMARY KEY (AppointmentID, RoomID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

CREATE TABLE Prescriptions (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT NOT NULL,
    MedicineName VARCHAR(100) NOT NULL,
    Dosage VARCHAR(50),
    Duration VARCHAR(50),
    Notes TEXT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- Step 3: Sample Data

INSERT INTO Patients (FirstName, LastName, DateOfBirth, Gender, Phone, Email) VALUES
('John', 'Doe', '1990-03-15', 'Male', '555-1111', 'john.doe@example.com'),
('Jane', 'Smith', '1985-07-20', 'Female', '555-2222', 'jane.smith@example.com');

INSERT INTO Doctors (FirstName, LastName, Specialty, Phone, Email) VALUES
('Alice', 'Williams', 'Cardiology', '555-3333', 'alice.williams@example.com'),
('Bob', 'Johnson', 'Dermatology', '555-4444', 'bob.johnson@example.com');

INSERT INTO Rooms (RoomNumber, RoomType) VALUES
('101A', 'Examination'),
('202B', 'Consultation');

INSERT INTO Appointments (PatientID, DoctorID, AppointmentDateTime, Status, Notes) VALUES
(1, 1, '2025-05-15 10:00:00', 'Scheduled', 'Regular check-up'),
(2, 2, '2025-05-16 14:30:00', 'Scheduled', 'Skin rash consultation');

INSERT INTO AppointmentRoom (AppointmentID, RoomID) VALUES
(1, 1),
(2, 2);

INSERT INTO Prescriptions (AppointmentID, MedicineName, Dosage, Duration, Notes) VALUES
(1, 'Atorvastatin', '10mg', '30 days', 'Take after meals'),
(2, 'Hydrocortisone Cream', 'Apply twice daily', '7 days', 'Apply thinly to affected area');

-- Step 4: Create Roles

CREATE ROLE 'developer';
CREATE ROLE 'admin';
CREATE ROLE 'doctor';
CREATE ROLE 'receptionist';

-- Step 5: Grant Privileges

-- Developer: Full access
GRANT ALL PRIVILEGES ON clinic_db.* TO 'developer';

-- Admin: Full access
GRANT ALL PRIVILEGES ON clinic_db.* TO 'admin';

-- Doctor: Read patient & appointment data; write prescriptions
GRANT SELECT ON clinic_db.Patients TO 'doctor';
GRANT SELECT, UPDATE ON clinic_db.Appointments TO 'doctor';
GRANT INSERT, SELECT ON clinic_db.Prescriptions TO 'doctor';

-- Receptionist: Register patients & appointments
GRANT INSERT, SELECT, UPDATE ON clinic_db.Patients TO 'receptionist';
GRANT INSERT, SELECT, UPDATE ON clinic_db.Appointments TO 'receptionist';

-- Step 6: Create Users and Assign Roles

CREATE USER 'dev_user'@'localhost' IDENTIFIED BY 'DevPass123!';
GRANT 'developer' TO 'dev_user'@'localhost';

CREATE USER 'admin_user'@'localhost' IDENTIFIED BY 'AdminPass123!';
GRANT 'admin' TO 'admin_user'@'localhost';

CREATE USER 'dr_smith'@'localhost' IDENTIFIED BY 'DocPass123!';
GRANT 'doctor' TO 'dr_smith'@'localhost';

CREATE USER 'reception_user'@'localhost' IDENTIFIED BY 'ReceptionPass123!';
GRANT 'receptionist' TO 'reception_user'@'localhost';

-- Step 7: Set Default Roles

SET DEFAULT ROLE 'developer' TO 'dev_user'@'localhost';
SET DEFAULT ROLE 'admin' TO 'admin_user'@'localhost';
SET DEFAULT ROLE 'doctor' TO 'dr_smith'@'localhost';
SET DEFAULT ROLE 'receptionist' TO 'reception_user'@'localhost';

FLUSH PRIVILEGES;
