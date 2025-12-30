CREATE DATABASE task2;
USE task2;

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    city VARCHAR(50),
    dept_id INT,
    marks INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY,
    name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Enrollments (
    enroll_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Departments VALUES
(1,'Computer Science'),
(2,'Mechanical'),
(3,'Electrical'),
(4,'Civil');

INSERT INTO Students VALUES
(1,'Amit',20,'Delhi',1,85),
(2,'Ravi',19,'Mumbai',2,72),
(3,'Ankit',22,'Delhi',1,90),
(4,'Sneha',18,'Pune',3,65),
(5,'Priya',21,'Mumbai',NULL,78),
(6,'Arjun',23,'Chennai',4,88),
(7,'Ayesha',20,'Delhi',1,92),
(8,'Rahul',17,'Jaipur',2,55);

INSERT INTO Courses VALUES
(101,'DBMS',1),
(102,'Data Structures',1),
(103,'Thermodynamics',2),
(104,'Circuits',3),
(105,'Structural Design',4);

INSERT INTO Teachers VALUES
(1,'Dr. Sharma',1),
(2,'Dr. Mehta',2),
(3,'Dr. Rao',3),
(4,'Dr. Singh',4);

INSERT INTO Enrollments VALUES
(1,1,101),
(2,1,102),
(3,2,103),
(4,3,101),
(5,3,102),
(6,7,101),
(7,7,102),
(8,6,105);

-- 1
SELECT * FROM Students;
-- 2
SELECT name, city FROM Students;
-- 3
SELECT * FROM Students WHERE age > 18;
-- 4
SELECT * FROM Students WHERE city = 'Delhi';
-- 5
SELECT * FROM Students WHERE marks >= 80;
-- 6
SELECT * FROM Students ORDER BY marks DESC;
-- 7
SELECT * FROM Students ORDER BY marks DESC LIMIT 5;
-- 8
SELECT * FROM Students ORDER BY name;
-- 9
SELECT * FROM Students WHERE age > 18 AND marks > 75;
-- 10
SELECT * FROM Students WHERE city IN ('Delhi','Mumbai');
-- 11
SELECT * FROM Students WHERE name LIKE 'A%';
-- 12
SELECT * FROM Students WHERE marks BETWEEN 60 AND 90;
-- 13
SELECT COUNT(*) FROM Students;
-- 14
SELECT AVG(marks) FROM Students;
-- 15
SELECT MAX(marks) FROM Students;
-- 16
SELECT city, COUNT(*) FROM Students GROUP BY city;
-- 17
SELECT s.name, d.dept_name FROM Students s 
JOIN Departments d ON s.dept_id=d.dept_id;
-- 18
SELECT c.course_name, d.dept_name 
FROM Courses c JOIN Departments d 
ON c.dept_id=d.dept_id;
-- 19
SELECT s.name, c.course_name FROM Students s JOIN Enrollments e ON s.student_id=e.student_id JOIN Courses c ON e.course_id=c.course_id;
-- 20
SELECT t.name, d.dept_name FROM Teachers t JOIN Departments d ON t.dept_id=d.dept_id;
-- 21
SELECT s.name, c.course_name FROM Students s JOIN Enrollments e ON s.student_id=e.student_id JOIN Courses c ON e.course_id=c.course_id JOIN Departments d ON s.dept_id=d.dept_id WHERE d.dept_name='Computer Science';
-- 22
SELECT * FROM Students WHERE dept_id IS NULL;
-- 23
SELECT d.dept_name FROM Departments d LEFT JOIN Students s ON d.dept_id=s.dept_id WHERE s.student_id IS NULL;
-- 24
SELECT d.dept_name, COUNT(s.student_id) FROM Departments d LEFT JOIN Students s ON d.dept_id=s.dept_id GROUP BY d.dept_name;
-- 25
SELECsys_configT * FROM Students WHERE marks > (SELECT AVG(marks) FROM Students);
-- 26
SELECT * FROM Students WHERE marks = (SELECT MAX(marks) FROM Students);
-- 27
SELECT * FROM Students WHERE dept_id = (SELECT dept_id FROM Students WHERE name='Ravi');
-- 28
SELECT * FROM Courses WHERE course_id IN (SELECT course_id FROM Enrollments);
-- 29
SELECT student_id FROM Enrollments GROUP BY student_id HAVING COUNT(course_id) > 1;
-- 30
SELECT d.dept_name FROM Departments d JOIN Students s ON d.dept_id=s.dept_id GROUP BY d.dept_name HAVING AVG(s.marks) > 75;
