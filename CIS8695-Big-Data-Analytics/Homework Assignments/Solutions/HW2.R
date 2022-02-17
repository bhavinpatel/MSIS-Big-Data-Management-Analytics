# Setting the Current Working Directory
rm(list = ls())
setwd("/Users/bhavin/Documents/Fall 2021 - Semester (M1)/CIS 8695 - Big Data Analytics (Ling Xue)")

# Reading the Souvenir Sales Dataset
souvenirSales <- read.csv("/Users/bhavin/Documents/Fall 2021 - Semester (M1)/CIS 8695 - Big Data Analytics (Ling Xue)/4.Homework Assignments/SouvenirSales.csv")
# install.packages("forecast")
library("forecast")
# Creating Time Series object using ts()
souvenir.ts <- ts(souvenirSales$Sales, start = c(1995,1), end = c(2001,12), frequency = 12)
# Plotting the Series
plot(souvenir.ts, xlab = "Time", ylab = "Sales", ylim = c(1600, 150000))
# Partitioning the Data
validLength <- 12
trainLength <- length(souvenir.ts) - validLength
souvenirTrain <- window(souvenir.ts, start = c(1995,1), end=c(1995, trainLength))
souvenirValid <- window(souvenir.ts, start=c(1995,trainLength+1), end = c(1995, trainLength + validLength))
# Model with Linear Trend and Monthly Seasonality
modelA <- tslm(souvenirTrain ~ trend + season)
sumA <- summary(modelA)
sumA
# Plotting the Series
plot(souvenir.ts, type = "n", xaxt = "n", yaxt = "n", xlab = "Year", ylab = " Souvenir Sales (in Thousands)", main = "Regression Model with Trend and Seasonality")
lines(souvenirTrain, col = "black", lwd = 2)
lines(modelA$fitted.values, col = "blue", lwd = 2)
axis(1, at=seq(1995,2002,1), labels=format(seq(1995,2002,1)))
axis(2, at = seq(0, 110000, 20000), labels = format(seq(0, 110, 20)), las = 2)
legend(1996, 100000, c("Souvenir Sales", "With Trend + Seasonality"), col = c("black", "blue"), lwd = c(2,2),  bty = "n", lty = c(1,1))
# Measuring Accuracy
accA <- accuracy(modelA$fitted.values, souvenirTrain)
accA
# Model with Exponential Trend and Multiplicative Seasonality
modelB <- tslm(souvenirTrain ~ trend + season, lambda=0)
sumB <- summary(modelB)
sumB
# Forecasting Sales for February 2022
febForecast <- modelB$coefficients["(Intercept)"] + modelB$coefficients["trend"]*86 + modelB$coefficients["season2"]
exp(febForecast)
# Comparing the Two Models 
modelAForecast <- forecast(modelA, h = validLength)
accuracy(modelAForecast$mean, souvenirValid)
modelBForecast <- forecast(modelB, h = validLength)
accuracy(modelBForecast$mean, souvenirValid)

#install.packages("zoo")
library("zoo")
# Running Holt-Winters Exponential Smoothing
hwin <- ets(souvenirTrain, model = "MAA")
# Creating the Predictions
hwin.pred <- forecast(hwin, h = validLength, level = 0)
# Plotting the Series
plot(hwin.pred, ylim = c(1600, 150000),  ylab = "Sales", xlab = "Time", 
     bty = "l", xaxt = "n", xlim = c(1995,2002), main = "Prediction using Holt-Winters Exp Smoothing", flty = 2)
axis(1, at = seq(1995, 2002, 1), labels = format(seq(1995, 2002, 1)))
lines(hwin.pred$fitted, lwd = 2, col = "blue")
lines(souvenirValid)
accuracy(hwin.pred, souvenirValid)
forecast(hwin,24)
plot(residuals(hwin))