create database hospitalManagement;

use hospitalManagement;


-- PATIENTS TABLE
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    dob DATE,
    gender VARCHAR(10),
    phone_number VARCHAR(20),
    email VARCHAR(100),
    address VARCHAR(255),
    registration_date DATE
);

INSERT INTO Patients VALUES
(1, 'Amit Sharma', '1990-05-10', 'Male', '9876543210', 'amit@gmail.com', 'Delhi', '2023-02-10'),
(2, 'Priya Singh', '1992-08-15', 'Female', '9876501234', 'priya@gmail.com', 'Mumbai', '2023-04-12'),
(3, 'Rohan Mehta', '1985-01-20', 'Male', NULL, 'rohan@gmail.com', 'Pune', '2022-11-05'),
(4, 'Sneha Kapoor', '1998-03-22', 'Female', '9123456780', 'sneha@gmail.com', 'Delhi', '2024-01-15');

-- DOCTORS TABLE
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(100),
    phone_number VARCHAR(20),
    email VARCHAR(100),
    available_days VARCHAR(50),
    consultation_fee INT,
    experience INT
);

INSERT INTO Doctors VALUES
(1, 'Dr. Verma', 'Cardiology', '9988776655', 'verma@gmail.com', 'Mon-Fri', 1500, 18),
(2, 'Dr. Ritu', 'Neurology', '8877665544', 'ritu@gmail.com', 'Tue-Sat', 1200, 10),
(3, 'Dr. Karan', 'Dermatology', NULL, 'karan@gmail.com', 'Mon-Wed', 900, 4);


-- DEPARTMENTS TABLE
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

INSERT INTO Departments VALUES
(1, 'Cardiology'),
(2, 'Neurology'),
(3, 'Dermatology');


