from Data_Loading_and_Cleaning_Python import bank_churn
import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import classification_report
from sklearn.preprocessing import LabelEncoder

# Basic Analysis
# Calculate churn rate
total_customers = bank_churn.shape[0]
churned_customers = bank_churn[bank_churn['Exited'] == 1].shape[0]
churn_rate = (churned_customers / total_customers) * 100

# Average credit score by geography
avg_credit_score_geography = bank_churn.groupby('GeographyLocation')['CreditScore'].mean()

# Distribution of active vs. exit customers
customer_status_distribution = bank_churn['Exited'].value_counts(normalize=True) * 100

# Average age of customers
avg_age = bank_churn['Age'].mean()

# Customer distribution by gender
gender_distribution = bank_churn['GenderCategory'].value_counts(normalize=True) * 100

# Display results
analysis_results = {
    "Total Customers": total_customers,
    "Churned Customers": churned_customers,
    "Churn Rate (%)": churn_rate,
    "Average Credit Score by Geography": avg_credit_score_geography,
    "Customer Status Distribution (%)": customer_status_distribution,
    "Average Customer Age": avg_age,
    "Customer Distribution by Gender (%)": gender_distribution
}
analysis_results




# Additional Analysis
# Tenure vs. Churn Rate
# Calculate churn rate for each tenure level
tenure_churn_rate = bank_churn.groupby('Tenure')['Exited'].mean() * 100

# Balance Analysis
# Calculate distribution of balances and churn risk
high_balance_customers = bank_churn[bank_churn['Balance'] > 100000]
high_balance_churn_rate = (high_balance_customers['Exited'].mean()) * 100

# Age Group Analysis
# Define age groups
age_bins = [0, 25, 35, 45, 55, 65, 100]
age_labels = ['<25', '25-35', '36-45', '46-55', '56-65', '>65']
bank_churn['Age_Group'] = pd.cut(bank_churn['Age'], bins=age_bins, labels=age_labels)

# Calculate churn rate by age group
age_group_churn_rate = bank_churn.groupby('Age_Group')['Exited'].mean() * 100

# Credit Card Ownership vs. Churn
# Analyze churn based on credit card ownership
credit_card_churn = bank_churn.groupby('Category')['Exited'].mean() * 100

# Geography-based Churn Rate
# Calculate churn rate by geography
geography_churn_rate = bank_churn.groupby('GeographyLocation')['Exited'].mean() * 100

# Product Holding vs. Churn
# Analyze churn based on the number of products held
product_churn_rate = bank_churn.groupby('NumOfProducts')['Exited'].mean() * 100

# Collect additional insights for display
additional_insights = {
    "Tenure vs. Churn Rate (%)": tenure_churn_rate,
    "High Balance Churn Rate (%)": high_balance_churn_rate,
    "Age Group Churn Rate (%)": age_group_churn_rate,
    "Credit Card Ownership vs. Churn Rate (%)": credit_card_churn,
    "Geography-based Churn Rate (%)": geography_churn_rate,
    "Product Holding vs. Churn Rate (%)": product_churn_rate
}

additional_insights



# Statistical Analysis
# Prepare the dataset for modeling
# Convert categorical variables to numerical using Label Encoding
label_encoders = {}
for column in ['GenderCategory', 'GeographyLocation', 'Category']:
    le = LabelEncoder()
    bank_churn[column] = le.fit_transform(bank_churn[column].astype(str))
    label_encoders[column] = le

# Define features and target variable
X = bank_churn[['CreditScore', 'GeographyLocation', 'GenderCategory', 'Age', 'Tenure', 
                'Balance', 'NumOfProducts', 'HasCrCard', 'IsActiveMember', 'EstimatedSalary']]
y = bank_churn['Exited']


# Correlation Analysis
correlation_matrix = bank_churn.corr()
churn_correlation = correlation_matrix['Exited'].sort_values(ascending=False)


# Decision Tree Classifier for Feature Importance
# Split the data into training and test sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

# Initialize and train the decision tree classifier
dt_model = DecisionTreeClassifier(random_state=42)
dt_model.fit(X_train, y_train)

# Calculate feature importance
feature_importance = pd.Series(dt_model.feature_importances_, index=X.columns).sort_values(ascending=False)


# Display results
factors_contributing_to_churn = {
    "Correlation with Churn": churn_correlation,
    "Top Contributing Factors (Decision Tree)": feature_importance
}

factors_contributing_to_churn