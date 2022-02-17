# Set the Current Working Directory
rm(list = ls())
setwd("/Users/bhavin/Documents/Fall 2021 - Semester (M1)/CIS 8695 - Big Data Analytics (Ling Xue)/2.Time Series")
library(forecast)

# Read the Kaggle Dataset
KaggleSearch.data <- read.csv("Kaggle_SearchTerm.csv")

# Create the Time Series
KaggleSearch.ts <- ts(KaggleSearch.data$analytics, 
                         start = c(2014, 51), end = c(2019, 51), freq = 52)

# Partition the Data
nValid <- 78
nTrain <- length(KaggleSearch.ts) - nValid

train.ts <- window(KaggleSearch.ts, start = c(2014, 51), end = c(2014, nTrain))
valid.ts <- window(KaggleSearch.ts, start = c(2014, nTrain + 1), 
                   end = c(2014, nTrain + nValid))

# Generate Naive and Seasonal Naive Forecasts
naive.pred <- naive(train.ts, h = nValid)
snaive.pred <- snaive(train.ts, h = nValid)

# Prediction Accuracy
accuracy(naive.pred, valid.ts)
accuracy(snaive.pred, valid.ts)

# Fit Linear Trend Model and Forecasts
train.lm <- tslm(train.ts ~ trend)
train.lm.pred <- forecast(train.lm, h = nValid, level = 0)
summary(train.lm)

# Plot Forecasted values and Residuals
plot(train.lm.pred, ylim = c(30, 120),  ylab = "Analytics", xlab = "Time", 
     bty = "l", xaxt = "n", xlim = c(2014,2020), main = "", flty = 2)
axis(1, at = seq(2014, 2020, 1), labels = format(seq(2014, 2020, 1)))
lines(train.lm.pred$fitted, lwd = 2, col = "blue")
lines(valid.ts)

# Nonlinear Method
train.lm.poly.trend <- tslm(train.ts ~ trend + I(trend^2))
summary(train.lm.poly.trend)
train.lm.poly.trend.pred <- forecast(train.lm.poly.trend, h = nValid, level = 0)

# Plot Nonlinear Method
plot(train.lm.poly.trend.pred, ylim = c(30, 120),  ylab = "Analytics", 
     xlab = "Time", bty = "l", xaxt = "n", xlim = c(2014, 2020), main = "", flty = 2)
axis(1, at = seq(2014, 2020, 1), labels = format(seq(2014, 2020, 1))) 
lines(train.lm.poly.trend$fitted, lwd = 2, col="blue")
lines(valid.ts)

plot(train.lm.pred$residuals, ylim = c(-50, -50),  ylab = "Forecast Error", 
     xlab = "Time", bty = "l", xaxt = "n", xlim = c(2014, 2020), main = "")
axis(1, at = seq(2014, 2020, 1), labels = format(seq(2014, 2020, 1)))
lines(valid.ts - train.lm.pred$mean, lwd = 1)

# Seasonal and Quadratic Trend
train.lm.trend.season <- tslm(train.ts ~ trend + I(trend^2) + season)
summary(train.lm.trend.season)

train.lm.trend.season.pred <- forecast(train.lm.trend.season, h = nValid, level = 0)
plot(train.lm.trend.season.pred, ylim = c(30, 120),  ylab = "Analytics", 
     xlab = "Time", bty = "l", xaxt = "n", xlim = c(2014, 2020), main = "", flty = 2)
axis(1, at = seq(2014, 2020, 1), labels = format(seq(2014, 2020, 1))) 
lines(train.lm.trend.season.pred$fitted, lwd = 2)
lines(valid.ts)

# Smoothing

residuals.ts <- train.lm.trend.season$residuals

ses <- ets(residuals.ts, model = "ANN", alpha = 0.2)
ses.pred <- forecast(ses, h = nValid, level = 0)

plot(ses.pred, ylim = c(-250, 300),  ylab = "Residuals", xlab = "Time", 
     bty = "l", xaxt = "n", xlim = c(2014,2020), main = "", flty = 2)
axis(1, at = seq(2014, 2020, 1), labels = format(seq(2014, 2020, 1)))
lines(ses.pred$fitted, lwd = 2, col = "blue")

# Try Holt Winters Exponential Smoothing

# Read the Yellowstone Dataset
library(forecast)
YS.data <- read.csv("Yellowstone.csv")

# Create the Time Series
YS.ts <- ts(YS.data$Recreation.Visits, 
                      start = c(1986, 1), end = c(2016, 9), freq = 12)

# Partition the Data
nValid <- 60
nTrain <- length(YS.ts) - nValid

train.ts <- window(YS.ts, start = c(1986, 1), end = c(1986, nTrain))
valid.ts <- window(YS.ts, start = c(1986, nTrain + 1), 
                   end = c(1986, nTrain + nValid))

# Holt-Winters Exponential Smoothing
hwin <- ets(train.ts, model = "MAA")

hwin.pred <- forecast(hwin, h = nValid, level = 0)

plot(hwin.pred, ylim = c(6000, 100000),  ylab = "Visits", xlab = "Time", 
     bty = "l", xaxt = "n", xlim = c(1986,2016), main = "", flty = 2)
axis(1, at = seq(1986, 2016, 1), labels = format(seq(1986, 2016, 1)))
lines(hwin.pred$fitted, lwd = 2, col = "blue")
lines(valid.ts)

accuracy(hwin.pred, valid.ts)
accuracy(train.lm.trend.season.pred, valid.ts)


