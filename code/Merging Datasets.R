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
accountability <- read_csv("stat-471-final-project/cleaned data/Accountability.csv") %>% 
  select(-c(MADE_PROGRESS))
boces <- read_csv("stat-471-final-project/cleaned data/BOCES.csv") %>% 
  select(-c(BOCES_CD))
expenditure <- read_csv("stat-471-final-project/cleaned data/Expenditure.csv")
inexperience <- read_csv("stat-471-final-project/cleaned data/Inexperience.csv") %>% 
  select(-c(NUM_TEACH, NUM_PRINC))
certification <- read_csv("stat-471-final-project/cleaned data/Teachers Teaching Out of Certification.csv")

final_table <- merge(gradRate, attendance, by = "ENTITY_CD", all.y = FALSE)
final_table <- merge(final_table, reduced_lunch, by = "ENTITY_CD", all.y = FALSE)
final_table <- merge(final_table, staff, by = "ENTITY_CD", all.y = FALSE)
final_table <- merge(final_table, suspensions, by = "ENTITY_CD", all.y = FALSE)
final_table <- merge(final_table, demographics, by = "ENTITY_CD", all.y = FALSE)
final_table <- merge(final_table, inexperience, by = "ENTITY_CD", all.y = FALSE)
final_table <- merge(final_table, certification, by = "ENTITY_CD", all.y = FALSE)
# These tables are missing data
final_table <- merge(final_table, accountability, by = "ENTITY_CD", all.x = TRUE, all.y = FALSE) 
final_table <- merge(final_table, boces, by = "ENTITY_CD", all.x = TRUE, all.y = FALSE)
final_table <- merge(final_table, expenditure, by = "ENTITY_CD", all.x = TRUE, all.y = FALSE)

#final tidying, such as replacing NA values
final_table = final_table %>%
  filter(GRAD_RATE != "s") %>%
  filter(ENTITY_CD != "111111111111") %>%
  mutate(OVERALL_STATUS = replace(OVERALL_STATUS,
                                  is.na(OVERALL_STATUS),
                                  "MISSING")) %>%
  mutate(NEEDS_INDEX = replace(NEEDS_INDEX,
                                  is.na(NEEDS_INDEX),
                                  "MISSING")) %>%
  mutate(PUPIL_COUNT_TOT = replace(PUPIL_COUNT_TOT,
                                  is.na(PUPIL_COUNT_TOT),
                                  mean(PUPIL_COUNT_TOT, na.rm = TRUE))) %>%
  mutate(PER_FEDERAL_EXP = replace(PER_FEDERAL_EXP,
                                   is.na(PER_FEDERAL_EXP),
                                   mean(PER_FEDERAL_EXP, na.rm = TRUE)))%>%
  mutate(PER_STATE_LOCAL_EXP = replace(PER_STATE_LOCAL_EXP,
                                   is.na(PER_STATE_LOCAL_EXP),
                                   mean(PER_STATE_LOCAL_EXP, na.rm = TRUE)))

write.csv(final_table, "stat-471-final-project/cleaned data/final data/Merged Data.csv", row.names = FALSE)

