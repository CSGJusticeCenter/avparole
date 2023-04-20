#######################################
# Project: AV Parole
# File: server.R
# Authors: Mari Roberts
# Date last updated: March 13, 2023 (MAR)
# Description:
#    Server for shiny app
#######################################

server <- function(input, output, session) {

  output$selected_state <- renderText({input$state})

  ######################
  # PAROLE ELIGIBILITY
  ######################

  output$parole_eligibility_title <- renderText({"Parole Eligibility Trends"})

  ######################
  # PAROLE BOARD
  ######################

  output$parole_board_title <- renderText({"Parole Board Decision-Making"})

  ######################
  # Disparities
  ######################

  output$parole_disparities_title <- renderText({"Racial, Ethnic, and Gender Disparities"})

}
