#Random Forests
library(randomForest) 
library(tidyverse)

# read in the cleaned data
nyschool_train = read_csv("Stat-471-final-project/cleaned data/final data/nyschool_train.csv") 

set.seed(1)
rf_fit = randomForest(GRAD_RATE ~ . -ENTITY_CD -INSTITUTION_ID -ENTITY_NAME, data = nyschool_train)

#plot OOB error as a function of number of trees
plot(rf_fit)

#tuning the random forest
mvalues = seq(1,32, by = 2) #m range can be 1-32 
oob_errors = numeric(length(mvalues))
ntree = 200 #the OOB Error is stabilized at 200 trees
for(idx in 1:length(mvalues)){
  m = mvalues[idx]
  rf_fit = randomForest(GRAD_RATE ~ . -ENTITY_CD -INSTITUTION_ID -ENTITY_NAME, data = nyschool_train)
  oob_errors[idx] = rf_fit$mse[ntree]
}
m_oob_errors = tibble(m = mvalues, oob_err = oob_errors)
rf_tuning = m_oob_errors%>%
  ggplot(aes(x = m, y = oob_err)) + 
  geom_line() + geom_point() + 
  scale_x_continuous(breaks = mvalues) +
  labs(y = "OOB Error", x = "Value for m") +
  theme_bw() 

#saving the tuning for m
pdf("Stat-471-final-project/results/rf_tuning.png")
print(rf_tuning)
dev.off()

#m = 9 is the best mtry value, which is lower than default m = 10
best_m = m_oob_errors %>%
  arrange(oob_errors) %>% head(1) %>% pull(m)

set.seed(1)
rf_fit_tuned = randomForest(GRAD_RATE ~ .-ENTITY_CD -INSTITUTION_ID -ENTITY_NAME, mtry = best_m, ntree = 500,
                            importance = TRUE, data = nyschool_train)
plot(rf_fit_tuned) #double check to see if OOB has flattened out (it does!)

#save the randomforest model
save(rf_fit_tuned,file = "Stat-471-final-project/results/rf_fit_tuned.RData")

#HOW TO LOAD THE FOREST: rf_fit_tuned = get(load("Stat-471-final-project/results/rf_fit_tuned.RData"))

#idk how to save variable importance plot
rf_importance = varImpPlot(rf_fit_tuned, n.var = 10)
save(rf_importance,file = "Stat-471-final-project/results/rf_importance.png")


