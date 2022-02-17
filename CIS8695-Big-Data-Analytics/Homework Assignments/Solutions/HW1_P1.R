# Setting the Current Working Directory
rm(list = ls())
setwd("/Users/bhavin/Documents/Fall 2021 - Semester (M1)/CIS 8695 - Big Data Analytics (Ling Xue)")

# Reading the Boston Housing Dataset
boston <- read.csv("/Users/bhavin/Documents/Fall 2021 - Semester (M1)/CIS 8695 - Big Data Analytics (Ling Xue)/4.Homework Assignments/BostonHousing.csv")

# Displaying the Class and Structure of Dataset
class(boston)
str(boston)

# Displaying the Summary of Dataset
summary(boston)

# Getting rid of CAT.MEDV variable
reduced.boston <- c("MEDV", "CRIM", "CHAS", "RM")

# Partitioning the Data
set.seed(123)  
train.index <- sample(c(1:dim(boston)[1]), dim(boston)[1]*0.6)
train.df <- boston[train.index,reduced.boston]
valid.df <- boston[-train.index, reduced.boston]

# Using lm() to run Linear Regression Model
boston.lm <- lm(MEDV ~., data = train.df)
# Using options() to ensure numbers not in Scientific Notation
options(scipen = 999)
summary(boston.lm)  

# Installing "Forecast" Package
install.packages("forecast") 
library(forecast)

# Making the Predictions
boston.lm.pred <- predict(boston.lm, valid.df)
boston.residuals <- valid.df$MEDV[1:20] - boston.lm.pred[1:20]
data.frame("Predicted" = boston.lm.pred[1:20], "Actual" = valid.df$MEDV[1:20],
           "Residual" = boston.residuals)
accuracy(boston.lm.pred, valid.df$MEDV)

# Calculating Median price when CRIM=0.1, CHAS=0 and RM=6
boston.new.df <- data.frame("CRIM" = 0.1,"CHAS"= 0,"RM"=6)
boston.new.predict <- predict(boston.lm,boston.new.df)
boston.new.predict
boston.new.pred <- predict(boston.lm,valid.df)
boston.residuals <- valid.df$MEDV[1:20] - boston.lm.pred[1:20]
data.frame("Predicted" = boston.lm.pred[1:20], "Actual" = valid.df$MEDV[1:20],
           "Residual" = boston.residuals)
options(scipen=999, digits = 3)
accuracy(boston.lm.pred, valid.df$MEDV)

# Using step() to run Stepwise Regression
# Set Directions =  Backward/Foward/Both
reduced.boston.stepwise<-c("CRIM","ZN","INDUS","CHAS","NOX","RM",
                           "AGE","DIS","RAD", "TAX","PTRATIO","LSTAT",
                           "MEDV")
set.seed(99)
train.index.stepwise<- sample(c(1:dim(boston)[1]), dim(boston)[1]*0.6) 
train.stepwise.df<-boston[train.index.stepwise,reduced.boston.stepwise]
valid.stepwise.df<-boston[-train.index.stepwise,reduced.boston.stepwise]
boston.lm.whole<-lm(MEDV ~., data=train.stepwise.df)

# Direction = Both 
boston.lm.stepwise.both <- step(boston.lm.whole, direction = "both")
summary(boston.lm.stepwise.both)
boston.lm.stepwise.both.pred <- predict(boston.lm.stepwise.both, valid.stepwise.df)
print("Both")
accuracy(boston.lm.stepwise.both.pred, valid.stepwise.df$MEDV)

# Direction = Backward 
boston.lm.stepwise.back <- step(boston.lm.whole, direction = "backward")
summary(boston.lm.stepwise.back)  
boston.lm.stepwise.back.pred <- predict(boston.lm.stepwise.back, valid.stepwise.df)
print("Backward")
accuracy(boston.lm.stepwise.back.pred, valid.stepwise.df$MEDV)

# Direction = Forward 
null=lm(MEDV~1, data=train.stepwise.df)
boston.lm.stepwise.for <- step(null, scope=list(lower=null, upper=boston.lm.whole), direction="forward")
summary(boston.lm.stepwise.for)  
boston.lm.stepwise.for.pred <- predict(boston.lm.stepwise.for, valid.stepwise.df)
print("Forward")
accuracy(boston.lm.stepwise.for.pred, valid.stepwise.df$MEDV)

# Collecting RMSE/MAPE/Mean Error 
comparetest <- data.frame(
  backwards = c(accuracy(boston.lm.stepwise.back.pred, valid.stepwise.df$MEDV)),
  foward = c(accuracy(boston.lm.stepwise.for.pred, valid.stepwise.df$MEDV)),
  both = c(accuracy(boston.lm.stepwise.both.pred, valid.stepwise.df$MEDV))
  )
rownames(comparetest) <- c("ME","RMSE","MAE","MPE","MAPE")
comparetest

# Installing the "Gains" Package
# install.packages("gains")
library("gains")

actual = valid.df$MEDV

# Lift Chart for "Backwards"
gain1 = gains(actual, boston.lm.stepwise.back.pred, group=10)
plot(c(0, gain1$cume.pct.of.total*sum(actual))~c(0, gain1$cume.obs), type = "l", xlab = "#Cases", ylab = "Cumulative MEDV", main = "Lift Chart for Backwards")
segments(0, 0, nrow(valid.df), sum(actual), lty = "dashed", col = "red", lwd = 2)
# Lift Chart for "Fowards"
gain2 = gains(actual, boston.lm.stepwise.for.pred, group=10)
plot(c(0, gain2$cume.pct.of.total*sum(actual))~c(0, gain2$cume.obs), type = "l", xlab = "#Cases", ylab = "Cumulative MEDV", main = "Lift Chart for Fowards")
segments(0, 0, nrow(valid.df), sum(actual), lty = "dashed", col = "red", lwd = 2)
# Lift Chart for "Both"
gain3 = gains(actual, boston.lm.stepwise.both.pred, group=10)
plot(c(0, gain3$cume.pct.of.total*sum(actual))~c(0, gain3$cume.obs), type = "l", xlab = "#Cases", ylab = "Cumulative MEDV", main = "Lift Chart for Both")
segments(0, 0, nrow(valid.df), sum(actual), lty = "dashed", col = "red", lwd = 2)