#train-test-split
library(tidyverse)

# read in the cleaned data
nyschool_data = read_csv("Stat-471-final-project/cleaned data/final data/merged data.csv")

# split into train and test
set.seed(5) 
n = nrow(nyschool_data)
train_samples = sample(1:n, round(0.8*n))

nyschool_train = nyschool_data[train_samples,]
nyschool_test = nyschool_data[-train_samples,]

# save the train and test data
write_csv(nyschool_train, file = "Stat-471-final-project/cleaned data/final data/nyschool_train.csv")
write_csv(nyschool_test, file = "Stat-471-final-project/cleaned data/final data/nyschool_test.csv")

write_csv(nyschool_test, file = "Stat-471-final-project/cleaned data/final data/nyschool_train.csv")
