--  Create database
CREATE DATABASE CARS

use CARS

-- Create tables
-- Incidents Table
CREATE TABLE Incidents (
    IncidentID INT PRIMARY KEY IDENTITY(1,1),
    IncidentType VARCHAR(50),
    IncidentDate DATE,
    Location GEOGRAPHY,  
    Description VARCHAR(255),
    Status VARCHAR(50),
    VictimID INT,
    SuspectID INT
)

-- Victims Table
CREATE TABLE Victims (
    VictimID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender CHAR(1),
    ContactInfo VARCHAR(255)
)

-- Suspects Table
CREATE TABLE Suspects (
    SuspectID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DateOfBirth DATE,
    Gender CHAR(1),
    ContactInfo VARCHAR(255)
)

-- Law Enforcement Agencies Table
CREATE TABLE LawEnforcementAgencies (
    AgencyID INT PRIMARY KEY IDENTITY(1,1),
    AgencyName VARCHAR(100),
    Jurisdiction VARCHAR(100),
    ContactInfo VARCHAR(255)
)

-- Officers Table
CREATE TABLE Officers (
    OfficerID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BadgeNumber VARCHAR(20),
    Rank VARCHAR(50),
    ContactInfo VARCHAR(255),
    AgencyID INT
)

-- Evidence Table
CREATE TABLE Evidence (
    EvidenceID INT PRIMARY KEY IDENTITY(1,1),
    Description VARCHAR(255),
    LocationFound VARCHAR(255),
    IncidentID INT
)

-- Reports Table
CREATE TABLE Reports (
    ReportID INT PRIMARY KEY IDENTITY(1,1),
    IncidentID INT,
    ReportingOfficer INT,
    ReportDate DATE,
    ReportDetails VARCHAR(255),
    Status VARCHAR(50)
)

-- Add Foreign Key for Incidents table (VictimID, SuspectID)

-- I did use ON DELETE cascading on  for victims and suspect because uf we delete any victim or suspect it will delet the whole incident 
--  and one incident can have changing and multipl suspects and victims  
ALTER TABLE Incidents
ADD CONSTRAINT FK_Incidents_Victims FOREIGN KEY (VictimID)
REFERENCES Victims(VictimID)
ON UPDATE CASCADE

ALTER TABLE Incidents
ADD CONSTRAINT FK_Incidents_Suspects FOREIGN KEY (SuspectID)
REFERENCES Suspects(SuspectID)
ON UPDATE CASCADE

-- Add Foreign Key for Officers table (AgencyID)

-- I did not use ON DELETE here because on deleting an agency officers records should not get deleted
ALTER TABLE Officers
ADD CONSTRAINT FK_Officers_Agencies FOREIGN KEY (AgencyID)
REFERENCES LawEnforcementAgencies(AgencyID)
ON UPDATE CASCADE

-- Add Foreign Key for Evidence table (IncidentID)

-- I added ON DELETE here because if we delete an incident all the evidence should be deleted 
ALTER TABLE Evidence
ADD CONSTRAINT FK_Evidence_Incidents FOREIGN KEY (IncidentID)
REFERENCES Incidents(IncidentID)
ON DELETE CASCADE
ON UPDATE CASCADE

-- Add Foreign Key for Reports table (IncidentID, ReportingOfficer)

-- I applied ON DELETE here because on deleting an Incident all reports should be deleted
ALTER TABLE Reports
ADD CONSTRAINT FK_Reports_Incidents FOREIGN KEY (IncidentID)
REFERENCES Incidents(IncidentID)
ON DELETE CASCADE
ON UPDATE CASCADE

-- I did not apply ON DELETE here beacuse on deleting an reporting officeer
-- reports should not get deleted
ALTER TABLE Reports
ADD CONSTRAINT FK_Reports_Officers FOREIGN KEY (ReportingOfficer)
REFERENCES Officers(OfficerID)
ON UPDATE CASCADE

-- Inserting sample data into tables 

