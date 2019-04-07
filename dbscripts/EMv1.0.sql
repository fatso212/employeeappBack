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

CREATE TABLE accounts
(
--add new accounts to central database
--primary table
	AccountID int identity(1,1) not null,
	AccountDescription VARCHAR(50)not null,
	AccountName VARCHAR(50)not null,

	Constraint pk_AccountID primary key(AccountID)
)
--add new workcategories to central database
--primary table
CREATE TABLE workcategories
(
	WorkCategoryID int identity(1,1)not null,
	WorkCategoryDescription VARCHAR(50)not null,
	WorkCategoryName VARCHAR(50)not null,

	Constraint pk_WorkCategoryID primary key(WorkCategoryID)
)

--add new trainings to central database
--primary table
CREATE TABLE trainings
(
	TrainingID int identity(1,1) not null,
	TrainingDescription VARCHAR(50)not null,
	TrainingName VARCHAR(50)not null,

	Constraint pk_TrainingID primary key(TrainingID)
)

CREATE TABLE assets
(
	WorkCategoryID int not null,
	AssetDescription VARCHAR(50) not null,
	AssetName VARCHAR(50),
	AssetID int identity(1,1) not null,
	AssetType varchar(50) not null,
	AssetYearsOfExperience int not null,

	constraint pk_AssetID primary key(AssetID) 
)
--add new employees to central database
--primary table
CREATE TABLE employees
(
	EmployeeEmailAddress VARCHAR(50) not null,
	EmployeeFirstName VARCHAR(50) not null,
	EmployeeID int identity(1,1) not null,
	EmployeeLastName VARCHAR(50) not null,
	EmployeePhoneNumber VARCHAR(12) not null,

	constraint pk_EmployeeID primary key(EmployeeID) 
)
--relationship table
CREATE TABLE users
(
	UserID int identity(1,1) not null,
	UserName varchar(50) not null,
	UserPassword varchar(50) not null,
	UserSalt varchar(50) not null,
	AccountID int not null,

	constraint pk_UserID primary key(UserID) 
)

--relationship table
CREATE TABLE trainings_files
(
	Training_FileID int identity(1,1) not null,
	TrainingID int not null,
	Training_FileDescription VARCHAR(50) not null,
	Training_FilePath VARCHAR(50) not null,

	constraint pk_Training_FileID primary key(Training_FileID) 
)
--relationship table
CREATE TABLE employees_assets
(
	AssetID int not null,
	EmployeeID int not null, 
	Employee_AssetID int identity(1,1) not null,
	
	constraint pk_Employee_AssetID primary key(Employee_AssetID) 
)


ALTER TABLE assets ADD FOREIGN KEY (WorkCategoryID) REFERENCES workcategories (WorkCategoryID);
ALTER TABLE users ADD FOREIGN KEY (AccountID) REFERENCES accounts (AccountID);

ALTER TABLE trainings_files ADD FOREIGN KEY (TrainingID) REFERENCES trainings (TrainingID);

ALTER TABLE employees_assets ADD FOREIGN KEY (EmployeeID) REFERENCES employees (EmployeeID);
ALTER TABLE employees_assets ADD FOREIGN KEY (AssetID) REFERENCES assets (AssetID);

COMMIT TRANSACTION