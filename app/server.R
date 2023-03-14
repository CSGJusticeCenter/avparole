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

  # PAROLE ELIGIBILITY
  output$parole_eligibility_viz_title <- renderText({"Parole Eligibility in 2020"})

  df_parole_eligibility <- reactive({filter(parole_eligibility_table_2020, state == input$state)})
  parole_eligibility_server("parole_eligibility_reactable", df_parole_eligibility)

  # PAROLE ELIGIBILITY AND OFFENSE TYPE
  output$ped_offense_type_viz_title <- renderText({"Parole Eligibility and Offense Type"})

  df_ped_offense_type <- reactive({filter(current_ped_2020_offenses, state == input$state)})
  ped_offense_type_sentence_server("ped_offense_type_sentence", df_ped_offense_type)
  ped_offense_type_server("ped_offense_type_reactable", df_ped_offense_type)

  ped_offense_type_pie_server("ped_offense_type_pie", df_ped_offense_type)


}
