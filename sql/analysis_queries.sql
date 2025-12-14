

--Switchs to Database
USE CarAccidents;
GO

-- Creates table for imports
IF OBJECT_ID('AccidentsTemp', 'U') IS NOT NULL
    DROP TABLE AccidentsTemp;
GO

CREATE TABLE AccidentsTemp (
    Year VARCHAR(10),
    Month VARCHAR(10),
    Day VARCHAR(10),
    Weekend VARCHAR(10),
    Hour VARCHAR(10),
    Collision_Type VARCHAR(150),
    Injury_Type VARCHAR(150),
    Primary_Factor VARCHAR(200),
    Reported_Location VARCHAR(200)
);
GO

--Import dataset from CSV
BULK INSERT AccidentsTemp
FROM '<PATH_TO_CSV_FILE>'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);
GO


--Analysis Queries

--Accidents by Year
SELECT Year, COUNT(*) AS TotalAccidents
FROM AccidentsTemp
GROUP BY Year
ORDER BY Year;

-- By Hour
SELECT Hour, COUNT(*) AS TotalAccidents
FROM AccidentsTemp
GROUP BY Hour
ORDER BY Hour;

-- Weekend vs Weekdays
SELECT Weekend, COUNT(*) AS TotalAccidents
FROM AccidentsTemp
GROUP BY Weekend;

--By Collistion Type
SELECT Collision_Type, COUNT(*) AS TotalAccidents
FROM AccidentsTemp
GROUP BY Collision_Type
ORDER BY TotalAccidents DESC;
