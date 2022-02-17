rm(list = ls())
# Set the Current Working Directory
setwd("/Users/bhavin/Documents/Fall 2021 - Semester (M1)/CIS 8695 - Big Data Analytics (Ling Xue)/1.Regression")
# Read the CSV File
Tayko.df <- read.csv("CSV_Tayko.csv")

# Select the Variables for Regression
selected.var <- c("sequence_number","Address_US","Freq","last_update","Web","Gender",
                  "Address_RES","Purchase","Spending")

# Partition the Data
set.seed(1)  # Set Seed for reproducing the Partition
train.index <- sample(c(1:dim(Tayko.df)[1]), dim(Tayko.df)[1]*0.6)  
train.df <- Tayko.df[train.index, ]
valid.df <- Tayko.df[-train.index, ]

# Linear Regression

# Use lm() to run Linear Regression of Price on 11 Predictors in the Training Set 
Tayko.lm <- lm(Spending ~ Address_US+Freq+last_update+Web+Gender+Address_RES, data = train.df)
# Use options() to ensure numbers are not displayed in Scientific Notation
options(scipen = 999)
# Get the Model Summary
summary(Tayko.lm)   

library(forecast)
Tayko.lm.pred <- predict(Tayko.lm, valid.df)

# Use accuracy() to compute common Accuracy Measures
accuracy(Tayko.lm.pred, valid.df$Spending)
mean(valid.df$Spending)

# Logistic Regression
# Use glm() (General Linear Model) with family = "binomial" to fit Logistic Regression.
Tayko.logit.reg <- glm(Purchase ~ Address_US+Freq+last_update+Web+Gender+Address_RES, data = train.df, family = "binomial") 

summary(Tayko.logit.reg)

# Use predict() with type = "response" to compute Predicted Probabilities. 
Tayko.logit.reg.pred <- predict(Tayko.logit.reg, valid.df, type = "response")

# Use Confusion Matrix to evaluate Performance
# install.packages("caret") 
library(caret)
Tayko.logit.reg.pred.Purchase<-ifelse(Tayko.logit.reg.pred > 0.5, 1, 0)
confusionMatrix(as.factor(Tayko.logit.reg.pred.Purchase), 
                as.factor(valid.df$Purchase))

# Variable Selection
null<-glm(Purchase ~ 1, data = train.df, family = "binomial") 
step(null, scope=list(lower=null, upper=Tayko.logit.reg), direction="forward")

install.packages('e1071', dependencies=TRUE)

# K-Fold Cross Validation
Tayko.df$Purchase2 <- factor(Tayko.df$Purchase, levels = c(0,1))
ctrl <- trainControl(method = "repeatedcv", number = 10, savePredictions = TRUE)
mod_fit <- train(Purchase2 ~ Address_US+Freq+last_update+Web+Gender+
                   Address_RES, data=Tayko.df, method="glm", family="binomial",
                 trControl = ctrl)
summary(mod_fit)
mod_fit$pred


