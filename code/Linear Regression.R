library(glmnetUtils)
library(tidyverse)

source("Stat-471-final-project/code/functions/plot_glmnet.R")

# read in the cleaned data
nyschool_train = read_csv("Stat-471-final-project/cleaned data/final data/nyschool_train.csv") %>% 
  select(-c(ENTITY_CD, INSTITUTION_ID, ENTITY_NAME)) %>% 
  mutate(OVERALL_STATUS = as.factor(OVERALL_STATUS),
         NEEDS_INDEX = as.factor(NEEDS_INDEX))
dummified_train <- as.data.frame(model.matrix( ~ .-1, nyschool_train))

#### The Regression ####
set.seed(1)
ridge_fit = cv.glmnet(GRAD_RATE ~ ., # formula notation, as usual
                      alpha = 0, # alpha = 0 for ridge
                      nfolds = 10, # number of folds
                      data = dummified_train) # data to run ridge on
save(ridge_fit, file = "Stat-471-final-project/results/ridge_fit.RData")

#### Plots ####
#saving the tuning for m
png(width = 6, 
    height = 4,
    res = 300,
    units = "in", 
    filename = "Stat-471-final-project/results/lr_tuning.png")
print(plot(ridge_fit))
dev.off()

png(width = 9, 
    height = 7,
    res = 300,
    units = "in", 
    filename = "Stat-471-final-project/results/lr_features.png")
print(plot_glmnet(ridge_fit, dummified_train, features_to_plot = 10))
dev.off()

# # Largest Coef
# # Warning!! These aren't standardized.
# plot_glmnet(ridge_fit, dummified_train, features_to_plot = 7)
# tibble(coef = abs(as.vector(coef(ridge_fit, s = "lambda.min"))),
#        rownames = as.vector(rownames(coef(ridge_fit, s = "lambda.min")))) %>% 
#   arrange(desc(coef))

#### Check the MSE for Training ####
nyschool_test = read_csv("Stat-471-final-project/cleaned data/final data/nyschool_test.csv") %>% 
  select(-c(ENTITY_CD, INSTITUTION_ID, ENTITY_NAME)) %>% 
  mutate(OVERALL_STATUS = as.factor(OVERALL_STATUS),
         NEEDS_INDEX = as.factor(NEEDS_INDEX))
# this is a list of levels for each factor in the original df
xlevs <- lapply(nyschool_train[,sapply(nyschool_train, is.factor), drop = F], function(j){
  levels(j)
})
dummified_test <- as.data.frame(model.matrix( ~ .-1, nyschool_test, xlev = xlevs))
ridge_predictions <-  predict(ridge_fit,
                            newdata = dummified_test,
                            s = "lambda.1se") %>% as.numeric()
RMSE = sqrt(mean((ridge_predictions - nyschool_test$GRAD_RATE)^2))
