CREATE TABLE [User] (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Username VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(100) NOT NULL,
    ConfirmPassword VARCHAR(100) NOT NULL,
    Age INT CHECK (Age BETWEEN 12 AND 100) NOT NULL,
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')) NOT NULL,
    CONSTRAINT CHK_PasswordMatch CHECK (Password = ConfirmPassword)
);


CREATE TABLE TestScores (
    ID VARCHAR(50),  
    DBN VARCHAR(10),
    SchoolName VARCHAR(255),
    Grade VARCHAR(50),
    Year VARCHAR(50),
    Category VARCHAR(50),
    NumberTested VARCHAR(50),
    MeanScaleScore VARCHAR(50),
    Level1Count VARCHAR(10),
    Level1Percent VARCHAR(10),
    Level2Count VARCHAR(10),
    Level2Percent VARCHAR(10),
    Level3Count VARCHAR(10),
    Level3Percent VARCHAR(10),
    Level4Count VARCHAR(10),
    Level4Percent VARCHAR(10),
    Level3_4Count VARCHAR(10),
    Level3_4Percent VARCHAR(10),
    Subject VARCHAR(50)
);

BULK INSERT TestScores
FROM 'C:\Users\kennw\Documents\SQL Server Management Studio\combined_test_scores.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    TABLOCK	
);

ALTER TABLE TestScores
ADD UserId INT NULL;

ALTER TABLE TestScores
ADD CONSTRAINT FK_TestScores_User
FOREIGN KEY (UserId)
REFERENCES [User](Id)
ON DELETE SET NULL;


CREATE TABLE Schools (
    SchoolId INT PRIMARY KEY IDENTITY(1,1),
    DBN VARCHAR(10) UNIQUE,
    SchoolName VARCHAR(255),
    Neighborhood VARCHAR(100)
);

ALTER TABLE TestScores ADD SchoolId INT;

DELETE FROM TestScores
WHERE DBN NOT IN (SELECT DBN FROM Schools);


ALTER TABLE TestScores
ADD CONSTRAINT FK_TestScores_Schools
FOREIGN KEY (DBN)
REFERENCES Schools(DBN)
ON UPDATE CASCADE;

ALTER TABLE Schools ADD AvgScaleScore FLOAT;

UPDATE Schools SET DBN = '01M015X' WHERE DBN = '01M015';

SELECT * FROM TestScores WHERE DBN = '01M015X';

SELECT Neighborhood, AVG(AvgScaleScore) AS AvgNeighborhoodScore
FROM Schools
WHERE AvgScaleScore IS NOT NULL
GROUP BY Neighborhood
ORDER BY AvgNeighborhoodScore DESC;

UPDATE Schools
SET AvgScaleScore = (
    SELECT AVG(TRY_CAST(MeanScaleScore AS FLOAT))
    FROM TestScores
    WHERE TestScores.DBN = Schools.DBN
);

