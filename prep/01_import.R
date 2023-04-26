#######################################
# Project: AV Parole
# File: import.R
# Authors: Mari Roberts
# Date last updated: March 13, 2023 (MAR)
# Description:
#    Import NCRP data (admissions, population, year end population)
#######################################

# load NCRP data
# https://www.icpsr.umich.edu/web/NACJD/studies/38492
load(paste0(sp_data_path, "/data/raw/ICPSR_38492-V1/ICPSR_38492/DS0001/38492-0001-Data.rda"))
load(paste0(sp_data_path, "/data/raw/ICPSR_38492-V1/ICPSR_38492/DS0002/38492-0002-Data.rda"))
load(paste0(sp_data_path, "/data/raw/ICPSR_38492-V1/ICPSR_38492/DS0003/38492-0003-Data.rda"))
load(paste0(sp_data_path, "/data/raw/ICPSR_38492-V1/ICPSR_38492/DS0004/38492-0004-Data.rda"))

# Load "Prisoners in 2020 - Statistical Tables"
prison_pop_by_race_state <- read.csv(paste0(sp_data_path, "/data/raw/p20st/p20stat02.csv"), skip = 10)

# rename df names and clean variable names
term_records <- da38492.0001 %>% clean_names()

admissions   <- da38492.0002 %>% clean_names()

population   <- da38492.0003 %>% clean_names()

yearendpop   <- da38492.0004 %>% clean_names() %>%
  mutate(
    state = str_sub(state, 6, -1),
    offgeneral = str_sub(offgeneral, 5, -1),
    race = str_sub(race, 5, -1)
  )

# clean up file to create dataframe of state prison pop by race
prison_pop_by_race_state <- prison_pop_by_race_state %>%
  clean_names() %>%
  filter(jurisdiction == "") %>%
  select(-c(jurisdiction)) %>%
  rename(state = x) %>%
  mutate_all(~str_replace_all(.,",",""))
