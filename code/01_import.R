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
load(paste0(sp_data_path, "/ICPSR_38492-V1/ICPSR_38492/DS0001/38492-0001-Data.rda"))
load(paste0(sp_data_path, "/ICPSR_38492-V1/ICPSR_38492/DS0002/38492-0002-Data.rda"))
load(paste0(sp_data_path, "/ICPSR_38492-V1/ICPSR_38492/DS0003/38492-0003-Data.rda"))
load(paste0(sp_data_path, "/ICPSR_38492-V1/ICPSR_38492/DS0004/38492-0004-Data.rda"))

# rename df names and clean variable names
admissions <- da38492.0002 %>% clean_names()
population <- da38492.0003 %>% clean_names()
yearendpop <- da38492.0004 %>% clean_names()
