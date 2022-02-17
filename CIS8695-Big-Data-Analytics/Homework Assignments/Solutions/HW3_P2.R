rm(list = ls())

# Setting the Current Working Directory
setwd("/Users/bhavin/Documents/MSIS - Big Data Analytics/Fall 2021 Semester/Fall 2021 - Semester (M1)/CIS 8695 - Big Data Analytics (Ling Xue)/Homework Assignments")
library(e1071)  
library(caret)
library(DMwR)    

# Installing the Packages
# install.packages("readxl")
library("readxl")
accidents.df <- read_excel("Accidents.xls", sheet="Data")
# Creating Dummy Variable "INJURY"
accidents.df$INJURY <- ifelse(accidents.df$MAX_SEV_IR>0, "yes", "no")
head(accidents.df)

injury.tb <- table(accidents.df$INJURY)
show(injury.tb)

# Calculating the Prediction
injury.prob =  scales::percent(injury.tb["yes"]/(injury.tb["yes"]+injury.tb["no"]),0.01)
injury.prob

# Partitioning the Data
set.seed(123)
train.index <- sample(c(1:dim(accidents.df)[1]), dim(accidents.df)[1]*0.6)  
train.df <- accidents.df[train.index,]
valid.df <- accidents.df[-train.index,]

# Run Naive Bayes
injury.nb <- naiveBayes(INJURY ~ ., data = train.df)
injury.nb

# Predicting the Probabilities
pred.prob <- predict(injury.nb, newdata = train.df, type = "raw")
## predict class membership
pred.class <- predict(injury.nb, newdata = train.df)
confusionMatrix(as.factor(pred.class), as.factor(train.df$INJURY))

## predict probabilities: Validation
pred.prob <- predict(injury.nb, newdata = valid.df, type = "raw")
## predict class membership
pred.class <- predict(injury.nb, newdata = valid.df)
confusionMatrix(as.factor(pred.class), as.factor(valid.df$INJURY))

