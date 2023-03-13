#######################################
# Project: AV Parole
# File: server.R
# Authors: Mari Roberts
# Date last updated: March 13, 2023 (MAR)
# Description:
#    Server for shiny app
#######################################

server <- function(input, output, session) {

  output$title <- renderText({paste(month.abb[as.integer(input$month)], "Report")})
  df_month <- reactive({filter(ua_data, month == input$month)})
  metric_server("dep_delay", df_month, vbl = "dep_delay", threshhold = 10)
  metric_server("arr_delay", df_month, vbl = "arr_delay", threshhold = 10)
  metric_server("ind_arr_delay", df_month, vbl = "ind_arr_delay", threshhold = 0.5)

}
