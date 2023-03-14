#######################################
# Project: AV Parole
# File: library.R
# Authors: Mari Roberts
# Date last updated: March 13, 2023 (MAR)
# Description:
#    Load packages and custom functions
#######################################

##########
# Packages
##########

# download CSGJCR package
# devtools::install_github("CSGJusticeCenter/csgjcr@DEVELOP")
library(csgjcr)

# load other packages
library(dplyr)
library(ggplot2)
library(janitor)
library(highcharter)
library(tidyverse)
library(reactable)
library(sysfonts)
library(extrafont)
library(showtext)

# CHANGE THIS TO YOUR PROJECT PATH
# csg_set_project_path(project = "AVParole", sp_folder = "C:/Users/mroberts/The Council of State Governments/JC Research - RES_Parole", force = TRUE)

# Save data path
sp_data_path <- csg_get_project_path("AVParole")

# Load fonts
font_add("Graphik",     regular = "app/www/fonts/Graphik.ttf")
font_add("GraphikBold", regular = "app/www/fonts/GraphikBold.ttf")
extrafont::loadfonts(quiet = TRUE)
loadfonts(device="win")
showtext_auto()

##########
# Custom functions
##########

# custom function to create parole eligibility status
fnc_create_parelig_status <- function(df){

  lev_parelig_status <- c(
    "Current"
    , "Future"
    , "Missing")

  df %>%
    mutate(
      parelig_status = case_when(
          parelig_year <  rptyear ~ lev_parelig_status[1] # if year of parole eligibility is less than year reported to NCRP, then "currently eligible for parole"
        , parelig_year >= rptyear ~ lev_parelig_status[2] # if year of parole eligibility is more than or equal to year reported to NCRP, then "eligible for parole in the future"
        , is.na(parelig_year)     ~ lev_parelig_status[3] # if year of parole eligibility NA, then "missing data on parole eligibility"
      )
      , parelig_status = factor(parelig_status, levels = lev_parelig_status)
    )
}
