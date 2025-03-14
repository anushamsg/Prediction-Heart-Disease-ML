library(tidyverse)
library(ggplot2)
library(stats)

#load  dataset
heart_disease <- read.csv("C:/Users/msgan/Downloads/HEART DISEASE WANG.csv")

#exploring the data
head(heart_disease)
cat("\n \n")
str(heart_disease)
cat("\n \n")
summary(heart_disease)
cat("\n \n")


#checking for missing values
colSums(is.na(heart_disease))

#Created box plots 
ggplot(heart_disease, aes(x=factor(Heart.Disease), y=Age)) +
  geom_boxplot() +
  labs(title="Comparison of Variable Age between Individuals with and without Heart Disease",
       x="Heart Disease Status",y="Variable Age")

ggplot(heart_disease, aes(x=factor(Heart.Disease), y=Cholesterol)) +
  geom_boxplot() +
  labs(title="Comparison of Variable Cholesterol between Individuals with and without Heart Disease",
       x="Heart Disease Status",y="Variable Cholesterol")


ggplot(heart_disease, aes(x=factor(Heart.Disease), y=BP)) +
  geom_boxplot() +
  labs(title="Comparison of Variable BP between Individuals with and without Heart Disease",
       x="Heart Disease Status",y="Variable BP")

#exploratory data analysis-visualize the distribution of variables
ggplot(heart_disease, aes(x = Age, fill = `Heart.Disease`)) +
  geom_histogram(alpha = 0.5, position = "dodge")

cat("assessing the frequency of heart disease across different ages")
cat("\n \n")

ggplot(heart_disease,aes(x=`Chest.pain.type`, fill=`Heart.Disease`)) +
  geom_bar(position="dodge") 

# Create a scatter plot for Age vs Cholesterol
ggplot(heart_disease, aes(x = Age, y = Cholesterol, color = factor(Heart.Disease))) +
  geom_point() +
  labs(title = "Scatter Plot: Age vs Cholesterol",
       x = "Age",
       y = "Cholesterol",
       color = "Heart Disease Status")

# Create a scatter plot for Age vs BP
ggplot(heart_disease, aes(x = Age, y = BP, color = factor(Heart.Disease))) +
  geom_point() +
  labs(title = "Scatter Plot: Age vs BP",
       x = "Age",
       y = "BP",
       color = "Heart Disease Status")

# Create a scatter plot for Cholesterol vs BP
ggplot(heart_disease, aes(x = Cholesterol, y = BP, color = factor(Heart.Disease))) +
  geom_point() +
  labs(title = "Scatter Plot: Cholesterol vs BP",
       x = "Cholesterol",
       y = "BP",
       color = "Heart Disease Status")

# Identify outliers for Age
age_outliers <- boxplot.stats(heart_disease$Age)$out
heart_disease_no_age_outliers <- heart_disease[!heart_disease$Age %in% age_outliers, ]

# Identify outliers for Cholesterol
cholesterol_outliers <- boxplot.stats(heart_disease$Cholesterol)$out
heart_disease_no_cholesterol_outliers <- heart_disease[!heart_disease$Cholesterol %in% cholesterol_outliers, ]

# Identify outliers for BP
bp_outliers <- boxplot.stats(heart_disease$BP)$out
heart_disease_no_bp_outliers <- heart_disease[!heart_disease$BP %in% bp_outliers, ]

# Combine the datasets without outliers
heart_disease_no_outliers <- intersect(heart_disease_no_age_outliers, heart_disease_no_cholesterol_outliers)
heart_disease_no_outliers <- intersect(heart_disease_no_outliers, heart_disease_no_bp_outliers)

#T-test for age and cholesterol levels
# Convert Heart.Disease to a factor if it's not already
heart_disease$Heart.Disease <-as.factor(heart_disease$Heart.Disease)

# T-Test for age
t_test_age <- t.test(Age ~ Heart.Disease, data =heart_disease)
print(t_test_age)

# T-Test for cholesterol
t_test_cholesterol <- t.test(Cholesterol ~ Heart.Disease, data =heart_disease)
print(t_test_cholesterol)

# T-Test for blod pressure
t_test_bp <- t.test(BP ~ Heart.Disease, data=heart_disease)
print(t_test_bp)

# Anova for more than two-groups, as we have more than two types of chest pain
anova_result <- aov(Cholesterol ~ Chest.pain.type, data=heart_disease)
summary(anova_result)

install.packages("caret") 
library(caret)

set.seed(123)

#load  dataset
heart_disease <- read.csv("C:/Users/msgan/Downloads/HEART DISEASE WANG.csv") 
#convert Heart.Disease to a factor
heart_disease$Heart.Disease <- as.factor(heart_disease$Heart.Disease)

#splitting data into training and testing dataset
trainIndex <- createDataPartition(heart_disease$Heart.Disease, p=0.8, list=FALSE)
data_train <- heart_disease[trainIndex,]
data_test <- heart_disease[-trainIndex,]

#define the training control
train_control <- trainControl(method ="cv", number=5, classProbs=TRUE, summaryFunction=twoClassSummary)

# Train the logistic regression model using caret's train function

model <- train(Heart.Disease ~ Age + Cholesterol + BP,
               data = data_train,
               method = "glm", # or "lm" as "binomial" as its a binary classification problem
               family = "binomial",
               trControl = train_control,
               metric = "Accuracy")

# summarize the results
print(model)

#make predictions on the test set
predictions <- predict(model, newdata = data_test)

#assessing the model's performance using confusionMatrix which will provide a host of metrics including accuracy, sensitivity, specificity, etc.
confusionMatrix(predictions, data_test$Heart.Disease)

#Compare and create a data frame to see the actual and predicted heart disease status
results <- data.frame(Actual_Heart_Disease = data_test$Heart.Disease, Predicted_Heart_Disease = predictions)

print(results)

# to compute the AUC,we need to get the predicted probabilities and use the roc() function from pROC package.
# install.packages("pROC")
library(pROC)

# Get predicted probabilities
probs <- predict(model, newdata = data_test, type = "prob")
roc_obj <- roc(response = data_test$Heart.Disease, predictor = probs$Presence)

# Print AUC
print(paste("Area Under the Curve (AUC):", auc(roc_obj)))




