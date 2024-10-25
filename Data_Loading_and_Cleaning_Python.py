import pandas as pd

# Load the datasets
active_customer = pd.read_csv('C:\Users\admin\OneDrive - University of Wollongong\Personal\Personal Projects\Bank-Churn-Data-Analysis\Data\Active Customer.csv')
bank_churn = pd.read_csv('C:\Users\admin\OneDrive - University of Wollongong\Personal\Personal Projects\Bank-Churn-Data-Analysis\Data\Bank_Churn.csv')
credit_card = pd.read_csv('C:\Users\admin\OneDrive - University of Wollongong\Personal\Personal Projects\Bank-Churn-Data-Analysis\Data\Credit Card.csv')
customer_info = pd.read_csv('C:\Users\admin\OneDrive - University of Wollongong\Personal\Personal Projects\Bank-Churn-Data-Analysis\Data\Customer Info.csv')
exit_customer = pd.read_csv('C:\Users\admin\OneDrive - University of Wollongong\Personal\Personal Projects\Bank-Churn-Data-Analysis\Data\Exit Customer.csv')
gender = pd.read_csv('C:\Users\admin\OneDrive - University of Wollongong\Personal\Personal Projects\Bank-Churn-Data-Analysis\Data\Gender.csv')
geography = pd.read_csv('C:\Users\admin\OneDrive - University of Wollongong\Personal\Personal Projects\Bank-Churn-Data-Analysis\Data\Geography.csv')

# Display initial information about the datasets to understand their structure
datasets_info = {
    "Active Customer": active_customer.info(),
    "Bank Churn": bank_churn.info(),
    "Credit Card": credit_card.info(),
    "Customer Info": customer_info.info(),
    "Exit Customer": exit_customer.info(),
    "Gender": gender.info(),
    "Geography": geography.info()
}

# Display the first few rows of each dataset
sample_data = {
    "Active Customer": active_customer.head(),
    "Bank Churn": bank_churn.head(),
    "Credit Card": credit_card.head(),
    "Customer Info": customer_info.head(),
    "Exit Customer": exit_customer.head(),
    "Gender": gender.head(),
    "Geography": geography.head()
}

# Return sample data for initial inspection
sample_data


# Datasets Overview
"""
Active Customer: Contains information about active membership status.
Bank Churn: Main dataset with detailed information like credit score, geography, gender, age, tenure, balance, etc.
Credit Card: Information on whether customers hold a credit card.
Customer Info: Basic customer information like ID and surname.
Exit Customer: Information on customers who have exited or retained.
Gender: Gender mapping for customers.
Geography: Geographic mapping for customers.
"""


# Data Cleaning
# Remove duplicates
active_customer.drop_duplicates(inplace=True)
bank_churn.drop_duplicates(inplace=True)
credit_card.drop_duplicates(inplace=True)
customer_info.drop_duplicates(inplace=True)
exit_customer.drop_duplicates(inplace=True)
gender.drop_duplicates(inplace=True)
geography.drop_duplicates(inplace=True)

# Handle missing values
# Replace missing numerical values with the mean
bank_churn.fillna(bank_churn.mean(), inplace=True)

# Replace missing categorical values with 'Unknown'
for col in ['GenderID', 'GeographyID']:
    bank_churn[col].fillna('Unknown', inplace=True)

# Merge tables for comprehensive analysis
# Merge Gender, Geography, and Credit Card information with Bank Churn dataset
bank_churn = bank_churn.merge(gender, left_on='GenderID', right_on='GenderID', how='left')
bank_churn = bank_churn.merge(geography, left_on='GeographyID', right_on='GeographyID', how='left')
bank_churn = bank_churn.merge(credit_card, left_on='CustomerId', right_on='CreditID', how='left')

# Merge Customer Info with Bank Churn dataset
bank_churn = bank_churn.merge(customer_info, on='CustomerId', how='left')