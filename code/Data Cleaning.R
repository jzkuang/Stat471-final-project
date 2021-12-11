library(tidyverse)

gradRate <- readxl::read_excel("stat-471-final-project/data/ACC HS Graduation Rate.xlsx")

gradRate_filtered <- gradRate %>% 
  filter(SUBGROUP_NAME == "All Students") %>% 
  filter(YEAR == "2019") %>% 
  filter(COHORT == "Combined") %>% 
  filter(COHORT == "Combined") %>% 
  filter(!grepl("DISTRICT", ENTITY_NAME))
#write.csv(gradRate_filtered, "Final Project/cleaned data/ACC HS Graduation Rate.xlsx")


