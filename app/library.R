#######################################
# Project: AV Parole
# File: library.R
# Authors: Mari Roberts
# Date last updated: March 13, 2023 (MAR)
# Description:
#    Load packages and custom functions
#######################################

# Highcharter download instructions:
# remove the existing highcharter package from your R session: remove.packages("highcharter")
# restart your R session
# install highcharter with the devtools package (NOT the remotes package):
# install.packages("devtools")
# devtools::install_github("mrjoh3/highcharter")

# load packages
library(shiny)
library(shinyWidgets)
library(dashboardthemes)
library(shinydashboard)
library(dplyr)
library(ggplot2)
library(scales)
library(sysfonts)
library(highcharter)
library(reactable)
library(reactablefmtr)

###################
# Fonts
###################

# Load fonts
font_add("Graphik",     regular = "www/fonts/Graphik.ttf")
font_add("GraphikBold", regular = "www/fonts/GraphikBold.ttf")
