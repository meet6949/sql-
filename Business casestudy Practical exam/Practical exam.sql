

CREATE DATABASE ChurnDB;
USE ChurnDB;

CREATE TABLE CustomerSubscriptions (
    CustomerID VARCHAR(10),
    Name VARCHAR(50),
    Age INT,
    Gender VARCHAR(10),
    SubscriptionType VARCHAR(20),
    SubscriptionDate DATE,
    LastLoginDate DATE,
    TotalSessions INT,
    FeedbackScore INT,
    IsChurned INT
);

LOAD DATA LOCAL INFILE "E:\my\CustomerSubscriptions_200.csv"
INTO TABLE CustomerSubscriptions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


SELECT SubscriptionType,
COUNT(CASE WHEN IsChurned=0 THEN 1 END) AS Active,
COUNT(CASE WHEN IsChurned=1 THEN 1 END) AS Churned
FROM CustomerSubscriptions
GROUP BY SubscriptionType;

SELECT SubscriptionType, Gender, AVG(FeedbackScore)
FROM CustomerSubscriptions
GROUP BY SubscriptionType, Gender;

SELECT *
FROM CustomerSubscriptions
WHERE TotalSessions < 5 AND FeedbackScore < 5;


SELECT *
FROM CustomerSubscriptions
WHERE LastLoginDate < CURDATE() - INTERVAL 60 DAY;


SELECT SubscriptionType,
COUNT(*) AS Total,
SUM(IsChurned) AS Churned,
(SUM(IsChurned)/COUNT(*))*100 AS ChurnRate
FROM CustomerSubscriptions
GROUP BY SubscriptionType;


SELECT *
FROM CustomerSubscriptions
ORDER BY SubscriptionDate ASC
LIMIT 10;


SELECT 
CASE 
WHEN Age <= 25 THEN '18-25'
WHEN Age <= 35 THEN '26-35'
WHEN Age <= 45 THEN '36-45'
ELSE '45+'
END AS AgeGroup,
COUNT(*) Total,
SUM(IsChurned) Churned
FROM CustomerSubscriptions
GROUP BY AgeGroup;