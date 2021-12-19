#Model evaluations

library(glmnetUtils)
library(tidyverse)
library(randomForest) 
library(gbm) 

#load test data
nyschool_train = read_csv("Stat-471-final-project/cleaned data/final data/nyschool_train.csv") %>% 
  select(-c(ENTITY_CD, INSTITUTION_ID, ENTITY_NAME)) %>% 
  mutate(OVERALL_STATUS = as.factor(OVERALL_STATUS),
         NEEDS_INDEX = as.factor(NEEDS_INDEX))
nyschool_test = read_csv("Stat-471-final-project/cleaned data/final data/nyschool_test.csv")

#load models
load("Stat-471-final-project/results/ridge_fit.RData")
load("Stat-471-final-project/results/rf_fit_tuned.RData")
load("Stat-471-final-project/results/gbm_fit_tuned.RData")

#evaluate the lienar regression
nyschool_test_lr = read_csv("Stat-471-final-project/cleaned data/final data/nyschool_test.csv") %>% 
  select(-c(ENTITY_CD, INSTITUTION_ID, ENTITY_NAME)) %>% 
  mutate(OVERALL_STATUS = as.factor(OVERALL_STATUS),
         NEEDS_INDEX = as.factor(NEEDS_INDEX))
# this is a list of levels for each factor in the original df
xlevs <- lapply(nyschool_train[,sapply(nyschool_train, is.factor), drop = F], function(j){
  levels(j)
})
dummified_test <- as.data.frame(model.matrix( ~ .-1, nyschool_test_lr, xlev = xlevs))
ridge_predictions <-  predict(ridge_fit,
                              newdata = dummified_test,
                              s = "lambda.1se") %>% as.numeric()
lr_rmse = sqrt(mean((ridge_predictions - nyschool_test$GRAD_RATE)^2))
#evaluate random forest model
rf_predictions = predict(rf_fit_tuned, newdata = nyschool_test)%>%
  as.numeric()
rf_rmse = sqrt(mean((rf_predictions - nyschool_test$GRAD_RATE)^2))

#evaluate boosting model
optimal_num_trees = gbm.perf(gbm_fit_tuned, plot.it = FALSE)
gbm_predictions = predict(gbm_fit_tuned, n.trees = optimal_num_trees,
                          newdata = nyschool_test)%>%
  as.numeric()
gbm_rmse = sqrt(mean((gbm_predictions - nyschool_test$GRAD_RATE)^2))


rmse_table = tribble(
  ~Error, ~'Linear Regression', ~'Random Forest', ~"Boosting",
  "Root Mean Squared Error", lr_rmse, rf_rmse, gbm_rmse,
)
write_tsv(rmse_table, "Stat-471-final-project/results/rmse_table.tsv")

