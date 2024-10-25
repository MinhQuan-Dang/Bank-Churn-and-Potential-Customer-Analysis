from Data_Loading_and_Cleaning_Python import bank_churn
import pandas as pd

# Identify potential customers based on high credit scores (>700) and high balances (>100,000)
potential_customers = bank_churn[(bank_churn['CreditScore'] > 700) & (bank_churn['Balance'] > 100000)]

# Analyze average tenure of potential customers
avg_tenure_potential_customers = potential_customers['Tenure'].mean()

# Analyze product engagement for potential customers
product_engagement_potential_customers = potential_customers['NumOfProducts'].value_counts()

# Distribution of potential customers by geography
geography_distribution_potential_customers = potential_customers['GeographyLocation'].value_counts()

# Distribution of potential customers by age group
age_bins = [0, 25, 35, 45, 55, 65, 100]
age_labels = ['<25', '25-35', '36-45', '46-55', '56-65', '>65']
potential_customers['Age_Group'] = pd.cut(potential_customers['Age'], bins=age_bins, labels=age_labels)
age_group_distribution_potential_customers = potential_customers['Age_Group'].value_counts()

# Distribution of active vs. inactive potential customers
active_status_distribution_potential_customers = potential_customers['IsActiveMember'].value_counts(normalize=True) * 100

# Collect insights for potential customer analysis
potential_customer_insights = {
    "Average Tenure of Potential Customers": avg_tenure_potential_customers,
    "Product Engagement of Potential Customers": product_engagement_potential_customers,
    "Geography Distribution of Potential Customers": geography_distribution_potential_customers,
    "Age Group Distribution of Potential Customers": age_group_distribution_potential_customers,
    "Active vs. Inactive Status of Potential Customers (%)": active_status_distribution_potential_customers
}

# Display the insights
for key, value in potential_customer_insights.items():
    print(f"{key}:\n{value}\n")

potential_customer_insights