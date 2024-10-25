-- Switch to the database where the tables are stored
USE BankChurnProject;

/*
Step 1: Remove duplicates in each table based on the primary key or unique identifiers
*/
-- Remove duplicates from Active_Customer table
DELETE FROM Active_Customer
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Active_Customer
    GROUP BY customer_id
);

-- Remove duplicates from Bank_Churn table
DELETE FROM Bank_Churn
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Bank_Churn
    GROUP BY customer_id
);

-- Remove duplicates from Credit_Card table
DELETE FROM Credit_Card
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Credit_Card
    GROUP BY customer_id
);

-- Remove duplicates from Customer_Info table
DELETE FROM Customer_Info
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Customer_Info
    GROUP BY customer_id
);

-- Remove duplicates from Exit_Customer table
DELETE FROM Exit_Customer
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Exit_Customer
    GROUP BY customer_id
);

-- Remove duplicates from Gender table
DELETE FROM Gender
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Gender
    GROUP BY customer_id
);

-- Remove duplicates from Geography table
DELETE FROM Geography
WHERE id NOT IN (
    SELECT MIN(id)
    FROM Geography
    GROUP BY customer_id
);


/*
 Step 2: Handle missing values for numerical columns (e.g., replacing NULL with average)
*/
-- Handle missing values for Age column in the Customer_Info table
UPDATE Customer_Info
SET Age = (SELECT AVG(Age) FROM Customer_Info)
WHERE Age IS NULL;

-- Handle missing values for Credit_Score column in the Credit_Card table
UPDATE Credit_Card
SET Credit_Score = (SELECT AVG(Credit_Score) FROM Credit_Card)
WHERE Credit_Score IS NULL;


/*
Step 3: Handle missing values for categorical columns (e.g., replacing NULL with 'Unknown')
*/
-- Handle missing values for Gender table
UPDATE Gender
SET Gender = 'Unknown'
WHERE Gender IS NULL;

-- Handle missing values for Geography table
UPDATE Geography
SET Country = 'Unknown'
WHERE Country IS NULL;


/*
Step 4: Ensure consistent data formats for specific columns
*/
UPDATE Credit_Card
SET Credit_Score = ROUND(Credit_Score, 2);

/*
Step 5: Standardize categorical values (e.g., convert to uppercase)
*/
UPDATE Gender
SET Gender = UPPER(Gender);

UPDATE Geography
SET Country = UPPER(Country);
