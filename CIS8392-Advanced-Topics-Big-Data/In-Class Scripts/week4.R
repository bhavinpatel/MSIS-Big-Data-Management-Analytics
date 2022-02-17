install.packages(c("skimr", "recipes"))
library(skimr)
library(recipes)
library(stringr)
library(tidyverse)

application_train <- read_csv("data/loan/application_train.csv",
                              na = c("", NA, "-1"))
application_test <- read_csv("data/loan/application_test.csv",
                             na = c("", NA, "-1"))

# Training data: Separate into x and y tibbles
x_train_tbl <- application_train %>% select(-TARGET)
y_train_tbl <- application_train %>% select(TARGET)   
# Testing data
x_test_tbl  <- application_test
# Remove the original data to save memory
rm(application_train)
rm(application_test)

#install.packages("skimr")
library(skimr)
x_train_tbl_skim = partition(skim(x_train_tbl))
names(x_train_tbl_skim)

string_2_factor_names <- x_train_tbl_skim$character$skim_variable
string_2_factor_names


unique_numeric_values_tbl <- x_train_tbl %>%
  select(x_train_tbl_skim$numeric$skim_variable) %>%
  map_df(~ unique(.) %>% length()) %>%
  gather() %>%
  arrange(value) %>%
  mutate(key = as_factor(key))
unique_numeric_values_tbl



library(h2o)
library(tidyverse)

y_train_processed_tbl <- read_rds("data/loan/y_train_processed_tbl.rds")
x_train_processed_tbl <- read_rds("data/loan/x_train_processed_tbl.rds")
x_test_processed_tbl <- read_rds("data/loan/x_test_processed_tbl.rds")





listname$attribute_name
seq(from=0, to=1e-4, by=1e-6)


