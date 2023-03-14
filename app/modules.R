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
    column(1),
    column(10, reactableOutput(NS(id, "table"))),
    column(1),
  )

}

table_server <- function(id, df) {

  moduleServer(id, function(input, output, session) {

    table <- reactive({viz_reactable(df())})
    output$table <- renderReactable({table()})

  })
}

viz_reactable <- function(df) {
  df1 <- df %>% select(-state)
  reactable(df1,
            style = list(fontFamily = "Graphik, sans-serif",
                         fontSize = "1.5rem"
            ),
            theme = reactableTheme(cellStyle = list(display = "flex", flexDirection = "column", justifyContent = "center")),
            defaultColDef = colDef(format = colFormat(separators = TRUE), align = "center"),
            compact = TRUE,
            fullWidth = FALSE,
            columns = list(
              yearendpop    = colDef(name = "Year End Population (2020)",
                                     minWidth = 95,
                                     style = list(position = "sticky", borderRight = "1px solid #d3d3d3")),
              current_count = colDef(name = "Currently Eligible for Parole (N)",
                                     minWidth = 95),
              current_perc  = colDef(name = "Currently Eligible for Parole (%)",
                                     minWidth = 95,
                                     format = colFormat(percent = TRUE, digits = 1),
                                     style = list(position = "sticky", borderRight = "1px solid #d3d3d3")),
              future_count  = colDef(name = "Eligible for Parole in the Future (N)",
                                     minWidth = 95),
              future_perc   = colDef(name = "Eligible for Parole in the Future (%)",
                                     minWidth = 95,
                                     format = colFormat(percent = TRUE, digits = 1))
            ))
}


