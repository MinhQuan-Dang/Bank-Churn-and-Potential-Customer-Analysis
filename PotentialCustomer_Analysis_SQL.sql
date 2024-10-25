-- Switch to the database where your tables are stored
USE BankChurnProject;

-- Identify customers with high credit scores (above 700) and high balances (above 100,000)
SELECT 
    CustomerId, 
    CreditScore, 
    Balance, 
    IsActiveMember, 
    NumOfProducts, 
    EstimatedSalary
FROM Bank_Churn
WHERE CreditScore > 700 AND Balance > 100000;

-- Analyze average tenure of potential customers
SELECT 
    AVG(Tenure) AS Avg_Tenure
FROM Bank_Churn
WHERE CreditScore > 700 AND Balance > 100000;

-- Analyze product engagement for potential customers
SELECT 
    NumOfProducts, 
    COUNT(*) AS Customer_Count
FROM Bank_Churn
WHERE CreditScore > 700 AND Balance > 100000
GROUP BY NumOfProducts
ORDER BY Customer_Count DESC;

-- Distribution of potential customers by geography
SELECT 
    GeographyLocation, 
    COUNT(CustomerId) AS Potential_Customer_Count
FROM Bank_Churn BC
JOIN Geography G ON BC.GeographyID = G.GeographyID
WHERE CreditScore > 700 AND Balance > 100000
GROUP BY GeographyLocation
ORDER BY Potential_Customer_Count DESC;
