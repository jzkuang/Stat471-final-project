library(tidyverse)
library(GGally)
library(corrplot)

training <- read_csv("Stat-471-final-project/cleaned data/final data/nyschool_train.csv") %>% 
  select(-c(ENTITY_CD, ENTITY_NAME, INSTITUTION_ID))

mean(training$GRAD_RATE)
# Avg 85.6%
sd(training$GRAD_RATE)
# SD 15.58

dist_grad <- ggplot(training) +
  geom_histogram(aes(x = GRAD_RATE)) +
  theme_bw() +
  labs(x = "Graduation Rate", y = "Count")
png(width = 6, 
    height = 4,
    res = 300,
    units = "in", 
    filename = "Stat-471-final-project/results/eda_grad_hist.png")
print(dist_grad)
dev.off()
# The data has a left skew with most schools clustered around the mean

# Get the sd for every feature
training %>% 
  select(-GRAD_RATE) %>% 
  summarise_if(is.numeric, sd) %>% 
  pivot_longer(everything(), names_to = "Variable", values_to = "SD") %>% 
  arrange(desc(SD))

training %>% 
  select_if(is.numeric) %>% 
  ggcorr(method = c("everything", "pearson"), layout.exp = 15, geom = "tile", max_size = 2)

# Get What Correlates the Most
training %>% 
  select_if(is.numeric) %>% 
  cor() %>% 
  as.data.frame() %>% 
  select(GRAD_RATE) %>% 
  arrange(desc(abs(GRAD_RATE))) %>% 
  slice(-1)

# Top 10 Lowest Graduation Rate
training %>% 
  arrange(GRAD_RATE) %>% 
  slice(1:10)
