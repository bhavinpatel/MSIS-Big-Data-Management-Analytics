# Setting the Current Working Directory
rm(list = ls())
setwd("/Users/bhavin/Documents/Fall 2021 - Semester (M1)/CIS 8695 - Big Data Analytics (Ling Xue)/3.Trees")
delays.df <- read.csv("CSV_FlightDelays.csv")

# Creating dummies
delays.df$Weekend <- delays.df$DAY_WEEK %in% c(6, 7)
delays.df$CARRIER_CO_MQ_DH_RU <- delays.df$CARRIER %in% c("CO", "MQ", "DH", "RU")
delays.df$MORNING <- delays.df$CRS_DEP_TIME.1 %in% c(6, 7, 8, 9)
delays.df$NOON <- delays.df$CRS_DEP_TIME.1 %in% c(10, 11, 12, 13)
delays.df$AFTER2P <- delays.df$CRS_DEP_TIME.1 %in% c(14, 15, 16, 17, 18)
delays.df$EVENING <- delays.df$CRS_DEP_TIME.1 %in% c(19, 20)

selected.var <- c("Flight.Status", "MORNING", "NOON", "AFTER2P", "EVENING", 
                  "CARRIER_CO_MQ_DH_RU","DEST","DISTANCE","Weather",
                  "Weekend")

# Package to install tree based model
# install.packages("rpart")
library(rpart)
# install.packages("rpart.plot")    # Installation is required for the first of use
library(rpart.plot)

# Partioning the Dataset
set.seed(1)  
train.index <- sample(c(1:dim(delays.df)[1]), dim(delays.df)[1]*0.6)  
train.df <- delays.df[train.index, selected.var]
valid.df <- delays.df[-train.index, selected.var ]

# classification tree
default.ct <- rpart(Flight.Status ~ ., data = train.df, method = "class")
summary(default.ct)

# define rpart.control() in rpart() to determine the depth of the tree.
default.ct <- rpart(Flight.Status ~ ., data = train.df, 
                    control = rpart.control(maxdepth = 5), method = "class")
summary(default.ct)

# plot using prp()
prp(default.ct, type = 5, extra = 101,  clip.right.lab = FALSE, 
    box.palette = "GnYlRd", leaf.round = 5, 
    branch = .3, varlen = -10, space=0)  


# Look at decision rules
rpart.rules(default.ct, cover = TRUE)

# Grow a full tree, 
deeper.ct <- rpart(Flight.Status ~ ., data = train.df, method = "class", 
                   cp = 0, minsplit = 1)

# count number of leaves
length(deeper.ct$frame$var[deeper.ct$frame$var == "<leaf>"])
# plot tree
prp(deeper.ct, type = 1, extra = 1, under = TRUE, split.font = 1, varlen = -10, 
    box.col=ifelse(deeper.ct$frame$var == "<leaf>", 'gray', 'white'))  

# Use Complexity Parameter (CP) to determine optimal stopping of growth, 
# argument xval refers to the number of folds to use in rpart's built-in cross-validation procedure
# argument cp sets the smallest value for the complexity parameter.
cv.ct <- rpart(Flight.Status ~ ., data = train.df, method = "class", 
               cp = 0.00001, minsplit = 5, xval = 5)
# use printcp() to print the table. 
printcp(cv.ct)

# prune tree by lower cp, 
pruned.ct <- prune(cv.ct, 
                   cp = cv.ct$cptable[which.min(cv.ct$cptable[,"xerror"]),"CP"])
length(pruned.ct$frame$var[pruned.ct$frame$var == "<leaf>"])
prp(pruned.ct, type = 5, extra = 101, cex=0.6, box.palette = "GnYlRd", 
    branch = .3, varlen = -10, space=0, yspace=0) 

#### Find optimal CP, and build tree accordingly
set.seed(1)
cv.ct <- rpart(Flight.Status ~ ., data = train.df, method = "class", cp = 0.00001, 
               minsplit = 1, xval = 5)  # minsplit is the minimum number of observations in a node for a split to be attempted. xval is number K of folds in a K-fold cross-validation.
printcp(cv.ct)  # Print out the cp table of cross-validation errors. The R-squared for a regression tree is 1 minus rel error. xerror (or relative cross-validation error where "x" stands for "cross") is a scaled version of overall average of the 5 out-of-sample errors across the 5 folds.
pruned.ct <- prune(cv.ct, cp = 0.0169697)
prp(pruned.ct, type = 5, extra = 101, leaf.round = 5, tweak=1.2, 
    branch = .3, varlen = -10, space=0, yspace=0, box.palette = "GnYlRd") 
pruned.ct <- prune(cv.ct, cp = cv.ct$cptable[which.min(cv.ct$cptable[,"xerror"]),"CP"])
prp(pruned.ct, type = 5, extra = 101, leaf.round = 5, tweak=1.2, 
    branch = .3, varlen = -10, space=0, yspace=0, box.palette = "GnYlRd") 

## random forest
install.packages("randomForest")
library(randomForest)
rf <- randomForest(as.factor(Flight.Status) ~ ., data = train.df, ntree = 500, 
                   mtry = 4, nodesize = 5, importance = TRUE)  
summary(rf)
head(rf$votes,10)

## Plot forest by prediction errors
plot(rf)
legend("top", colnames(rf$err.rate),cex=0.8,fill=1:3)

## variable importance plot
varImpPlot(rf, type = 1)

## confusion matrix
rf.pred <- predict(rf, valid.df)
# install.packages("caret")
library(caret)
confusionMatrix(rf.pred, as.factor(valid.df$Flight.Status))

# Boosting tree approach 
install.packages("adabag")
library(adabag)

train.df$Flight.Status <- as.factor(train.df$Flight.Status)

set.seed(1)
boost <- boosting(Flight.Status ~ ., data = train.df)
boost$trees[100]
pred <- predict(boost, valid.df)
confusionMatrix(as.factor(pred$class), as.factor(valid.df$Flight.Status))

