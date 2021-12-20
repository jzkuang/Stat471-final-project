library(tidyverse)

## Reading and pulling the grad rate data
## This takes a long time so it's commented out
gradRate <- readxl::read_excel("stat-471-final-project/data/ACC HS Graduation Rate.xlsx")
gradRate_filtered <- gradRate %>%
  filter(SUBGROUP_NAME == "All Students") %>%
  filter(YEAR == "2019") %>%
  filter(COHORT == "Combined") %>%
  filter(COHORT == "Combined") %>%
  filter(!grepl("DISTRICT", ENTITY_NAME))
write.csv(gradRate_filtered, "stat-471-final-project/cleaned data/Graduation Rate.csv", row.names = FALSE)

# Data on each school's attendance rate
attendance <- readxl::read_excel("stat-471-final-project/data/Attendance.xlsx")
attendance_filtered <- attendance %>%
  filter(YEAR == "2019") %>% 
  select(-c(DATA_REPORTED))
write.csv(attendance_filtered, "stat-471-final-project/cleaned data/Attendance.csv", row.names = FALSE)

# Data on each school's percentage of free and reduced lunches
reduced_lunch <- readxl::read_excel("stat-471-final-project/data/Free Reduced Price Lunch.xlsx")
reduced_lunch_filtered <- reduced_lunch %>%
  filter(YEAR == "2019") %>% 
  filter(!grepl("DISTRICT", ENTITY_NAME)) %>% 
  filter(!grepl("County", ENTITY_NAME)) %>% 
  select(-c(NUM_FREE_LUNCH, NUM_REDUCED_LUNCH))
write.csv(reduced_lunch_filtered, "stat-471-final-project/cleaned data/Precent Reduced Lunch.csv", row.names = FALSE)

# Data on each school number of staff rates
staff <- readxl::read_excel("stat-471-final-project/data/Staff.xlsx")
staff_filtered <- staff %>%
  filter(YEAR == "2019") %>% 
  filter(!grepl("DISTRICT", SCHOOL_NAME)) %>% 
  select(c(ENTITY_CD, SCHOOL_NAME, NUM_PRINC, NUM_TEACH, NUM_COUNSELORS, NUM_SOCIAL))
write.csv(staff_filtered, "stat-471-final-project/cleaned data/Staff.csv", row.names = FALSE)

# Data on each school number of suspensions
suspensions <- readxl::read_excel("stat-471-final-project/data/Suspensions.xlsx")
suspensions_filtered <- suspensions %>%
  filter(YEAR == "2019") %>% 
  filter(!grepl("DISTRICT", ENTITY_NAME)) %>% 
  select(c(ENTITY_CD, ENTITY_NAME, PER_SUSPENSIONS))
write.csv(suspensions_filtered, "stat-471-final-project/cleaned data/Suspensions.csv", row.names = FALSE)

# Data on the demographic composition of schools
demographics <- readxl::read_excel("stat-471-final-project/data/Demographic Factors.xlsx")
demographics_filtered <- demographics %>%
  filter(YEAR == "2019") %>% 
  filter(!grepl("DISTRICT", ENTITY_NAME)) %>% 
  filter(!grepl("County", ENTITY_NAME)) %>% 
  select(c(ENTITY_CD, ENTITY_NAME, starts_with("PER")))
write.csv(demographics_filtered, "stat-471-final-project/cleaned data/Demographics.csv", row.names = FALSE)

## Alex's work

#gave warnings, I'm guessing most of the warnings are because of columns that have no data
#accountability, gives overall status of school
accountability <- readxl::read_excel("Stat-471-final-project/data/Accountability Status.xlsx")
accountability_filtered <- accountability %>% 
  filter(YEAR == "2019") %>%
  filter(is.na(OVERRIDE)) %>% #remove values where overall status was overriden 
  select(ENTITY_CD, OVERALL_STATUS)
write.csv(accountability_filtered, "Stat-471-final-project/cleaned data/Accountability.csv", row.names = FALSE)

#BOCES is a program of shared educational services provided to school districts. Should we keep this???
#Need index = Need-to-Resource Capacity Category. The need/resource capacity index, a measure of a district's ability to meet the needs of its students with local
# resources, is the ratio of the estimated poverty percentage1 (expressed in standard score form) to the Combined
# Wealth Ratio2 (expressed in standard score form).
BOCES <- readxl::read_excel("Stat-471-final-project/data/BOCES and N_RC.xlsx")
BOCES_filtered <- BOCES %>% 
  filter(YEAR == "2019") %>%
  select(ENTITY_CD, BOCES_CD, NEEDS_INDEX)
write.csv(BOCES_filtered, "Stat-471-final-project/cleaned data/BOCES.csv", row.names = FALSE)

#amount of money spent on the school
expenditure <- readxl::read_excel("Stat471-final-project/data/Expenditures per Pupil.xlsx")
expenditure_filtered <- expenditure %>% 
  filter(YEAR == "2019") %>%
  select(ENTITY_CD, PUPIL_COUNT_TOT, PER_FEDERAL_EXP, PER_STATE_LOCAL_EXP)
write.csv(expenditure_filtered, "Stat-471-final-project/cleaned data/Expenditure.csv", row.names = FALSE)

#gave warnings
#removed the 2020 only statistics
inexperience <- readxl::read_excel("Stat471-final-project/data/Inexperienced Teachers and Principals.xlsx")
inexperience_filtered <- inexperience %>% 
  filter(YEAR == "2019") %>% 
  select(ENTITY_CD, NUM_TEACH, PER_TEACH_INEXP, NUM_PRINC, PER_PRINC_INEXP) #UNSURE IF SHOULD USE TOTAL NUM OF TEACH AND PRINC
write.csv(inexperience_filtered, "Stat-471-final-project/cleaned data/Inexperience.csv", row.names = FALSE)

#gave warnings
#out of certification (teachers no certification)
OOC <- readxl::read_excel("Stat-471-final-project/data/Teachers Teaching Out of Certification.xlsx")
OOC_filtered <- OOC %>% 
  filter(YEAR == "2019") %>%
  select(ENTITY_CD, PER_OUT_CERT)
write.csv(OOC_filtered, "Stat-471-final-project/cleaned data/Teachers Teaching Out of Certification.csv", row.names = FALSE)

