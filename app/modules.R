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
load(file = "data/current_ped_2020_offenses.Rda")




########################################################################################################################

# Parole Eligibility

########################################################################################################################

parole_eligibility_ui <- function(id) {
  fluidRow(table_ui(NS(id, "metric")))
}

parole_eligibility_server <- function(id, df) {
  moduleServer(id, function(input, output, session) {
    table_server("metric", df)})
}







ped_offense_type_sentence_ui <- function(id) {
  fluidRow(sentence_ui(NS(id, "metric")))
}

ped_offense_type_sentence_server <- function(id, df) {
  moduleServer(id, function(input, output, session) {
    sentence_server("metric", df)})
}

ped_offense_type_ui <- function(id) {
  fluidRow(table_ui(NS(id, "metric")))
}

ped_offense_type_server <- function(id, df) {
  moduleServer(id, function(input, output, session) {
    table_server_ped_offense_type("metric", df)})
}

ped_offense_type_pie_ui <- function(id) {
  fluidRow(plot_ui(NS(id, "metric")))
}

ped_offense_type_pie_server <- function(id, df) {
  moduleServer(id, function(input, output, session) {
    plot_server("metric", df)})
}





############################################################################################################

# TEXT

############################################################################################################

sentence_ui <- function(id) {

  fluidRow(
    column(1),
    column(10,  div(id = "viz-sentence", textOutput(NS(id, "text")))),
    column(1),
  )

}

sentence_server <- function(id, df) {

  moduleServer(id, function(input, output, session) {

    text <- reactive({formulate_sentence(df())})
    output$text <- renderText({text()})

  })
}

formulate_sentence <- function(df) {
  df1 <- df %>% select(-state, -yearendpop_ped) %>%
    slice_max(prop)
  most_common_offense_type <- df1$offgeneral
  number_of_people <- sum(df1$n)
  sentence <- paste0("Of the ", scales::comma(number_of_people), " people eligible for release before 2020 but not yet released, the most serious offense type was ", tolower(most_common_offense_type), ".", sep = "")
  return(sentence)
}





############################################################################################################

# TABLES

############################################################################################################


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

table_server_ped_offense_type <- function(id, df) {

  moduleServer(id, function(input, output, session) {

    table <- reactive({viz_reactable_ped_offense_type(df())})
    output$table <- renderReactable({table()})

  })
}





############################################################################################################

# PLOTS

############################################################################################################


plot_ui <- function(id) {
  fluidRow(column(12, highchartOutput(NS(id, "plot"))))
}

plot_server <- function(id, df) {

  moduleServer(id, function(input, output, session) {

    plot <- reactive({viz_highcharter(df(), type = "pie",
                                      graph_name = "Offense Type",
                                      x_variable = "offgeneral",
                                      y_variable = "prop")})
    output$plot <- renderHighchart({plot()})

  })
}

viz_highcharter <- function(df, type, graph_name, x_variable, y_variable) {

  df$x_variable <- get(x_variable, df)
  df$y_variable <- get(y_variable, df)

  if(type == "pie"){
    df %>% hchart("pie", hcaes(x = x_variable, y = y_variable)) %>%
      hc_add_theme(hc_theme_jc) %>%
      hc_tooltip(formatter = JS("function(){return(this.point.tooltip)}")) %>%

      hc_plotOptions(series = list(animation = FALSE,
                                   cursor = "pointer",
                                   borderWidth = 3),
                     accessibility = list(enabled = TRUE,
                                          keyboardNavigation = list(enabled = TRUE),
                                          linkedDescription = 'TBD.',
                                          landmarkVerbosity = "one"),
                     area = list(accessibility = list(description = "TBD."))
      )

  } else if(type == "bar"){
    df %>%
      hchart("bar", hcaes(x = x_variable, y = y_variable)) %>%
      hc_add_theme(hc_theme_jc) %>%
      hc_tooltip(formatter = JS("function(){return(this.point.tooltip)}")) %>%

      hc_plotOptions(series = list(animation = FALSE,
                                   cursor = "pointer",
                                   borderWidth = 3),
                     accessibility = list(enabled = TRUE,
                                          keyboardNavigation = list(enabled = TRUE),
                                          linkedDescription = 'TBD.',
                                          landmarkVerbosity = "one"),
                     area = list(accessibility = list(description = "TBD."))
      )

  }

}






############################################################################################################

# REACTABLE

############################################################################################################

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

viz_reactable_ped_offense_type <- function(df) {
  df1 <- df %>% select(-state, -yearendpop_ped, -tooltip) %>% arrange(-n)
  reactable(df1,
            style = list(fontFamily = "Graphik, sans-serif",
                         fontSize = "1.5rem"
            ),
            theme = reactableTheme(cellStyle = list(display = "flex", flexDirection = "column", justifyContent = "center")),
            defaultColDef = colDef(format = colFormat(separators = TRUE), align = "center"),
            compact = TRUE,
            fullWidth = FALSE,
            columns = list(
              offgeneral    = colDef(name = "Offense Type",
                                     minWidth = 200,
                                     style = list(position = "sticky", borderRight = "1px solid #d3d3d3")),
              n = colDef(name = "Number of People Arrested (N)",
                                     minWidth = 95),
              prop   = colDef(name = "Proportion of People Arrested (%)",
                                     minWidth = 95,
                                     format = colFormat(percent = TRUE, digits = 1))
            ))
}


##############################



##############################
