#Random Forests
library(randomForest) 
library(tidyverse)

# read in the cleaned data
nyschool_train = read_csv("Stat-471-final-project/cleaned data/final data/nyschool_train.csv") 

rf_fit = randomForest(GRAD_RATE ~ . -INSTITUTION_ID -ENTITY_NAME, data = nyschool_train)
