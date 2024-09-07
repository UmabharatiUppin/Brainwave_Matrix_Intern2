CREATE DATABASE HospitalManagement;
USE HospitalManagement;

-- Create Departments table
CREATE TABLE Departments (
  Dept_ID INT(10) PRIMARY KEY,
  Dept_Name VARCHAR(100),
  Location VARCHAR(100)
);

-- Create Doctors table
CREATE TABLE Doctors (
  Doctor_ID INT(10) PRIMARY KEY,
  First_Name VARCHAR(50),
  Last_Name VARCHAR(50),
  Phone_Number VARCHAR(20),
  Email VARCHAR(50),
  Dept_ID INT(10),
  Hire_Date DATE,
  FOREIGN KEY (Dept_ID) REFERENCES Departments(Dept_ID)
);

-- Create Patients table
CREATE TABLE Patients (
  Patient_ID INT(10) PRIMARY KEY,
  First_Name VARCHAR(50),
  Last_Name VARCHAR(50),
  Phone_Number VARCHAR(20),
  Email VARCHAR(50),
  Gender VARCHAR(10),
  DOB DATE,
  Address1 VARCHAR(50),
  Address2 VARCHAR(50),
  City VARCHAR(50),
  State VARCHAR(50),
  Pincode VARCHAR(10),
  Registration_Date DATE
);

-- Create Appointments table
CREATE TABLE Appointments (
  Appointment_ID INT(10) PRIMARY KEY,
  Doctor_ID INT(10),
  Patient_ID INT(10),
  Appointment_Date DATE,
  Appointment_Time TIME,
  Status VARCHAR(20),
  FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Doctor_ID),
  FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID)
);

-- Create MedicalRecords table
CREATE TABLE MedicalRecords (
  Record_ID INT(10) PRIMARY KEY,
  Patient_ID INT(10),
  Diagnosis VARCHAR(100),
  Treatment VARCHAR(100),
  Record_Date DATE,
  Doctor_ID INT(10),
  FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
  FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Doctor_ID)
);

-- Create Prescriptions table
CREATE TABLE Prescriptions (
  Prescription_ID INT(10) PRIMARY KEY,
  Patient_ID INT(10),
  Doctor_ID INT(10),
  Medication VARCHAR(100),
  Dosage VARCHAR(50),
  Prescription_Date DATE,
  FOREIGN KEY (Patient_ID) REFERENCES Patients(Patient_ID),
  FOREIGN KEY (Doctor_ID) REFERENCES Doctors(Doctor_ID)
);

-- Create Nurses table
CREATE TABLE Nurses (
  Nurse_ID INT(10) PRIMARY KEY,
  First_Name VARCHAR(50),
  Last_Name VARCHAR(50),
  Phone_Number VARCHAR(20),
  Email VARCHAR(50),
  Dept_ID INT(10),
  Hire_Date DATE,
  FOREIGN KEY (Dept_ID) REFERENCES Departments(Dept_ID)
);

-- Insert values into Departments table
INSERT INTO Departments (Dept_ID, Dept_Name, Location)
VALUES 
(1, 'Cardiology', 'Building A'),
(2, 'Neurology', 'Building B'),
(3, 'Oncology', 'Building C');

-- Insert values into Doctors table
INSERT INTO Doctors (Doctor_ID, First_Name, Last_Name, Phone_Number, Email, Dept_ID, Hire_Date)
VALUES 
(1, 'John', 'Doe', '555-1234', 'john.doe@hospital.com', 1, '2020-05-10'),
(2, 'Jane', 'Smith', '555-5678', 'jane.smith@hospital.com', 2, '2021-01-15'),
(3, 'Emily', 'Davis', '555-9876', 'emily.davis@hospital.com', 3, '2019-08-20');

-- Insert values into Patients table
INSERT INTO Patients (Patient_ID, First_Name, Last_Name, Phone_Number, Email, Gender, DOB, Address1, Address2, City, State, Pincode, Registration_Date)
VALUES 
(1, 'Mike', 'Johnson', '555-4321', 'mike.johnson@example.com', 'Male', '1985-09-12', '456 Oak St', '', 'Metropolis', 'NY', '10001', '2024-08-01'),
(2, 'Sara', 'Parker', '555-6789', 'sara.parker@example.com', 'Female', '1992-03-08', '789 Pine St', '', 'Gotham', 'NJ', '07001', '2024-07-20');

