# 🎓 University Management System

## Project Description

The University Management System is a relational database developed to manage the academic and administrative processes of a university.

The system stores information about faculties, academic programs, semesters, students, professors, subjects, enrollments, classrooms, course assignments, academic periods, and grades.

The database was designed following normalization principles up to the Third Normal Form (3NF), ensuring data integrity and minimizing redundancy.

---

# Technologies Used

- PostgreSQL
- SQL
- pgAdmin 4
- Git
- GitHub

---

# Database Engine

PostgreSQL

---

# Database Normalization

The database was normalized up to the Third Normal Form (3NF).

## First Normal Form (1NF)

- Each table has a primary key.
- Attributes contain atomic values.
- No repeating groups exist.

## Second Normal Form (2NF)

- Every non-key attribute depends entirely on the primary key.
- Partial dependencies were removed.

## Third Normal Form (3NF)

- Transitive dependencies were eliminated.
- Independent entities such as faculties, programs, semesters, academic periods, and classrooms were separated into different tables.

---

# Database Structure

The project includes the following tables:

- Faculties
- Programs
- Semesters
- Students
- Professors
- Subjects
- Academic Periods
- Enrollments
- Classrooms
- Course Assignments
- Student Subjects
- Grades

---

# Entity Relationship Model (ERM)

The database establishes the following relationships:

- One faculty has many programs.
- One program has many students.
- One program has many subjects.
- One semester contains many subjects.
- One academic period has many enrollments.
- One student can enroll in many subjects.
- One professor can teach many subjects.
- One classroom can host many course assignments.
- One student subject enrollment has one grade.

---

# Installation Instructions

1. Install PostgreSQL.
2. Install pgAdmin 4.
3. Create a database named **university_db**.
4. Execute the SQL script containing the table creation.
5. Execute the INSERT statements.
6. Run the SQL queries.

---

# Database Creation

The project was created using SQL Data Definition Language (DDL).

The implementation includes:

- CREATE DATABASE
- CREATE TABLE
- PRIMARY KEY
- FOREIGN KEY
- UNIQUE
- CHECK
- NOT NULL

---

# Data Loading Process

The data was inserted in the following order:

1. Faculties
2. Programs
3. Semesters
4. Professors
5. Subjects
6. Academic Periods
7. Classrooms
8. Students
9. Enrollments
10. Course Assignments
11. Student Subjects
12. Grades

This order guarantees referential integrity.

---

# SQL Queries Explanation

The project contains SQL queries to:

- Display students by faculty.
- Display students by academic program.
- Display subjects by semester.
- Display subjects by program.
- Display professors assigned to each subject.
- Count students enrolled by academic period.
- Calculate the average grade by subject.
- Show the top five students.
- Display the most enrolled subjects.
- Show professors teaching multiple subjects.
- Display classroom information.
- Display students and their enrolled subjects.
- Calculate the average grade by program.
- Show the highest final grades.
- Generate a complete academic report.

---

# SQL Operations

The project also demonstrates the use of:

- INSERT
- UPDATE
- DELETE
- ALTER TABLE
- CREATE VIEW
- CREATE INDEX
- BEGIN
- COMMIT
- ROLLBACK

---

# Business Rules

- Every program belongs to one faculty.
- Every subject belongs to one academic program.
- Every subject is assigned to one semester.
- Every student belongs to one academic program.
- Every enrollment belongs to one academic period.
- Every course assignment links one professor with one subject.
- Grades can only be recorded for enrolled subjects.
- Credits must be greater than zero.
- Final grades must be between 0.0 and 5.0.

---

# Developer Information

**Full Name:** Kerlys Bello D.

**Clan:** ______________________

**Course:** Software Development

**Database Engine:** PostgreSQL

**Language:** SQL

---

# Repository Structure

University-Management-System/

│── university.sql

│── inserts.sql

│── queries.sql

│── views.sql

│── README.md

│── ERD.png

---

# Author

Developed by **Kerlys Bello D.**
