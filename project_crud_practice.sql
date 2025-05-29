-- Table Creation
CREATE TABLE Student (
  ID INT IDENTITY(1,1) PRIMARY KEY,
  FullName NVARCHAR(100),
  Email NVARCHAR(100)
);

CREATE TABLE Industry (
  ID INT IDENTITY(1,1) PRIMARY KEY,
  IndustryName NVARCHAR(100),
  Description NVARCHAR(255)
);

CREATE TABLE ProjectGroup (
  ID INT IDENTITY(1,1) PRIMARY KEY,
  GroupName NVARCHAR(100),
  IndustryID INT FOREIGN KEY REFERENCES Industry(ID)
);

CREATE TABLE Deliverable (
  ID INT IDENTITY(1,1) PRIMARY KEY,
  Title NVARCHAR(100),
  SubmissionDate DATE,
  Grade INT,
  ProjectGroupID INT FOREIGN KEY REFERENCES ProjectGroup(ID)
);

-- Inserts
INSERT INTO Student (FullName, Email) VALUES
('Alice Johnson', 'alice.johnson@example.com'),
('Bob Smith', 'bob.smith@example.com'),
('Cindy Lee', 'cindy.lee@example.com');

INSERT INTO Industry (IndustryName, Description) VALUES
('Healthcare', 'Patient care, EHR systems, data privacy'),
('Education', 'Remote learning tools and LMS Security'),
('Human Tracking Systems', 'GPS, RFID, facial recognition, ethics');

INSERT INTO ProjectGroup (GroupName, IndustryID) VALUES
('Team Innovate', 1),
('Cyber Scholars', 2),
('TrackTech Titans', 3);

INSERT INTO Deliverable (ProjectGroupID, Title, SubmissionDate, Grade) VALUES
(1, 'AI in Patient Monitoring', '2025-06-12', 92),
(2, 'Securing Virtual Classrooms', '2025-06-12', 88),
(2, 'Ethics of Biometric Surveillance', '2025-06-12', 90);

-- CRUD for Student
SELECT * FROM Student WHERE ID > 2;
SELECT * FROM Student;

UPDATE Student 
SET Email = 'updatedemail@gmail.com'
WHERE FullName = 'Cindy Lee';

DELETE FROM Student
WHERE ID < 2;

SELECT * FROM Student;

-- CRUD for Industry
INSERT INTO Industry (IndustryName, Description) VALUES 
('Finance', 'Online banking, fintech security, fraud prevention');

SELECT * FROM Industry;
SELECT * FROM Industry WHERE IndustryName LIKE '%care%';

UPDATE Industry
SET Description = 'Healthcare systems, privacy laws, and AI integration'
WHERE IndustryName = 'Healthcare';

DELETE FROM Industry
WHERE IndustryName = 'Finance';

SELECT * FROM Industry;

-- CRUD for ProjectGroup
INSERT INTO ProjectGroup (GroupName, IndustryID) VALUES 
('Fintech Force', 1);

SELECT * FROM ProjectGroup;
SELECT * FROM ProjectGroup WHERE GroupName LIKE 'Cyber%';

UPDATE ProjectGroup
SET GroupName = 'Cyber Innovators'
WHERE GroupName = 'Cyber Scholars';

DELETE FROM ProjectGroup
WHERE GroupName = 'Fintech Force';

SELECT * FROM ProjectGroup;

-- CRUD for Deliverable
INSERT INTO Deliverable (ProjectGroupID, Title, SubmissionDate, Grade) VALUES
(3, 'Facial Recognition and Privacy', '2025-06-20', 85);

SELECT * FROM Deliverable;
SELECT * FROM Deliverable WHERE Grade >= 90;

UPDATE Deliverable
SET Grade = 95
WHERE Title = 'AI in Patient Monitoring';

DELETE FROM Deliverable
WHERE Title = 'Facial Recognition and Privacy';

SELECT * FROM Deliverable;

-- JOIN Query
SELECT 
  d.ID, 
  d.Title, 
  pg.GroupName, 
  i.IndustryName 
FROM Deliverable d
JOIN ProjectGroup pg ON d.ProjectGroupID = pg.ID
JOIN Industry i ON pg.IndustryID = i.ID;