-- Insert values into Appointments table
INSERT INTO Appointments (Appointment_ID, Doctor_ID, Patient_ID, Appointment_Date, Appointment_Time, Status)
VALUES 
(1, 1, 1, '2024-09-15', '10:00:00', 'Scheduled'),
(2, 2, 2, '2024-09-18', '11:30:00', 'Scheduled');

-- Insert values into MedicalRecords table
INSERT INTO MedicalRecords (Record_ID, Patient_ID, Diagnosis, Treatment, Record_Date, Doctor_ID)
VALUES 
(1, 1, 'High Blood Pressure', 'Medication A', '2024-08-02', 1),
(2, 2, 'Migraine', 'Medication B', '2024-07-21', 2);

-- Insert values into Prescriptions table
INSERT INTO Prescriptions (Prescription_ID, Patient_ID, Doctor_ID, Medication, Dosage, Prescription_Date)
VALUES 
(1, 1, 1, 'Medication A', '2 times/day', '2024-08-02'),
(2, 2, 2, 'Medication B', '1 time/day', '2024-07-21');

-- Insert values into Nurses table
INSERT INTO Nurses (Nurse_ID, First_Name, Last_Name, Phone_Number, Email, Dept_ID, Hire_Date)
VALUES 
(1, 'Alice', 'Brown', '555-6543', 'alice.brown@hospital.com', 1, '2022-06-01'),
(2, 'Bob', 'Martin', '555-7890', 'bob.martin@hospital.com', 2, '2023-04-15');

-- Queries:

-- 1. Retrieve all doctors working in the 'Cardiology' department.
SELECT d.First_Name, d.Last_Name
FROM Doctors d
JOIN Departments dept ON d.Dept_ID = dept.Dept_ID
WHERE dept.Dept_Name = 'Cardiology';

-- 2. Find the total number of appointments each doctor has.
SELECT d.First_Name, d.Last_Name, COUNT(a.Appointment_ID) AS Total_Appointments
FROM Doctors d
JOIN Appointments a ON d.Doctor_ID = a.Doctor_ID
GROUP BY d.Doctor_ID;

-- 3. List all patients who have upcoming appointments.
SELECT p.First_Name, p.Last_Name, a.Appointment_Date
FROM Patients p
JOIN Appointments a ON p.Patient_ID = a.Patient_ID
WHERE a.Appointment_Date > CURDATE();

-- 4. Calculate the total number of patients registered in the hospital.
SELECT COUNT(*) AS Total_Patients
FROM Patients;

-- 5. Retrieve all nurses who were hired after January 2023.
SELECT First_Name, Last_Name, Hire_Date
FROM Nurses
WHERE Hire_Date > '2023-01-01';

-- 6. Find all medical records for a specific patient.
SELECT mr.Diagnosis, mr.Treatment, mr.Record_Date
FROM MedicalRecords mr
JOIN Patients p ON mr.Patient_ID = p.Patient_ID
WHERE p.First_Name = 'Mike' AND p.Last_Name = 'Johnson';

-- 7. List all patients and their prescribed medications.
SELECT p.First_Name, p.Last_Name, pr.Medication, pr.Dosage
FROM Patients p
JOIN Prescriptions pr ON p.Patient_ID = pr.Patient_ID;

-- 8. Find the total number of doctors in each department.
SELECT dept.Dept_Name, COUNT(d.Doctor_ID) AS Total_Doctors
FROM Departments dept
JOIN Doctors d ON dept.Dept_ID = d.Dept_ID
GROUP BY dept.Dept_Name;

-- 9. Retrieve the most recent appointment for each doctor.
SELECT d.First_Name, d.Last_Name, MAX(a.Appointment_Date) AS Latest_Appointment
FROM Doctors d
JOIN Appointments a ON d.Doctor_ID = a.Doctor_ID
GROUP BY d.Doctor_ID;

-- 10. Find the total number of appointments scheduled for a specific day.
SELECT COUNT(*) AS Total_Appointments
FROM Appointments
WHERE Appointment_Date = '2024-09-15';