INSERT INTO Victims (FirstName, LastName, DateOfBirth, Gender, ContactInfo) VALUES
('Amit', 'Sharma', '1985-05-12', 'M', '123 Main St, Delhi, 110001, 9876543210'),
('Priya', 'Verma', '1990-03-23', 'F', '456 Second St, Mumbai, 400001, 9123456789'),
('Rahul', 'Iyer', '1988-07-15', 'M', '789 Third St, Bangalore, 560001, 9988776655'),
('Neha', 'Singh', '1995-01-20', 'F', '321 Fourth St, Delhi, 110002, 9345678901'),
('Ravi', 'Patel', '1982-08-30', 'M', '654 Fifth St, Ahmedabad, 380001, 7654321098'),
('Sita', 'Rani', '1985-02-10', 'F', '987 Sixth St, Chennai, 600001, 8765432109'),
('Rahul', 'Verma', '1992-06-17', 'M', '159 Seventh St, Pune, 411001, 9123456780'),
('Anita', 'Kumar', '1990-12-25', 'F', '753 Eighth St, Jaipur, 302001, 9876543215'),
('Vikram', 'Choudhary', '1987-04-12', 'M', '951 Ninth St, Kolkata, 700001, 9988776600'),
('Rita', 'Ghosh', '1991-11-09', 'F', '852 Tenth St, Hyderabad, 500001, 9345678999')

INSERT INTO Suspects (FirstName, LastName, DateOfBirth, Gender, ContactInfo) VALUES
('Raj', 'Kumar', '1992-11-05', 'M', '321 Fourth St, Delhi, 110002, 9345678901'),
('Suresh', 'Rathore', '1985-07-19', 'M', '654 Fifth St, Mumbai, 400001, 7654321098'),
('Vikram', 'Patel', '1980-09-30', 'M', '987 Sixth St, Ahmedabad, 380001, 8765432109'),
('Aditi', 'Bansal', '1988-10-10', 'F', '159 Seventh St, Pune, 411001, 9123456780'),
('Pooja', 'Jain', '1991-04-04', 'F', '753 Eighth St, Jaipur, 302001, 9876543215'),
('Arjun', 'Singh', '1993-12-18', 'M', '951 Ninth St, Kolkata, 700001, 9988776600'),
('Sonam', 'Chawla', '1986-03-15', 'F', '852 Tenth St, Hyderabad, 500001, 9345678999'),
('Karan', 'Mehta', '1989-05-22', 'M', '456 Eleventh St, Delhi, 110003, 9876543212'),
('Maya', 'Rani', '1995-08-28', 'F', '321 Twelfth St, Mumbai, 400002, 9123456781'),
('Nitin', 'Sharma', '1984-02-11', 'M', '654 Thirteenth St, Bangalore, 560002, 7654321097')

INSERT INTO LawEnforcementAgencies (AgencyName, Jurisdiction, ContactInfo) VALUES
('Delhi Police', 'Delhi', '011-23456789'),
('Mumbai Police', 'Mumbai', '022-34567890'),
('Bangalore Police', 'Bangalore', '080-45678901'),
('Chennai Police', 'Chennai', '044-56789012'),
('Ahmedabad Police', 'Ahmedabad', '079-67890123'),
('Pune Police', 'Pune', '020-78901234'),
('Jaipur Police', 'Jaipur', '0141-8901234'),
('Kolkata Police', 'Kolkata', '033-90123456'),
('Hyderabad Police', 'Hyderabad', '040-01234567'),
('Lucknow Police', 'Lucknow', '0522-1234567')

INSERT INTO Officers (FirstName, LastName, BadgeNumber, Rank, ContactInfo, AgencyID) VALUES
('Arjun', 'Singh', 'DLP-001', 'Inspector', '9876543210', 1),
('Sunita', 'Bhatia', 'MP-002', 'Sub-Inspector', '9123456789', 2),
('Karan', 'Khan', 'BP-003', 'Constable', '9988776655', 3),
('Ravi', 'Mishra', 'CP-004', 'Inspector', '9876543212', 4),
('Neha', 'Ghosh', 'AP-005', 'Sub-Inspector', '7654321098', 5),
('Pooja', 'Yadav', 'PP-006', 'Constable', '8765432109', 6),
('Suresh', 'Gupta', 'JP-007', 'Inspector', '7654321096', 7),
('Mohan', 'Rao', 'KP-008', 'Sub-Inspector', '9988776601', 8),
('Anita', 'Sharma', 'LP-009', 'Constable', '9876543213', 9),
('Rohan', 'Verma', 'DP-010', 'Inspector', '9123456782', 10)


