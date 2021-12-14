library(tidyverse)

#gave warnings, I'm guessing most of the warnings are because of columns that have no data
#accountability, gives overall status of school
accountability <- readxl::read_excel("Stat-471-final-project/data/Accountability Status.xlsx")
accountability_filtered <- accountability %>% 
  filter(YEAR == "2019") %>%
  filter(is.na(OVERRIDE)) %>% #remove values where overall status was overriden
  select(ENTITY_CD, OVERALL_STATUS, MADE_PROGRESS)
write.csv(accountability_filtered, "Stat-471-final-project/cleaned data/Accountability.csv", row.names = FALSE)


#BOCES is a program of shared educational services provided to school districts. Should we keep this???
#Need index = Need-to-Resource Capacity Category. The need/resource capacity index, a measure of a district's ability to meet the needs of its students with local
# resources, is the ratio of the estimated poverty percentage1 (expressed in standard score form) to the Combined
# Wealth Ratio2 (expressed in standard score form).
BOCES <- readxl::read_excel("Stat471-final-project/data/BOCES and N_RC.xlsx")
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


#Questions:
#Should I keep total number of teachers? 
#Do we have data on the pupil-teacher ratios for these schools? 
#We could probably count that using total pupil and total teacher counts. Can also do this for principal to pupil
