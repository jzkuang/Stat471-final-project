library(tidyverse)

#gave warnings, I'm guessing most of the warnings are because of columns that have no data
#accountability, gives overall status of school
accountability <- readxl::read_excel("Stat471-final-project/data/Accountability Status.xlsx")
accountability_filtered <- accountability %>% 
  filter(YEAR == "2019") %>%
  filter(is.na(OVERRIDE)) %>% #remove values where the status was overriden
  select(-MADE_PROGRESS_FLAG, -CHANGE_STATUS_FLAG, -OVERRIDE)
write.csv(accountability_filtered, "Stat471-final-project/cleaned data/Accountability.csv")

#BOCES is a program of shared educational services provided to school districts 
#Need index = Need-to-Resource Capacity Category
BOCES <- readxl::read_excel("Stat471-final-project/data/BOCES and N_RC.xlsx")
BOCES_filtered <- BOCES %>% 
  filter(YEAR == "2019")
write.csv(BOCES_filtered, "Stat471-final-project/cleaned data/BOCES.csv")


#amount of money spent on the school
expenditure <- readxl::read_excel("Stat471-final-project/data/Expenditures per Pupil.xlsx")
expenditure_filtered <- expenditure %>% 
  filter(YEAR == "2019")
write.csv(expenditure_filtered, "Stat471-final-project/cleaned data/Expenditure.csv")

#gave warnings
#removed the 2020 only statistics
inexperience <- readxl::read_excel("Stat471-final-project/data/Inexperienced Teachers and Principals.xlsx")
inexperience_filtered <- inexperience %>% 
  filter(YEAR == "2019") %>%
  select(-TEACH_DATA_REP_FLAG, -PRIN_DATA_REP_FLAG, -TOT_PRINC_LOW, -TOT_PRINC_HIGH, -TOT_TEACH_LOW, -TOT_TEACH_HIGH)
write.csv(inexperience_filtered, "Stat471-final-project/cleaned data/Inexperience.csv")

#gave warnings
#out of certification (teachers no certification)
OOC <- readxl::read_excel("Stat471-final-project/data/Teachers Teaching Out of Certification.xlsx")
OOC_filtered <- OOC %>% 
  filter(YEAR == "2019") %>%
  select(-TOT_OUT_CERT_LOW, -TOT_OUT_CERT_HIGH, -OUT_OF_CERT_DATA_REP_FLAG)
write.csv(OOC_filtered, "Stat471-final-project/cleaned data/Teachers Teaching Out of Certification.csv")

