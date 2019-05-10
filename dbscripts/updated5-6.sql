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

INSERT INTO Accounts(AccountName, AccountDescription, AccountLogo) VALUES
	('Amazon', 'Retail Online Marketplace', 'FileName/AmazonLogo'),
	('Apple', 'Electronics Manufacturer', 'FileName/AppleLogo')

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
	CONSTRAINT CHK_UserName CHECK(UserName IS NOT NULL OR UserType != 'User'),
	CONSTRAINT CHK_Salt CHECK(UserType != 'User' OR Salt IS NOT NULL ),
	CONSTRAINT pk_UserID primary key(UserID)
)
INSERT INTO Users(AccountID, UserType, UserName, PasswordString, Salt, UserEmailAddress, UserFirstName, UserLastName, UserPhoneNumber) VALUES
	(1, 'User', 'Fatso', 'password', 'salt', 'michaeljones@amazon.com', 'Michael', 'jones', '7712221111'),
	(1, 'User', 'fatso2', 'password', 'salt', 'brianjones@amazon.com', 'brian', 'jones', '7712221112'),
	(2, 'User', 'skinnyso', 'password', 'salt', 'mikebrand@apple.com', 'mike', 'brand', '7712221133'),
	(2, 'User', 'skinnyso2', 'password', 'salt', 'nancyhanson@apple.com', 'nancy', 'hanson', '7712221141')

CREATE TABLE Trainings
(
	TrainingID INT identity(1,1),
	AccountID INT not null, --FK
	TrainingName VARCHAR(50),
	TrainingDescription VARCHAR(200),

	CONSTRAINT pk_trainingID primary key(trainingID)
)

INSERT INTO Trainings(AccountID, TrainingName, TrainingDescription) Values 
	(1, 'Software Engineer', 'Training to become a software developer'),
	(1, 'plumber', 'Training in plumbing'),
	(1, 'Secretary', 'Training in Secratarial Work')



-- Joined table user trainings

CREATE TABLE UserTrainings
(
	UserTrainingID INT identity(1,1), --PK
	UserID int not null, --FK
	TrainingID int not null, --FK
	TrainingStatus varchar(20),

	CONSTRAINT CHK_TrainingStatus CHECK (TrainingStatus = 'Recommended' OR TrainingStatus = 'Requested' OR TrainingStatus = 'In Progress' OR TrainingStatus = 'Completed'),
	CONSTRAINT PK_UserTrainingID primary key(UserTrainingID)
)
INSERT INTO UserTrainings(UserID, TrainingID, TrainingStatus) Values
	(1, 1, 'Recommended'),
	(2, 1, 'Recommended'),
	(1, 3, 'Completed')

CREATE TABLE Assets
(
	AssetDescription varchar(200),
	AssetName varchar(50),
	AssetID INT identity(1,1),
	AssetType varchar(20) CHECK (AssetType='Skill' OR AssetType='Talent' OR AssetType='Position'),

	CONSTRAINT PK_AssetID primary key(AssetID)
)
--  users/assets joined table
INSERT INTO Assets (AssetDescription, AssetName, AssetType) Values
	('Knows Basic Art Skills', 'Art', 'Skill'),
	('Experience With Secratarial Work', 'Secretary', 'Position')

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

INSERT INTO AssetsUsers (AssetID, UserID, UsersAssetsExperienceStart, UsersAssetsExperienceEnd, UsersAssetsNotes) VALUES
	(1)

CREATE TABLE TrainingFiles
(
	TrainingFileID INT identity(1,1),
	TrainingID INT not null, --FK
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





SELECT * FROM users
SELECT * FROM accounts
SELECT * FROM Trainings
SELECT * FROM UserTrainings
select * FROM Assets

SELECT * FROM Users JOIN Accounts
ON Users.AccountID = Accounts.AccountID

SELECT * FROM Trainings JOIN Accounts
ON Trainings.AccountID = Accounts.AccountID

SELECT * FROM UserTrainings join Trainings
ON UserTrainings.TrainingID = Trainings.TrainingID
JOIN  Users ON UserTrainings.UserID = Users.UserID
Join Accounts ON Users.AccountID = accounts.AccountID



COMMIT TRANSACTION