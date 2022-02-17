rm(list = ls())
# Setting the Current Working Directory
setwd("/Users/bhavin/Documents/MSIS - Big Data Analytics/Fall 2021 Semester/Fall 2021 - Semester (M1)/CIS 8695 - Big Data Analytics (Ling Xue)/Homework Assignments")

# Installing Required Packages
library(rpart)
# install.packages("rpart.plot")    
library(rpart.plot)

# Getting Rid of Dummy Variables
ebayAuctions.df <- read.csv("eBayAuctions.csv")
ebayAuctions.df <- ebayAuctions.df[, -c(6,7,8,19,20,22)]

# Partioning the Data
set.seed(123)  
train.index <- sample(c(1:dim(ebayAuctions.df)[1]), dim(ebayAuctions.df)[1]*0.6)  
train.df <- ebayAuctions.df[train.index, ]
valid.df <- ebayAuctions.df[-train.index, ]

# Classification Tree
default.ct <- rpart(Competitive ~ ., data = train.df, control = rpart.control(maxdepth=6),method = "class")
summary(default.ct)
printcp(default.ct)

# Plotting using prp()
prp(default.ct, type = 5, extra = 101,  clip.right.lab = FALSE, 
    box.palette = "GnYlRd", leaf.round = 5, 
    branch = .3, varlen = -10, space=0)  

# Decision Rules
rpart.rules(default.ct, cover = TRUE)

# Classifying Records
default.ct.pred.train <- predict(default.ct,train.df,type = "class")
default.ct.pred.valid <- predict(default.ct,valid.df,type = "class")
install.packages("caret") 
library(caret)
# Generating Confusion Matrix
confusionMatrix(default.ct.pred.valid, as.factor(valid.df$Competitive))

# Getting rid of Closing Price
ebayAuctionsExclude.df <- ebayAuctions.df[,-c(3)]

# Partioning the Data without Closing Price
set.seed(123)  
trainExclude.index <- sample(c(1:dim(ebayAuctionsExclude.df)[1]), dim(ebayAuctionsExclude.df)[1]*0.6)  
trainExclude.df <- ebayAuctionsExclude.df[trainExclude.index, ]
validExclude.df <- ebayAuctionsExclude.df[-trainExclude.index, ]

# Classification Tree
defaultExclude.ct <- rpart(Competitive ~ ., data = trainExclude.df, control = rpart.control(maxdepth=6),method = "class")
summary(defaultExclude.ct)
printcp(defaultExclude.ct)

# Plotting using prp()
prp(defaultExclude.ct, type = 5, extra = 101,  clip.right.lab = FALSE, 
    box.palette = "GnYlRd", leaf.round = 5, 
    branch = .3, varlen = -10, space=0)  

# Decision Rules
rpart.rules(defaultExclude.ct, cover = TRUE)

# Classifying Records
defaultExclude.ct.pred.train <- predict(defaultExclude.ct,trainExclude.df,type = "class")
defaultExclude.ct.pred.valid <- predict(defaultExclude.ct,validExclude.df,type = "class")
install.packages("caret") 
library(caret)
# Generating Confusion Matrix
confusionMatrix(defaultExclude.ct.pred.valid, as.factor(validExclude.df$Competitive))

## Random Forest
# install.packages("randomForest")
library(randomForest)
rf <- randomForest(as.factor(Competitive) ~ ., data = trainExclude.df, ntree = 500, 
mtry = 4, nodesize = 5, importance = TRUE)  
summary(rf)

## Plotting Forest by Prediction Errors
plot(rf)
legend("top", colnames(rf$err.rate),cex=0.8,fill=1:3)

## Variable Importance Plot
varImpPlot(rf, type = 1)

## Generating Confusion Matrix
rf.pred <- predict(rf, validExclude.df)
# library(caret)
confusionMatrix(rf.pred, as.factor(validExclude.df$Competitive))


