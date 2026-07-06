
/*CREATE DATABASE*/

CREATE DATABASE university_db;

-- Conectarse a la base de datos university_db antes de
-- ejecutar el resto del script.


/*TABLE: FACULTIES*/

CREATE TABLE faculties (

    id_faculty SERIAL PRIMARY KEY,

    faculty_name VARCHAR(100) UNIQUE NOT NULL

);


/*TABLE: PROGRAMS*/

CREATE TABLE programs (

    id_program SERIAL PRIMARY KEY,

    program_name VARCHAR(120) UNIQUE NOT NULL,

    id_faculty INT NOT NULL,

    FOREIGN KEY (id_faculty)
    REFERENCES faculties(id_faculty)

);


/*TABLE: SEMESTERS*/

CREATE TABLE semesters (

    id_semester SERIAL PRIMARY KEY,

    semester_number INT UNIQUE NOT NULL
    CHECK (semester_number BETWEEN 1 AND 10)

);


/*TABLE: STUDENTS*/

CREATE TABLE students (

    id_student SERIAL PRIMARY KEY,

    first_name VARCHAR(80) NOT NULL,

    last_name VARCHAR(80) NOT NULL,

    email VARCHAR(120) UNIQUE NOT NULL,

    phone VARCHAR(20),

    birth_date DATE NOT NULL,

    id_program INT NOT NULL,

    FOREIGN KEY (id_program)
    REFERENCES programs(id_program)

);


/*TABLE: PROFESSORS*/

CREATE TABLE professors (

    id_professor SERIAL PRIMARY KEY,

    first_name VARCHAR(80) NOT NULL,

    last_name VARCHAR(80) NOT NULL,

    email VARCHAR(120) UNIQUE NOT NULL,

    phone VARCHAR(20),

    specialization VARCHAR(120)

);

/*TABLE: SUBJECTS*/

CREATE TABLE subjects (

    id_subject SERIAL PRIMARY KEY,

    subject_name VARCHAR(120) NOT NULL,

    credits INT NOT NULL
    CHECK (credits > 0),

    id_program INT NOT NULL,

    id_semester INT NOT NULL,

    FOREIGN KEY (id_program)
    REFERENCES programs(id_program),

    FOREIGN KEY (id_semester)
    REFERENCES semesters(id_semester)

);


/*TABLE: ACADEMIC PERIODS*/

CREATE TABLE academic_periods (

    id_period SERIAL PRIMARY KEY,

    period_name VARCHAR(20) UNIQUE NOT NULL,

    start_date DATE NOT NULL,

    end_date DATE NOT NULL,

    CHECK (end_date > start_date)

);


/*TABLE: CLASSROOMS*/

CREATE TABLE classrooms (

    id_classroom SERIAL PRIMARY KEY,

    building VARCHAR(50) NOT NULL,

    room_number VARCHAR(20) NOT NULL,

    capacity INT NOT NULL
    CHECK (capacity > 0)

);


/*TABLE: ENROLLMENTS*/

CREATE TABLE enrollments (

    id_enrollment SERIAL PRIMARY KEY,

    enrollment_date DATE NOT NULL,

    id_student INT NOT NULL,

    id_period INT NOT NULL,

    id_semester INT NOT NULL,

    FOREIGN KEY (id_student)
    REFERENCES students(id_student),

    FOREIGN KEY (id_period)
    REFERENCES academic_periods(id_period),

    FOREIGN KEY (id_semester)
    REFERENCES semesters(id_semester)

);


/*TABLE: COURSE ASSIGNMENTS-Which professor teaches which subject*/

CREATE TABLE course_assignments (

    id_assignment SERIAL PRIMARY KEY,

    id_professor INT NOT NULL,

    id_subject INT NOT NULL,

    id_period INT NOT NULL,

    id_classroom INT NOT NULL,

    FOREIGN KEY (id_professor)
    REFERENCES professors(id_professor),

    FOREIGN KEY (id_subject)
    REFERENCES subjects(id_subject),

    FOREIGN KEY (id_period)
    REFERENCES academic_periods(id_period),

    FOREIGN KEY (id_classroom)
    REFERENCES classrooms(id_classroom)

);


