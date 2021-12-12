library(tidyverse)

gradRate <- read_csv("stat-471-final-project/cleaned data/Graduation Rate.csv") %>% 
  select(c(INSTITUTION_ID, ENTITY_CD, ENTITY_NAME, GRAD_RATE))
attendance <- read_csv("stat-471-final-project/cleaned data/Attendance.csv") %>% 
  select(c(ENTITY_CD, ATTENDANCE_RATE))
reduced_lunch <- read_csv("stat-471-final-project/cleaned data/Precent Reduced Lunch.csv") %>% 
  select(c(ENTITY_CD, PER_FREE_LUNCH, PER_REDUCED_LUNCH))
staff <- read_csv("stat-471-final-project/cleaned data/Staff.csv") %>% 
  select(-c(SCHOOL_NAME))
suspensions <- read_csv("stat-471-final-project/cleaned data/Suspensions.csv") %>% 
  select(c(ENTITY_CD, PER_SUSPENSIONS))
demographics <- read_csv("stat-471-final-project/cleaned data/Demographics.csv") %>% 
  select(-c(ENTITY_NAME))
