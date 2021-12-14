#Random Forests
library(randomForest) 
library(tidyverse)

# read in the cleaned data
nyschool_train = read_csv("Stat471-final-project/cleaned data/final data/nyschool_train.csv") 

nyschool_train = nyschool_train %>%
  filter(GRAD_RATE != "s")

rf_fit = randomForest(GRAD_RATE~., data = nyschool_train)
rf_fit = randomForest(grad_rate ~ ., data = nyschool_train)
