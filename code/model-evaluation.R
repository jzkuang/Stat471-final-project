#Model evaluations

library(glmnetUtils)
library(tidyverse)
library(randomForest) 
library(gbm) 

#load test data
nyschool_test = read_csv("Stat-471-final-project/cleaned data/final data/nyschool_test.csv")

#load models
load("Stat-471-final-project/results/rf_fit_tuned.RData")
load("Stat-471-final-project/results/gbm_fit_tuned.RData")

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
  "Root Mean Squared Error", "lr_rmse", rf_rmse, gbm_rmse,
)
write_tsv(rmse_table, "Stat-471-final-project/results/rmse_table.tsv")

