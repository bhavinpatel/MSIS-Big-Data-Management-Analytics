install.packages("DALEX")
install.packages("DALEXtra")

library("tidyverse")
library("DALEX")
library("DALEXtra")

library(rms)
?rcs
titanic 
View(titanic)

apartments 
View(apartments)
View(apartments_test)
x = titanic[, -9]
View(x)

titanic = titanic %>% 
  mutate(country =  as.character(country)) %>% 
  replace_na(list(age = 30, country = "X", sibsp = 0, parch = 0)) %>% 
  mutate(country =  factor(country)) 
# impute missing fare based on class
titanic$fare[is.na(titanic$fare) & titanic$class == "1st"] = 89
titanic$fare[is.na(titanic$fare) & titanic$class == "2nd"] = 22
titanic$fare[is.na(titanic$fare) & titanic$class == "3rd"] = 13



#install.packages(c("rms", "randomForest", "e1071"))
library("rms")
# the rcs() function allows us to model potentially non-linear effect of age
titanic_lmr <- lrm(survived == "yes" ~ gender + rcs(age) + class +
                     sibsp + parch + fare + embarked, titanic)
library("randomForest")
set.seed(123)
titanic_rf <- randomForest(survived ~ class + gender + age + 
                             sibsp + parch + fare + embarked, data = titanic)
library("e1071")
titanic_svm <- svm(survived == "yes" ~ class + gender + age + 
                     sibsp + parch + fare + embarked, data = titanic, 
                   type = "C-classification", probability = TRUE)

johnny <- data.frame(
  class = factor("1st", levels = c("1st", "2nd", "3rd", "deck crew", 
                                   "engineering crew", "restaurant staff", "victualling crew")),
  gender = factor("male", levels = c("female", "male")),
  age = 8, sibsp = 0, parch = 0, fare = 72,
  embarked = factor("Southampton", levels = c("Belfast", "Cherbourg", 
                                              "Queenstown","Southampton")))

henry <- data.frame(
  class = factor("1st", levels = c("1st", "2nd", "3rd", "deck crew", 
                                   "engineering crew", "restaurant staff", "victualling crew")),
  gender = factor("male", levels = c("female", "male")),
  age = 47, sibsp = 0, parch = 0, fare = 25,
  embarked = factor("Cherbourg", levels = c("Belfast", "Cherbourg", 
                                            "Queenstown","Southampton")))
predict(titanic_lmr, henry, type = "fitted")

apartments_lm <- lm(m2.price ~ ., data = apartments)
library("randomForest")
set.seed(123)
apartments_rf <- randomForest(m2.price ~ ., data = apartments)
library("e1071")
apartments_svm <- svm(m2.price ~ construction.year + surface + floor + 
                        no.rooms + district, data = apartments)

titanic_lmr_exp <- explain(
  model = titanic_lmr, data = titanic[, -9],
  y = titanic$survived == "yes", label = "Logistic Regression",
  type = "classification")

titanic_rf_exp <- explain(
  model = titanic_rf, data = titanic[, -9],
  y = titanic$survived == "yes", label = "Random Forest")

titanic_svm_exp <- explain(
  model = titanic_svm, data = titanic[, -9],
  y = titanic$survived == "yes", label = "Support Vector Machine")

apartments_lm_exp <- explain(
  model = apartments_lm, data = apartments_test[, -1], 
  y = apartments_test$m2.price, label = "Linear Regression")

apartments_rf_exp <- explain(
  model = apartments_rf, data = apartments_test[, -1], 
  y = apartments_test$m2.price, label = "Random Forest")

apartments_svm_exp <- explain(
  model = apartments_svm, data = apartments_test[, -1], 
  y = apartments_test$m2.price, label = "Support Vector Machine")

new_apt = apartments_test[1, -1] 

titanic_svm_exp_bdi <- predict_parts(
  titanic_svm_exp, new_observation = johnny, 
  type = "break_down_interactions")
apartments_svm_exp_bdi <- predict_parts(
  apartments_svm_exp, new_observation = new_apt, 
  type = "break_down_interactions")


plot(titanic_svm_exp_bdi) + 
  ggtitle("Break-down plot for Johnny")


titanic_svm_exp_shap <- predict_parts(
  explainer = titanic_svm_exp, new_observation = johnny, 
  type = "shap", B = 25)
apartments_svm_exp_shap <- predict_parts(
  explainer = apartments_svm_exp, new_observation = new_apt, 
  type = "shap", B = 25)


titanic_svm_exp_shap


install.packages("lime")

library("DALEXtra") #Extension for 'DALEX' Package
model_type.dalex_explainer <- DALEXtra::model_type.dalex_explainer
predict_model.dalex_explainer <- DALEXtra::predict_model.dalex_explainer
# use predict_surrogate(), not predict_parts()
titanic_svm_exp_lime <- predict_surrogate(
  explainer = titanic_svm_exp, new_observation = johnny, 
  n_features = 3, n_permutations = 1000, type = "lime")

(as.data.frame(titanic_rf_exp_lime))
plot(titanic_svm_exp_lime)



# use model_parts(), not predict_parts()
titanic_rf_exp_vip <- model_parts(
  explainer = titanic_rf_exp, 
  loss_function = loss_root_mean_square,
  B = 50, type = "difference")

plot(titanic_rf_exp_vip) +
  ggtitle("Mean variable-importance over 50 permutations")


