library(tidyverse)

## Reading and pulling the grad rate data
## This takes a long time so it's commented out
# gradRate <- readxl::read_excel("stat-471-final-project/data/ACC HS Graduation Rate.xlsx")
# gradRate_filtered <- gradRate %>% 
#   filter(SUBGROUP_NAME == "All Students") %>% 
#   filter(YEAR == "2019") %>% 
#   filter(COHORT == "Combined") %>% 
#   filter(COHORT == "Combined") %>% 
#   filter(!grepl("DISTRICT", ENTITY_NAME))
#write.csv(gradRate_filtered, "Final Project/cleaned data/ACC HS Graduation Rate.csv")

# Data on each school's attendance rate
attendance <- readxl::read_excel("stat-471-final-project/data/Attendance.xlsx")
attendance_filtered <- attendance %>%
  filter(YEAR == "2019") %>% 
  select(-c(DATA_REPORTED))
write.csv(attendance_filtered, "stat-471-final-project/cleaned data/Attendance.csv")

# Data on each school's percentage of free and reduced lunches
reduced_lunch <- readxl::read_excel("stat-471-final-project/data/Free Reduced Price Lunch.xlsx")
reduced_lunch_filtered <- reduced_lunch %>%
  filter(YEAR == "2019") %>% 
  filter(!grepl("DISTRICT", ENTITY_NAME)) %>% 
  filter(!grepl("County", ENTITY_NAME)) %>% 
  select(-c(NUM_FREE_LUNCH, NUM_REDUCED_LUNCH))
write.csv(reduced_lunch_filtered, "stat-471-final-project/cleaned data/Precent Reduced Lunch.csv")

# Data on each school number of staff rates
staff <- readxl::read_excel("stat-471-final-project/data/Staff.xlsx")
staff_filtered <- staff %>%
  filter(YEAR == "2019") %>% 
  filter(!grepl("DISTRICT", SCHOOL_NAME)) %>% 
  select(c(ENTITY_CD, SCHOOL_NAME, NUM_PRINC, NUM_TEACH, NUM_COUNSELORS, NUM_SOCIAL))
write.csv(staff_filtered, "stat-471-final-project/cleaned data/Staff.csv")

# Data on each school number of suspensions
suspensions <- readxl::read_excel("stat-471-final-project/data/Suspensions.xlsx")
suspensions_filtered <- suspensions %>%
  filter(YEAR == "2019") %>% 
  filter(!grepl("DISTRICT", ENTITY_NAME)) %>% 
  select(c(ENTITY_CD, ENTITY_NAME, PER_SUSPENSIONS))
write.csv(suspensions_filtered, "stat-471-final-project/cleaned data/Suspensions.csv")

# Data on the demographic composition of schools
# Data on each school number of suspensions
demographics <- readxl::read_excel("stat-471-final-project/data/Demographic Factors.xlsx")
demographics_filtered <- demographics %>%
  filter(YEAR == "2019") %>% 
  filter(!grepl("DISTRICT", ENTITY_NAME)) %>% 
  filter(!grepl("County", ENTITY_NAME)) %>% 
  select(c(ENTITY_CD, ENTITY_NAME, starts_with("PER")))
write.csv(demographics_filtered, "stat-471-final-project/cleaned data/Demographics.csv")