/*TABLE: STUDENT SUBJECTS. Subjects enrolled by each student*/

CREATE TABLE student_subjects (

    id_student_subject SERIAL PRIMARY KEY,

    id_student INT NOT NULL,

    id_subject INT NOT NULL,

    id_period INT NOT NULL,

    UNIQUE(id_student,id_subject,id_period),

    FOREIGN KEY (id_student)
    REFERENCES students(id_student),

    FOREIGN KEY (id_subject)
    REFERENCES subjects(id_subject),

    FOREIGN KEY (id_period)
    REFERENCES academic_periods(id_period)

);


/*TABLE: GRADES-Grades belong to an enrolled subject*/

CREATE TABLE grades (

    id_grade SERIAL PRIMARY KEY,

    id_student_subject INT NOT NULL UNIQUE,

    first_exam NUMERIC(3,1)
    CHECK(first_exam BETWEEN 0 AND 5),

    second_exam NUMERIC(3,1)
    CHECK(second_exam BETWEEN 0 AND 5),

    final_exam NUMERIC(3,1)
    CHECK(final_exam BETWEEN 0 AND 5),

    final_grade NUMERIC(3,1)
    CHECK(final_grade BETWEEN 0 AND 5),

    FOREIGN KEY (id_student_subject)
    REFERENCES student_subjects(id_student_subject)

);

/*INSERT INTO FACULTIES*/

INSERT INTO faculties (faculty_name)
VALUES
('Engineering'),
('Health Sciences'),
('Business Administration'),
('Law'),
('Education');


/*INSERT INTO PROGRAMS*/

INSERT INTO programs (program_name,id_faculty)
VALUES
('Software Engineering',1),
('Civil Engineering',1),
('Industrial Engineering',1),
('Nursing',2),
('Medicine',2),
('Business Administration',3),
('Accounting',3),
('Law',4),
('International Relations',4),
('Mathematics Education',5);


/*INSERT INTO SEMESTERS*/

INSERT INTO semesters (semester_number)
VALUES
(1),(2),(3),(4),(5),(6),(7),(8),(9),(10);


/*INSERT INTO PROFESSORS*/

INSERT INTO professors
(first_name,last_name,email,phone,specialization)
VALUES
('John','Smith','john.smith@university.edu','3001111111','Programming'),
('Mary','Johnson','mary.johnson@university.edu','3001111112','Databases'),
('David','Brown','david.brown@university.edu','3001111113','Networks'),
('Susan','Miller','susan.miller@university.edu','3001111114','Mathematics'),
('James','Wilson','james.wilson@university.edu','3001111115','Physics'),
('Patricia','Moore','patricia.moore@university.edu','3001111116','Accounting'),
('Robert','Taylor','robert.taylor@university.edu','3001111117','Business'),
('Jennifer','Anderson','jennifer.anderson@university.edu','3001111118','Law'),
('Michael','Thomas','michael.thomas@university.edu','3001111119','Medicine'),
('Linda','Jackson','linda.jackson@university.edu','3001111120','Nursing');


/*INSERT INTO SUBJECTS*/

INSERT INTO subjects
(subject_name,credits,id_program,id_semester)
VALUES
('Programming I',4,1,1),
('Database Systems',4,1,2),
('Computer Networks',3,1,4),
('Calculus I',4,1,1),
('Physics',3,2,2),
('Structural Design',4,2,5),
('Statistics',3,3,2),
('Project Management',3,3,6),
('Clinical Nursing',4,4,4),
('Human Anatomy',5,5,1),
('Business Administration',3,6,1),
('Accounting Basics',3,7,1),
('Constitutional Law',4,8,2),
('International Law',3,9,5),
('Teaching Strategies',3,10,2);


/*INSERT INTO ACADEMIC PERIODS*/

INSERT INTO academic_periods
(period_name,start_date,end_date)
VALUES
('2025-1','2025-01-20','2025-06-20'),
('2025-2','2025-07-20','2025-12-20'),
('2026-1','2026-01-20','2026-06-20');


