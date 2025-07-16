# Prediction-Heart-Disease-ML

# README: Exploring Risk Factors and Prediction of Heart Disease using Machine Learning

## Project Summary

This project aims to explore key risk factors contributing to heart disease and develop a predictive model using machine learning techniques. The focus is on understanding the impact of variables such as age, cholesterol, and blood pressure, and using logistic regression to predict the presence or absence of heart disease.

## Dataset

* Source: [Kaggle – Heart Disease Prediction](https://www.kaggle.com/datasets/rishidamarla/heart-disease-prediction)
* Origin: UCI Machine Learning Repository
* Observations: 270
* Variables: 14 (Target variable: Heart Disease – binary)

## Objectives

* Conduct descriptive and exploratory data analysis
* Perform hypothesis testing (T-tests, ANOVA)
* Build and evaluate a logistic regression model using the `caret` package in R
* Identify key predictors of heart disease

## Hypothesis Testing

**Null Hypothesis (H0):** No significant difference in age, cholesterol, and blood pressure between individuals with and without heart disease.
**Alternative Hypothesis (H1):** Significant differences exist in these variables between the groups.

### Statistical Methods

* T-tests for Age, BP, Cholesterol
* ANOVA to evaluate cholesterol across chest pain types
* Data visualization (box plots, scatter plots, histograms)

## Machine Learning Model

* **Algorithm:** Logistic Regression
* **Tool:** R (`caret` package)
* **Metrics Evaluated:**

  * Accuracy
  * Sensitivity (71.7%)
  * Specificity (53.3%)
  * ROC AUC (0.669)
  * Kappa (-0.1974)
  * McNemar’s Test (p = 0.2812)
  * Confusion Matrix
  * Precision, NPV, Detection Rate, Balanced Accuracy (40.42%)

## Data Preparation and Quality Control

* Checked and removed outliers (Age, BP, Cholesterol)
* Verified no missing values
* Converted categorical variables using `as.factor()`
* Split dataset into training and testing sets
* Used 5-fold cross-validation
* Ensured reproducibility and model reliability through validation

## Key Findings

* Age and cholesterol levels significantly differ between groups with and without heart disease.
* Blood pressure also showed a statistical difference despite unclear visual trends.
* ANOVA did not find a significant relationship between cholesterol and chest pain types.
* The logistic regression model had moderate sensitivity but overall poor performance in specificity and predictive accuracy.
* Class imbalance and limited feature set reduced model effectiveness.

## Limitations

* Limited predictors used in the model
* Imbalanced dataset
* Model tuning and feature engineering not fully explored
* Logistic regression may be outperformed by more complex models (e.g., Random Forest, SVM)

## Recommendations for Future Work

* Incorporate more diverse and clinically relevant features
* Address class imbalance through sampling techniques
* Explore alternative algorithms for improved predictive accuracy
* Apply external validation and model tuning for generalizability

