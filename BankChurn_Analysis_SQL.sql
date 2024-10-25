-- Switch to the database where the tables are stored
USE BankChurnProject;

/*
Calculate overall churn rate
*/
SELECT 
    (SELECT COUNT(*) FROM Exit_Customer) * 100.0 / (SELECT COUNT(*) FROM Customer_Info) AS Churn_Rate;

/*
Customer distribution by gender
*/
SELECT 
    Gender, 
    COUNT(*) AS Customer_Count
FROM Customer_Info CI
JOIN Gender G ON CI.customer_id = G.customer_id
GROUP BY Gender;

/*
Customer distribution by geography
*/
SELECT 
    Country, 
    COUNT(*) AS Customer_Count
FROM Customer_Info CI
JOIN Geography Geo ON CI.customer_id = Geo.customer_id
GROUP BY Country;

/*
Average credit score by geography
*/
SELECT 
    Country, 
    AVG(CC.Credit_Score) AS Avg_Credit_Score
FROM Credit_Card CC
JOIN Geography Geo ON CC.customer_id = Geo.customer_id
GROUP BY Country;

/*
Average age of customers
*/
SELECT 
    AVG(Age) AS Avg_Customer_Age
FROM Customer_Info;

/*
Distribution of active vs. exit customers
*/
SELECT 
    'Active' AS Customer_Status, COUNT(*) AS Customer_Count
FROM Active_Customer
UNION ALL
SELECT 
    'Exit' AS Customer_Status, COUNT(*)
FROM Exit_Customer;

/*
Top 5 District with the highest churn rate
*/
SELECT 
    Geo.Country, 
    COUNT(EC.customer_id) * 100.0 / COUNT(DISTINCT CI.customer_id) AS Churn_Rate
FROM Exit_Customer EC
JOIN Geography Geo ON EC.customer_id = Geo.customer_id
JOIN Customer_Info CI ON Geo.customer_id = CI.customer_id
GROUP BY Geo.Country
ORDER BY Churn_Rate DESC
LIMIT 5;

/*
Segmentation by Credit Score
*/
SELECT 
    CASE
        WHEN Credit_Score < 400 THEN 'Very Low'
        WHEN Credit_Score BETWEEN 400 AND 600 THEN 'Low'
        WHEN Credit_Score BETWEEN 601 AND 700 THEN 'Medium'
        WHEN Credit_Score BETWEEN 701 AND 800 THEN 'High'
        ELSE 'Very High'
    END AS Credit_Score_Range,
    COUNT(*) AS Customer_Count
FROM Credit_Card
GROUP BY Credit_Score_Range
ORDER BY Customer_Count DESC;

/*
Churn Rate by Gender and Geography
*/
SELECT 
    Geo.Country,
    G.Gender,
    COUNT(EC.customer_id) * 100.0 / COUNT(DISTINCT CI.customer_id) AS Churn_Rate
FROM Exit_Customer EC
JOIN Gender G ON EC.customer_id = G.customer_id
JOIN Geography Geo ON EC.customer_id = Geo.customer_id
JOIN Customer_Info CI ON Geo.customer_id = CI.customer_id
GROUP BY Geo.Country, G.Gender
ORDER BY Churn_Rate DESC;

/*
Average Balance of Active vs. Exit Customers
*/
SELECT 
    'Active' AS Customer_Status, AVG(Balance) AS Avg_Balance
FROM Active_Customer
UNION ALL
SELECT 
    'Exit' AS Customer_Status, AVG(Balance)
FROM Exit_Customer;

/*
Customer Retention by Age Group
*/
SELECT 
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 35 THEN '25-35'
        WHEN Age BETWEEN 36 AND 45 THEN '36-45'
        WHEN Age BETWEEN 46 AND 55 THEN '46-55'
        ELSE 'Above 55'
    END AS Age_Group,
    COUNT(AC.customer_id) AS Active_Customers,
    COUNT(EC.customer_id) AS Churned_Customers
FROM Customer_Info CI
LEFT JOIN Active_Customer AC ON CI.customer_id = AC.customer_id
LEFT JOIN Exit_Customer EC ON CI.customer_id = EC.customer_id
GROUP BY Age_Group
ORDER BY Age_Group;

/*
Top District by High-Balance Customers
*/
SELECT 
    Geo.Country, 
    COUNT(CI.customer_id) AS High_Balance_Customers
FROM Customer_Info CI
JOIN Active_Customer AC ON CI.customer_id = AC.customer_id
JOIN Geography Geo ON CI.customer_id = Geo.customer_id
WHERE AC.Balance > 100000
GROUP BY Geo.Country
ORDER BY High_Balance_Customers DESC
LIMIT 5;

/*
Analysis of Customer Tenure
*/
SELECT 
    Tenure, 
    COUNT(customer_id) AS Customer_Count
FROM Customer_Info
GROUP BY Tenure
ORDER BY Customer_Count DESC;

/*
Churn Rate by Tenure
*/
SELECT 
    CI.Tenure,
    COUNT(EC.customer_id) * 100.0 / COUNT(DISTINCT CI.customer_id) AS Churn_Rate
FROM Customer_Info CI
LEFT JOIN Exit_Customer EC ON CI.customer_id = EC.customer_id
GROUP BY CI.Tenure
ORDER BY CI.Tenure;

/*
Gender Distribution of High-Credit Customers
*/
SELECT 
    G.Gender,
    COUNT(Credit_Card.customer_id) AS High_Credit_Customers
FROM Credit_Card
JOIN Gender G ON Credit_Card.customer_id = G.customer_id
WHERE Credit_Card.Credit_Score > 750
GROUP BY G.Gender;

/*
Average Age of High-Balance Customers
*/
SELECT 
    AVG(CI.Age) AS Avg_Age
FROM Customer_Info CI
JOIN Active_Customer AC ON CI.customer_id = AC.customer_id
WHERE AC.Balance > 100000;

/*
Monthly Churn Trend Analysis
*/
SELECT 
    MONTH(Churn_Date) AS Month, 
    COUNT(*) AS Churn_Count
FROM Exit_Customer
GROUP BY MONTH(Churn_Date)
ORDER BY Month;