/*INSERT INTO CLASSROOMS*/

INSERT INTO classrooms
(building,room_number,capacity)
VALUES
('A','101',35),
('A','102',40),
('B','201',30),
('B','202',45),
('C','301',50);


/*INSERT INTO STUDENTS*/

INSERT INTO students
(first_name,last_name,email,phone,birth_date,id_program)
VALUES
('Daniel','Lopez','daniel@university.edu','3011111111','2003-03-20',1),
('Laura','Perez','laura@university.edu','3011111112','2002-08-15',1),
('Carlos','Gomez','carlos@university.edu','3011111113','2001-10-11',2),
('Andrea','Martinez','andrea@university.edu','3011111114','2003-01-09',3),
('Felipe','Ruiz','felipe@university.edu','3011111115','2002-06-12',4),
('Natalia','Torres','natalia@university.edu','3011111116','2004-04-30',5),
('Kevin','Castro','kevin@university.edu','3011111117','2002-12-02',6),
('Sara','Vargas','sara@university.edu','3011111118','2003-09-18',7),
('Miguel','Rojas','miguel@university.edu','3011111119','2001-02-22',8),
('Paula','Diaz','paula@university.edu','3011111120','2003-07-27',9),
('Luis','Ramirez','luis@university.edu','3011111121','2004-02-05',10),
('Camila','Morales','camila@university.edu','3011111122','2002-11-16',1),
('Sofia','Herrera','sofia@university.edu','3011111123','2001-05-28',2),
('Juan','Castillo','juan@university.edu','3011111124','2003-12-01',3),
('Valentina','Ortega','valentina@university.edu','3011111125','2002-09-14',6);


/*INSERT INTO ENROLLMENTS*/

INSERT INTO enrollments
(enrollment_date,id_student,id_period,id_semester)
VALUES
('2025-01-15',1,1,1),
('2025-01-15',2,1,1),
('2025-01-15',3,1,2),
('2025-01-15',4,1,3),
('2025-01-15',5,1,4),
('2025-01-15',6,1,1),
('2025-01-15',7,1,1),
('2025-01-15',8,1,1),
('2025-01-15',9,1,2),
('2025-01-15',10,1,5),
('2025-01-15',11,1,2),
('2025-01-15',12,1,4),
('2025-01-15',13,1,5),
('2025-01-15',14,1,6),
('2025-01-15',15,1,3);


/*INSERT INTO COURSE ASSIGNMENTS*/

INSERT INTO course_assignments
(id_professor,id_subject,id_period,id_classroom)
VALUES
(1,1,1,1),
(2,2,1,2),
(3,3,1,3),
(4,4,1,4),
(5,5,1,5),
(6,6,1,1),
(7,11,1,2),
(8,13,1,3),
(9,10,1,4),
(10,9,1,5);


/*INSERT INTO STUDENT SUBJECTS*/

INSERT INTO student_subjects
(id_student,id_subject,id_period)
VALUES
(1,1,1),
(1,4,1),
(2,1,1),
(2,2,1),
(3,5,1),
(3,6,1),
(4,7,1),
(4,8,1),
(5,9,1),
(6,10,1),
(7,11,1),
(8,12,1),
(9,13,1),
(10,14,1),
(11,15,1);


/*INSERT INTO GRADES*/

INSERT INTO grades
(id_student_subject,first_exam,second_exam,final_exam,final_grade)
VALUES
(1,4.5,4.6,4.8,4.6),
(2,3.8,4.0,4.2,4.0),
(3,4.9,5.0,4.8,4.9),
(4,4.2,4.3,4.5,4.3),
(5,3.7,3.8,4.0,3.8),
(6,4.4,4.5,4.6,4.5),
(7,4.8,4.9,5.0,4.9),
(8,3.9,4.0,4.2,4.0),
(9,4.6,4.5,4.7,4.6),
(10,4.3,4.4,4.5,4.4),
(11,3.8,3.9,4.0,3.9),
(12,4.1,4.2,4.3,4.2),
(13,4.7,4.8,4.9,4.8),
(14,4.0,4.1,4.2,4.1),
(15,5.0,4.9,5.0,5.0);


