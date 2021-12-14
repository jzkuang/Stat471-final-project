#train-test-split
library(tidyverse)

# read in the cleaned data
nyschool_data = read_csv("Stat471-final-project/cleaned data/merged data.csv")

nyschool_data = nyschool_data %>%
  filter(GRAD_RATE != "s") %>%
  filter(ENTITY_CD != "111111111111")

# split into train and test
set.seed(5) 
n = nrow(nyschool_data)
train_samples = sample(1:n, round(0.8*n))

nyschool_train = nyschool_data[train_samples,]
nyschool_test = nyschool_data[-train_samples,]

# save the train and test data
write_csv(nyschool_train, file = "Stat471-final-project/cleaned data/final data/nyschool_train.csv")
write_csv(nyschool_test, file = "Stat471-final-project/cleaned data/final data/nyschool_test.csv")
