#######################################
# Project: AV Parole
# File: library.R
# Authors: Mari Roberts
# Date last updated: March 13, 2023 (MAR)
# Description:
#    Load packages and custom functions
#######################################

# load packages
library(shiny)
library(shinyWidgets)
library(dashboardthemes)
library(shinydashboard)
library(extrafont)
library(showtext)
library(dplyr)
library(ggplot2)

###################
# Fonts
###################

# Check the fonts path of your system
font_paths() # "C:\\Windows\\Fonts"

# Add a custom font. You will need to run this code every time you restart R
# Make sure you download the Franklin Gothic Book font to your computer
font_add(family  = "Franklin Gothic Book",
         regular = "FRABK.ttf",
         italic  = "FRABKIT.ttf",
         bold    = "FRADM.ttf")
showtext_auto()
default_fonts <- c("Franklin Gothic Book")