INSERT INTO Incidents (IncidentType, IncidentDate, Location, Description, Status, VictimID, SuspectID) VALUES
('Robbery', '2024-01-15', geography::STPointFromText('POINT(77.1025 28.7041)', 4326), 'Robbery at a bank', 'Open', 1, 1),
('Homicide', '2024-02-20', geography::STPointFromText('POINT(72.8777 19.0760)', 4326), 'Murder case at a residence', 'Under Investigation', 2, 2),
('Theft', '2024-03-10', geography::STPointFromText('POINT(77.5946 12.9716)', 4326), 'Theft at a jewelry store', 'Closed', 3, 3),
('Assault', '2024-04-05', geography::STPointFromText('POINT(77.2090 28.6139)', 4326), 'Assault in a park', 'Open', 4, 4),
('Kidnapping', '2024-05-15', geography::STPointFromText('POINT(72.8777 19.0760)', 4326), 'Kidnapping in the city', 'Under Investigation', 5, 5),
('Fraud', '2024-06-20', geography::STPointFromText('POINT(73.8567 18.5204)', 4326), 'Online fraud case', 'Closed', 6, 6),
('Vandalism', '2024-07-10', geography::STPointFromText('POINT(77.2182 28.5355)', 4326), 'Vandalism at a public property', 'Open', 7, 7),
('Burglary', '2024-08-12', geography::STPointFromText('POINT(72.8777 19.0760)', 4326), 'Burglary at a house', 'Under Investigation', 8, 8),
('Drug Possession', '2024-09-01', geography::STPointFromText('POINT(77.5946 12.9716)', 4326), 'Possession of illegal drugs', 'Closed', 9, 9),
('Domestic Violence', '2024-09-15', geography::STPointFromText('POINT(78.4867 17.3850)', 4326), 'Domestic dispute', 'Open', 10, 10)

SELECT * FROM Officers

INSERT INTO Evidence (Description, LocationFound, IncidentID) VALUES
('Security camera footage', 'Bank, Delhi', 11),
('Murder weapon', 'Residence, Mumbai', 12),
('Stolen jewelry', 'Jewelry store, Bangalore', 3),
('Witness statement', 'Park, Delhi', 4),
('Kidnapping notes', 'City center, Mumbai', 5),
('Fraudulent documents', 'Online platform', 6),
('Vandalism graffiti', 'Public property', 7),
('Stolen goods', 'House, Mumbai', 8),
('Illegal substances', 'Street, Bangalore', 9),
('Domestic dispute records', 'Home, Hyderabad', 10)

INSERT INTO Reports (IncidentID, ReportingOfficer, ReportDate, ReportDetails, Status) VALUES
(11, 1, '2024-01-16', 'Initial report filed by Inspector Arjun Singh.', 'Finalized'),
(12, 2, '2024-02-21', 'Investigation ongoing by Sub-Inspector Sunita Bhatia.', 'Draft'),
(3, 3, '2024-03-11', 'Case closed after recovery of stolen items.', 'Finalized'),
(4, 4, '2024-04-06', 'Assault report filed by Inspector Ravi Mishra.', 'Draft'),
(5, 5, '2024-05-16', 'Kidnapping case opened by Sub-Inspector Neha Ghosh.', 'Finalized'),
(6, 6, '2024-06-21', 'Fraud report filed by Constable Pooja Yadav.', 'Draft'),
(7, 7, '2024-07-11', 'Vandalism case reported by Inspector Suresh Gupta.', 'Finalized'),
(8, 8, '2024-08-13', 'Burglary report filed by Sub-Inspector Mohan Rao.', 'Draft'),
(9, 9, '2024-09-02', 'Drug possession case opened by Constable Anita Sharma.', 'Finalized'),
(10, 10, '2024-09-16', 'Domestic violence report filed by Inspector Rohan Verma.', 'Draft')