-- DOCTOR_DEPARTMENT (MAPPING TABLE)
CREATE TABLE Doctor_Department (
    doctor_id INT,
    department_id INT,
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

INSERT INTO Doctor_Department VALUES
(1, 1),
(2, 2),
(3, 3);

-- APPOINTMENTS TABLE
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

INSERT INTO Appointments VALUES
(1, 1, 1, '2024-02-10', 'Completed'),
(2, 2, 2, '2024-03-05', 'Scheduled'),
(3, 3, 3, '2023-12-15', 'Cancelled'),
(4, 4, 1, '2024-01-20', 'Completed');

-- MEDICAL RECORDS TABLE
CREATE TABLE Medical_Records (
    record_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    diagnosis VARCHAR(255),
    prescription VARCHAR(255),
    treatment_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

INSERT INTO Medical_Records VALUES
(1, 1, 1, 'Heart Pain', 'Medicine A', '2024-02-10'),
(2, 1, 1, 'Follow Up', 'Medicine B', '2024-03-01'),
(3, 2, 2, 'Migraine', 'Medicine C', '2024-03-05'),
(4, 4, 1, 'Chest Infection', 'Medicine D', '2024-01-20');

-- BILLING TABLE
CREATE TABLE Billing (
    invoice_id INT PRIMARY KEY,
    patient_id INT,
    appointment_id INT,
    amount INT,
    payment_status VARCHAR(20),
    payment_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

INSERT INTO Billing VALUES
(1, 1, 1, 2500, 'Paid', '2024-02-11'),
(2, 2, 2, 1200, 'Pending', NULL),
(3, 4, 4, 1500, 'Paid', '2024-01-21');




INSERT INTO Patients 
VALUES (5, 'New Patient', '2000-05-01', 'Male', '9999999999', 'new@gmail.com', 'Jaipur', CURDATE());


UPDATE Patients 
SET address='Kolkata'
WHERE patient_id=2;

DELETE FROM Appointments
WHERE status='Cancelled'
AND appointment_date < DATE_SUB(CURDATE(), INTERVAL 6 MONTH);

SELECT * FROM Patients
WHERE registration_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR);

SELECT patient_id, SUM(amount) AS total_spent
FROM Billing
GROUP BY patient_id
ORDER BY total_spent DESC
LIMIT 5;


SELECT * FROM Doctors 
WHERE consultation_fee > 1000;

SELECT * FROM Appointments
WHERE status='Scheduled' AND doctor_id=3;

SELECT * FROM Doctors
WHERE specialization='Cardiology' OR specialization='Neurology';

SELECT * FROM Patients
WHERE patient_id NOT IN (
    SELECT patient_id FROM Appointments
    WHERE appointment_date >= DATE_SUB(CURDATE(), INTERVAL 1 YEAR)
);

SELECT * FROM Doctors ORDER BY specialization;

SELECT doctor_id, COUNT(*) AS total_patients
FROM Appointments
GROUP BY doctor_id;


SELECT d.department_name, SUM(b.amount) AS total_revenue
FROM Billing b
JOIN Appointments a ON b.appointment_id = a.appointment_id
JOIN Doctor_Department dd ON a.doctor_id = dd.doctor_id
JOIN Departments d ON dd.department_id = d.department_id
GROUP BY d.department_name;


SELECT SUM(amount) AS total_revenue FROM Billing;

SELECT doctor_id, COUNT(*) AS total_visits
FROM Appointments
GROUP BY doctor_id
ORDER BY total_visits DESC
LIMIT 1;

SELECT AVG(consultation_fee) AS avg_fee FROM Doctors;

SELECT d.name, d.specialization, dept.department_name
FROM Doctors d
INNER JOIN Doctor_Department dd ON d.doctor_id = dd.doctor_id
INNER JOIN Departments dept ON dd.department_id = dept.department_id;

SELECT p.name, a.appointment_date
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id AND a.status='Completed';


SELECT a.appointment_id, b.invoice_id
FROM Appointments a
RIGHT JOIN Billing b ON a.appointment_id = b.appointment_id
WHERE b.invoice_id IS NULL;


SELECT p.patient_id, p.name, a.appointment_id
FROM Patients p
LEFT JOIN Appointments a ON p.patient_id = a.patient_id

UNION

SELECT p.patient_id, p.name, a.appointment_id
FROM Patients p
RIGHT JOIN Appointments a ON p.patient_id = a.patient_id;

SELECT doctor_id
FROM Appointments
GROUP BY doctor_id
HAVING COUNT(*) > 50;

SELECT patient_id, SUM(amount) AS total
FROM Billing
GROUP BY patient_id
ORDER BY total DESC
LIMIT 1;

SELECT *
FROM Appointments
WHERE doctor_id IN (
    SELECT doctor_id FROM Doctors WHERE specialization='Dermatology'
);

SELECT MONTH(appointment_date) AS month, COUNT(*) AS visits
FROM Appointments
GROUP BY MONTH(appointment_date);

SELECT DATEDIFF(discharge_date, admission_date) AS stay_days
FROM Medical_Records;

SELECT DATE_FORMAT(treatment_date, '%d-%m-%Y') AS formatted_date
FROM Medical_Records;

SELECT UPPER(name) FROM Patients;

SELECT TRIM(name) FROM Doctors;

SELECT COALESCE(phone_number, 'Not Available') FROM Patients;

SELECT doctor_id, COUNT(*) AS total,
RANK() OVER (ORDER BY COUNT(*) DESC) AS ranking
FROM Appointments
GROUP BY doctor_id;

SELECT MONTH(payment_date) AS month,
SUM(amount) AS revenue,
SUM(SUM(amount)) OVER (ORDER BY MONTH(payment_date)) AS cumulative_revenue
FROM Billing
WHERE payment_status='Paid'
GROUP BY MONTH(payment_date);

SELECT appointment_date,
COUNT(*) OVER (ORDER BY appointment_date ROWS UNBOUNDED PRECEDING) AS running_total
FROM Appointments;

SELECT patient_id,
CASE
    WHEN COUNT(*) > 5 THEN 'High'
    WHEN COUNT(*) BETWEEN 3 AND 5 THEN 'Medium'
    ELSE 'Low'
END AS patient_risk_level
FROM Medical_Records
GROUP BY patient_id;

SELECT doctor_id, name, experience,
CASE
    WHEN experience > 15 THEN 'Senior'
    WHEN experience BETWEEN 5 AND 15 THEN 'Mid-Level'
    ELSE 'Junior'
END AS doctor_category
FROM Doctors;