/*SELECT * FROM faculties;
SELECT * FROM programs;
SELECT * FROM semesters;
SELECT * FROM students;
SELECT * FROM subjects;
SELECT * FROM enrollments;
SELECT * FROM grades;*/

/*QUERY 1.Students by Faculty*/

SELECT
    f.faculty_name,
    COUNT(s.id_student) AS total_students
FROM faculties f
INNER JOIN programs p
ON f.id_faculty = p.id_faculty
INNER JOIN students s
ON p.id_program = s.id_program
GROUP BY f.faculty_name
ORDER BY total_students DESC;


/*QUERY 2.Students by Program*/

SELECT
    p.program_name,
    COUNT(s.id_student) AS total_students
FROM programs p
INNER JOIN students s
ON p.id_program = s.id_program
GROUP BY p.program_name
ORDER BY total_students DESC;


/*QUERY 3.Subjects by Semester*/

SELECT
    se.semester_number,
    su.subject_name
FROM subjects su
INNER JOIN semesters se
ON su.id_semester = se.id_semester
ORDER BY se.semester_number, su.subject_name;


/*QUERY 4.Subjects by Program*/

SELECT
    p.program_name,
    su.subject_name
FROM programs p
INNER JOIN subjects su
ON p.id_program = su.id_program
ORDER BY p.program_name;


/*QUERY 5.Professors and Assigned Subjects*/

SELECT
    pr.first_name || ' ' || pr.last_name AS professor,
    su.subject_name
FROM course_assignments ca
INNER JOIN professors pr
ON ca.id_professor = pr.id_professor
INNER JOIN subjects su
ON ca.id_subject = su.id_subject
ORDER BY professor;


/*QUERY 6.Students Enrolled by Academic Period*/

SELECT
    ap.period_name,
    COUNT(e.id_student) AS enrolled_students
FROM academic_periods ap
INNER JOIN enrollments e
ON ap.id_period = e.id_period
GROUP BY ap.period_name;


/*QUERY 7.Average Grade by Subject*/

SELECT
    su.subject_name,
    ROUND(AVG(g.final_grade),2) AS average_grade
FROM grades g
INNER JOIN student_subjects ss
ON g.id_student_subject = ss.id_student_subject
INNER JOIN subjects su
ON ss.id_subject = su.id_subject
GROUP BY su.subject_name
ORDER BY average_grade DESC;


/*Top 5 Students*/

SELECT
    st.first_name || ' ' || st.last_name AS student,
    ROUND(AVG(g.final_grade),2) AS average
FROM grades g
INNER JOIN student_subjects ss
ON g.id_student_subject = ss.id_student_subject
INNER JOIN students st
ON ss.id_student = st.id_student
GROUP BY student
ORDER BY average DESC
LIMIT 5;


/*QUERY 9.Subjects with Highest Enrollment*/

SELECT
    su.subject_name,
    COUNT(ss.id_student) AS enrolled
FROM subjects su
INNER JOIN student_subjects ss
ON su.id_subject = ss.id_subject
GROUP BY su.subject_name
ORDER BY enrolled DESC;


/*QUERY 10.Professors Teaching More Than One Subject*/

SELECT
    pr.first_name || ' ' || pr.last_name AS professor,
    COUNT(ca.id_subject) AS assigned_subjects
FROM professors pr
INNER JOIN course_assignments ca
ON pr.id_professor = ca.id_professor
GROUP BY professor
HAVING COUNT(ca.id_subject) >= 1
ORDER BY assigned_subjects DESC;


/*QUERY 11.Available Classrooms*/

SELECT
    building,
    room_number,
    capacity
FROM classrooms
ORDER BY capacity DESC;


/*QUERY 12.Students and Their Subjects*/

SELECT
    st.first_name || ' ' || st.last_name AS student,
    su.subject_name
