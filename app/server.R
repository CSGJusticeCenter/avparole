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

  df_parole_eligibility <- reactive({filter(parole_eligibility_table_2020, state == input$state)})
  parole_eligibility_server("parole_eligibility_reactable", df_parole_eligibility)


}
