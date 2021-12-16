#Boosting model
library(gbm)       
library(tidyverse)

# read in the cleaned data
nyschool_train = read_csv("Stat-471-final-project/cleaned data/final data/nyschool_train.csv") 

nyschool_train = nyschool_train %>% 
  mutate(across(OVERALL_STATUS, as.factor)) %>%
  select(-ENTITY_CD, -ENTITY_NAME, -INSTITUTION_ID)

set.seed(1)
# fit random forest with different interaction depths
gbm_fit_1 = gbm(GRAD_RATE ~ .,
                distribution = "gaussian",
                n.trees = 1000,
                interaction.depth = 1,
                shrinkage = 0.1,
                cv.folds = 5,
                data = nyschool_train)
gbm_fit_2 = gbm(GRAD_RATE ~ .,
                distribution = "gaussian",
                n.trees = 1000,
                interaction.depth = 2,
                shrinkage = 0.1,
                cv.folds = 5,
                data = nyschool_train)
gbm_fit_3 = gbm(GRAD_RATE ~ .,
                distribution = "gaussian",
                n.trees = 1000,
                interaction.depth = 3,
                shrinkage = 0.1,
                cv.folds = 5,
                data = nyschool_train)

ntrees = 1000
cv_errors = bind_rows(
  tibble(ntree = 1:ntrees, cv_err = gbm_fit_1$cv.error, depth = 1),
  tibble(ntree = 1:ntrees, cv_err = gbm_fit_2$cv.error, depth = 2),
  tibble(ntree = 1:ntrees, cv_err = gbm_fit_3$cv.error, depth = 3)
)
# plot CV errors
cv_error_plot = cv_errors %>%
  ggplot(aes(x = ntree, y = cv_err, colour = factor(depth))) +
  # add horizontal dashed lines at the minima of the three curves
  geom_hline(yintercept = min(gbm_fit_1$cv.error),
             linetype = "dashed", color = "red") +
  geom_hline(yintercept = min(gbm_fit_2$cv.error),
             linetype = "dashed", color = "green") +
  geom_hline(yintercept = min(gbm_fit_3$cv.error),
             linetype = "dashed", color = "blue") +
  geom_line() +
  # set colors to match horizontal line minima
  scale_color_manual(labels = c("1", "2", "3"),
                     values = c("red", "green", "blue")) +
  labs(x = "Number of trees", y = "CV error", colour = "Interaction depth") +
  scale_y_log10() +
  theme_bw()

#save the CV error plot
png(width = 6, 
    height = 4,
    res = 300,
    units = "in", 
    filename = "Stat-471-final-project/results/boost_cv_error.png")
print(cv_error_plot)
dev.off()


#we see interaction depth 2 is the best, so extract its optimal ntrees
gbm_fit_tuned = gbm_fit_2
optimal_num_trees = gbm.perf(gbm_fit_2, plot.it = FALSE)
optimal_num_trees

#Save table of variable importance
boost_importance = summary(gbm_fit_tuned, n.trees = optimal_num_trees, plotit = FALSE) %>%
  head(10)
boost_importance %>% write_tsv("Stat-471-final-project/results/boost_importance.tsv")

#save tuned boosting model
save(gbm_fit_tuned,file = "Stat-471-final-project/results/gbm_fit_tuned.RData")

