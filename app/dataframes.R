#######################################
# Project: MCLCShiny
# File: dataframes.R
# Authors: Mari Roberts
# Date last updated: March 13, 2023 (MAR)
# Description:
#    Load data files created in other R files needed for app
#######################################







load(file = "data/parole_eligibility_table_2020.Rda")
load(file = "data/parole_eligibility_table_2020_reactable.Rda")


parole_eligibility_ui <- function(id) {

  fluidRow(
    table_ui(NS(id, "metric"))
  )

}

parole_eligibility_server <- function(id, df) {

  moduleServer(id, function(input, output, session) {

    table_server("metric", df)

  })

}

table_ui <- function(id) {

  fluidRow(
    column(12, reactableOutput(NS(id, "table")))
  )

}

table_server <- function(id, df) {

  moduleServer(id, function(input, output, session) {

    table <- reactive({viz_reactable(df())})
    output$table <- renderReactable({table()})

  })
}

viz_reactable <- function(df) {
  reactable(df)
}