FROM student_subjects ss
INNER JOIN students st
ON ss.id_student = st.id_student
INNER JOIN subjects su
ON ss.id_subject = su.id_subject
ORDER BY student;


/*QUERY 13.Average Grade by Program*/

SELECT
    p.program_name,
    ROUND(AVG(g.final_grade),2) AS average_grade
FROM grades g
INNER JOIN student_subjects ss
ON g.id_student_subject = ss.id_student_subject
INNER JOIN students st
ON ss.id_student = st.id_student
INNER JOIN programs p
ON st.id_program = p.id_program
GROUP BY p.program_name
ORDER BY average_grade DESC;


/*QUERY 14.Highest Final Grade*/

SELECT
    st.first_name || ' ' || st.last_name AS student,
    MAX(g.final_grade) AS highest_grade
FROM grades g
INNER JOIN student_subjects ss
ON g.id_student_subject = ss.id_student_subject
INNER JOIN students st
ON ss.id_student = st.id_student
GROUP BY student
ORDER BY highest_grade DESC;


/*QUERY 15.Complete Academic Report*/

SELECT

st.first_name || ' ' || st.last_name AS student,

f.faculty_name,

p.program_name,

se.semester_number,

ap.period_name,

su.subject_name,

g.final_grade

FROM grades g

INNER JOIN student_subjects ss
ON g.id_student_subject = ss.id_student_subject

INNER JOIN students st
ON ss.id_student = st.id_student

INNER JOIN programs p
ON st.id_program = p.id_program

INNER JOIN faculties f
ON p.id_faculty = f.id_faculty

INNER JOIN subjects su
ON ss.id_subject = su.id_subject

INNER JOIN semesters se
ON su.id_semester = se.id_semester

INNER JOIN academic_periods ap
ON ss.id_period = ap.id_period

ORDER BY student;


/*UPDATE 1.Update a student's phone number*/

UPDATE students
SET phone = '3009999999'
WHERE id_student = 1;


/*UPDATE 2.Update professor specialization*/

UPDATE professors
SET specialization = 'Artificial Intelligence'
WHERE id_professor = 1;


/*UPDATE 3.Increase subject credits*/

UPDATE subjects
SET credits = 5
WHERE id_subject = 1;



/*DELETE 1.Delete a grade*/

DELETE FROM grades
WHERE id_grade = 15;



/*DELETE 2.Delete a student subject enrollment*/

DELETE FROM student_subjects
WHERE id_student_subject = 15;



/*ALTER TABLEAdd a new column=*/

ALTER TABLE students
ADD COLUMN address VARCHAR(150);



/*UPDATE NEW COLUMN*/

UPDATE students
SET address='Barranquilla'
WHERE id_student=1;



/*CREATE VIEWAcademic Performance*/

CREATE VIEW vw_student_grades AS

SELECT

st.id_student,

st.first_name,

st.last_name,

su.subject_name,

g.final_grade

FROM grades g

INNER JOIN student_subjects ss
ON g.id_student_subject = ss.id_student_subject

INNER JOIN students st
ON ss.id_student = st.id_student

INNER JOIN subjects su
ON ss.id_subject = su.id_subject;



/*VIEW*/

SELECT * FROM vw_student_grades;



/*CREATE VIEW Students by Program*/

CREATE VIEW vw_students_programs AS

SELECT

st.id_student,

st.first_name,

st.last_name,

p.program_name

FROM students st

INNER JOIN programs p
ON st.id_program=p.id_program;



SELECT * FROM vw_students_programs;



/*CREATE INDEX*/

CREATE INDEX idx_student_lastname

ON students(last_name);



/*CREATE INDEX=*/

CREATE INDEX idx_subject_name

ON subjects(subject_name);



/*TRANSACTION*/

BEGIN;

UPDATE grades
SET final_grade = 5.0
WHERE id_grade = 1;

COMMIT;



/*TRANSACTION*/

BEGIN;

UPDATE students
SET phone='3000000000'
WHERE id_student=2;

ROLLBACK;



/*VERIFY*/

SELECT * FROM students;

SELECT * FROM grades;

