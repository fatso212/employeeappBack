USE master
GO

-- Delete the EmployeeDB Database (IF EXISTS)
IF EXISTS(select * from sys.databases where name='Employee_Management')

DROP DATABASE Employee_Management
GO

-- Create a new EmployeeDB Database
CREATE DATABASE Employee_Management
GO

-- Switch to the EmployeeDB Databases
USE Employee_Management
GO

BEGIN TRANSACTION

CREATE TABLE Accounts 
(
	AccountID int identity(1,1),
	AccountName VARCHAR(50) NOT NULL,
	AccountDescription VARCHAR(1000) NOT NULL,
	AccountLogo VARCHAR(100)

	CONSTRAINT pk_AccountID primary key(AccountID)
)
--CREATE TABLE UserTypes()
--CREATE TABLE AssetTypes()

CREATE TABLE Users
(
	UserID int identity(1,1), --PK
	AccountID int NOT NULL, --FK
	UserType VARCHAR(50) NOT NULL,
	UserName VARCHAR(50),
	PasswordString VARCHAR(50),
	Salt varchar(50),
	UserEmailAddress VARCHAR(50) NOT NULL,
	UserFirstName VARCHAR(50) NOT NULL,
	UserLastName VARCHAR(50) NOT NULL,
	UserPhoneNumber VARCHAR(15) NOT NULL,
	
	-- fk accounts/join table for accounts and users because you want master user to be able to access all the accounts
	CONSTRAINT CHK_User CHECK (UserType = 'Employee' OR UserType = 'User' OR UserType = 'Admin'),
	CONSTRAINT CHK_UserName CHECK(UserName NOT NULL WHERE UserType = User )
	CONSTRAINT CHK_Salt CHECK(Salt NOT NULL WHERE UserType = User )
	CONSTRAINT pk_UserID primary key(UserID)
)

CREATE TABLE Trainings
(
	TrainingID INT identity(1,1),
	AccountID INT not null, --FK
	TrainingName VARCHAR(50),
	TrainingDescription VARCHAR(200),

	CONSTRAINT pk_trainingID primary key(trainingID)
)

-- Joined table user trainings

CREATE TABLE UserTrainings
(
	UserTrainingID INT identity(1,1), --PK
	UserID int not null, --FK
	TrainingID int not null, --FK
	TrainingStatus varchar(20),

	CONSTRAINT CHK_TrainingStatus CHECK (TrainingStatus = 'Recommended' OR TrainingStatus = 'Requested' OR TrainingStatus = 'In Progress'OR TrainingStatus = 'Completed')
	CONSTRAINT PK_UserTrainingID primary key(UserTrainingID)
)

CREATE TABLE Assets
(
	AssetDescription varchar(200),
	AssetName varchar(50),
	AssetID INT identity(1,1),
	AssetType varchar(20) CHECK (AssetType='Skill') OR (AssetType='Talent') OR (AssetType='Position'),

	CONSTRAINT PK_AssetID primary key(AssetID)
)
--  users/assets joined table

CREATE TABLE AssetsUsers
(
	AssetsUserID int identity(1,1),
	AssetID int not null,-- FK
	UserID int not null,-- FK,
	UsersAssetsExperienceStart date,
	UsersAssetsExperienceEnd date,
	UsersAssetsNotes VARCHAR(2000)

	CONSTRAINT PK_AssetsUserID primary key(AssetsUserID)
)

CREATE TABLE TrainingFiles
(
	TrainingFileID AssetID INT identity(1,1),
	TrainingID INT not null --FK
	TrainingFileOrderNo INT not null,
	TrainingFileDescription VARCHAR(200) NOT NULL,
	TrainingFilePath varchar(100) NOT NULL,
)

ALTER TABLE Users ADD FOREIGN KEY (AccountID) REFERENCES Accounts (AccountID);
ALTER TABLE Trainings ADD FOREIGN KEY (AccountID) REFERENCES Accounts (AccountID);
ALTER TABLE UserTrainings ADD FOREIGN KEY (UserID) REFERENCES Users (UserID);
ALTER TABLE UserTrainings ADD FOREIGN KEY (TrainingID) REFERENCES Trainings (TrainingID);
ALTER TABLE AssetsUsers ADD FOREIGN KEY (AssetID) REFERENCES Assets (AssetID);
ALTER TABLE AssetsUsers ADD FOREIGN KEY (UserID) REFERENCES Users (UserID);
ALTER TABLE TrainingFiles ADD FOREIGN KEY (TrainingID) REFERENCES Trainings (TrainingID);


INSERT INTO accounts (accountName) Values
	('Amazon'),
	('Apple'),
	('Microsoft')

INSERT INTO employees(accountID, employeeFirstName, employeeLastName) VALUES
	(1, 'sam', 'flirk'),
	(1, 'sam', 'lirk'),
	(1, 'bob', 'kirk')

INSERT INTO trainings(accountID, trainingName) VALUES
	(2, 'accounting fundamentals'),
	(2, 'secretarial responsibilities')

INSERT INTO talents (talentName, employeeID) VALUES
	('art', 1),
	('design', 1),
	('music', 1),
	('visual', 1)

INSERT INTO skills (skillName, employeeID) VALUES
	('web design', 1),
	('technical', 1),
	('electronic engineering', 1),
	('graphic design', 1)

INSERT INTO positions(positionName, employeeID) VALUES
	('Secretary', 1),
	('Graphic Designer', 1),
	('Retail', 1),
	('Store Manager', 1)




SELECT * FROM users
SELECT * FROM accounts
SELECT * FROM employees join accounts on employees.accountID = accounts.accountID
SELECT * FROM trainings join accounts on trainings.accountID = accounts.accountID
SELECT * FROM talents join employees on talents.employeeID = employees.employeeID
SELECT * FROM skills join employees on skills.employeeID = employees.employeeID
SELECT * FROM positions join employees on positions.employeeID = employees.employeeID

COMMIT TRANSACTION