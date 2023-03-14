#######################################
# Project: AV Parole
# File: ui.R
# Authors: Mari Roberts
# Date last updated: March 13, 2023 (MAR)
# Description:
#    User interface for shiny app
#######################################

source("library.R")
source("colors.R")
source("dataframes.R")

ui <- fluidPage(

  titlePanel("AV Parole Project"),

  sidebarLayout(
    sidebarPanel = sidebarPanel(
      selectInput("state", "State",
                  choices = unique(parole_eligibility_table_2020$state),
                  selected = "California"
      )
    ),
    mainPanel = mainPanel(
      h2(textOutput("state_title")),
      h3("Eligible for Parole"),
      parole_eligibility_ui("parole_eligibility_reactable")
    )
  )
)
