DROP TABLE IF EXISTS Class;
CREATE TABLE Class (
	Id INT NOT NULL PRIMARY KEY IDENTITY,
	InstructorId INT NOT NULL,
	DepartmentId INT NOT NULL,
	CourseName NVARCHAR(30) NOT NULL,
	CourseDescription NVARCHAR(150) NOT NULL,
	CourseCapacity INT NOT NULL CHECK (CourseCapacity > 0),
	StartTime DATE NOT NULL,
	EndTime DATE NOT NULL,
	BuildingId INT NOT NULL,
	RoomNumber NVARCHAR(30) NOT NULL,
);

DROP TABLE IF EXISTS Person;
CREATE TABLE Person (
	Id INT NOT NULL PRIMARY KEY IDENTITY,
	Name NVARCHAR(30) NOT NULL,
	Email NVARCHAR(255) NOT NULL UNIQUE,
	Role NVARCHAR (15) NOT NULL,
	CHECK(Role in ('User', 'Root'))
);

DROP TABLE IF EXISTS Department;
CREATE TABLE Department (
	Id INT NOT NULL PRIMARY KEY IDENTITY,
	Name NVARCHAR(150) NOT NULL,
	DeanId INT NOT NULL
);

DROP TABLE IF EXISTS Building;
CREATE TABLE Building (
	Id INT NOT NULL PRIMARY KEY IDENTITY,
	BuildingName NVARCHAR(150) NOT NULL
);

DROP TABLE IF EXISTS Enrollment;
CREATE TABLE Enrollment (
	CourseId INT NOT NULL,
	StudentId INT NOT NULL,
	PRIMARY KEY (CourseId, StudentId)
);

DROP TABLE IF EXISTS Instructor;
CREATE TABLE Instructor (
	DepartmentId INT NOT NULL, 
	InstructorId INT NOT NULL PRIMARY KEY
);

DROP TABLE IF EXISTS Transcript;
CREATE TABLE Transcript (
	PersonId INT NOT NULL,
	CourseId INT NOT NULL,
	Grade NVARCHAR(30) NOT NULL,
	CHECK(Grade IN ('A', 'B', 'C', 'D', 'F', 'I', 'T')),
	PRIMARY KEY (PersonId, CourseId)
);

ALTER TABLE Department DROP CONSTRAINT FK_DepartmentDean_Instructor;


ALTER TABLE Class ADD CONSTRAINT FK_ClassInstructorId_InstructorId FOREIGN KEY (InstructorId) REFERENCES Instructor(InstructorId) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Class ADD CONSTRAINT FK_ClassDepartmentId_DepartmentID FOREIGN KEY (DepartmentId) REFERENCES Department(Id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Class ADD CONSTRAINT FK_ClassBuildingId_BuildingId FOREIGN KEY (BuildingId) REFERENCES Building (Id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Department ADD CONSTRAINT FK_DepartmentDean_Instructor FOREIGN KEY (DeanId) REFERENCES Instructor (InstructorId);
ALTER TABLE Enrollment ADD CONSTRAINT FK_EnrollmentCourseId_CourseId FOREIGN KEY (CourseId) REFERENCES Class (Id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Enrollment ADD CONSTRAINT FK_EnrollmentStudentId_PersonId FOREIGN KEY (StudentId) REFERENCES Person (Id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Instructor ADD CONSTRAINT FK_InstructorDepartmentId_Department FOREIGN KEY (DepartmentId) REFERENCES Department (Id);
ALTER TABLE Instructor ADD CONSTRAINT FK_InstructorId_PersonID FOREIGN KEY (InstructorId) REFERENCES Person (Id);
ALTER TABLE Transcript ADD CONSTRAINT FK_TranscriptPersonId_PersonId FOREIGN KEY (PersonId) REFERENCES Person (Id) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE Transcript ADD CONSTRAINT FK_TranscriptCourseId_CourseId FOREIGN KEY (CourseId) REFERENCES Class (Id) ON DELETE CASCADE ON UPDATE CASCADE;