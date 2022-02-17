# Setting the Current Working Directory
rm(list = ls())
setwd("/Users/bhavin/Documents/Fall 2021 - Semester (M1)/CIS 8695 - Big Data Analytics (Ling Xue)")

# Reading the Banks Dataset
fcBank <- read.csv("/Users/bhavin/Documents/Fall 2021 - Semester (M1)/CIS 8695 - Big Data Analytics (Ling Xue)/4.Homework Assignments/banks.csv")
# Dropping Observation, TotCap/Assets
fcBank <- fcBank[ , -c(1,3)]  

# Partitioning the Data
set.seed(123)
train.index <- sample(c(1:dim(fcBank)[1]), dim(fcBank)[1])
train.df <- fcBank[train.index, ]
valid.df <- fcBank[train.index, ]

# Running Logistic Regression
# Use glm() (General Linear Model) with family = "binomial" for Logistic Regression
logit.reg <- glm(Financial.Condition ~ ., data = train.df, family = "binomial") 
# Removing Scientific Notation
options(scipen=999) 
round(data.frame(summary(logit.reg)$coefficients, odds = exp(coef(logit.reg))),4)
summary(logit.reg)
logit.reg.pred <- predict(logit.reg, train.df, type = "response")

# Installing the "Caret" Package
install.packages("caret")
library(caret)
confusionMatrix(as.factor(ifelse(logit.reg.pred > 0.5,1,0)), 
                as.factor(train.df$Financial.Condition))

# Lease/Assets Ratio = 0.6, Expenses/Assets Ratio = 0.11
new.bank.df <- data.frame("TotExp.Assets"=0.11,"TotLns&Lses.Assets"=0.6)
new.bank.pred <- predict(logit.reg, new.bank.df, type = "response")
new.bank.pred