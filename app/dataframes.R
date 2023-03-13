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







# metric module ----
metric_ui <- function(id) {

  fluidRow(
    text_ui(NS(id, "metric")),
    plot_ui(NS(id, "metric"))
  )

}

metric_server <- function(id, df, vbl, threshhold) {

  moduleServer(id, function(input, output, session) {

    text_server("metric", df, vbl, threshhold)
    plot_server("metric", df, vbl, threshhold)

  })

}

metric_demo <- function() {

  df <- data.frame(day = 1:30, arr_delay = 1:30)
  ui <- fluidPage(metric_ui("x"))
  server <- function(input, output, session) {
    metric_server("x", reactive({df}), "arr_delay", 15)
  }
  shinyApp(ui, server)

}






################################################################################

# plot module ----
plot_ui <- function(id) {

  fluidRow(
    column(11, plotOutput(NS(id, "plot"))),
    column( 1, downloadButton(NS(id, "dnld"), label = ""))
  )

}

plot_server <- function(id, df, vbl, threshhold = NULL) {

  moduleServer(id, function(input, output, session) {

    plot <- reactive({viz_monthly(df(), vbl, threshhold)})
    output$plot <- renderPlot({plot()})
    output$dnld <- downloadHandler(
      filename = function() {paste0(vbl, '.png')},
      content = function(file) {ggsave(file, plot())}
    )

  })
}

plot_demo <- function() {

  df <- data.frame(day = 1:30, arr_delay = 1:30)
  ui <- fluidPage(plot_ui("x"))
  server <- function(input, output, session) {
    plot_server("x", reactive({df}), "arr_delay")
  }
  shinyApp(ui, server)

}







################################################################################

# text module ----
text_ui <- function(id) {

  fluidRow(
    textOutput(NS(id, "text"))
  )

}

text_server <- function(id, df, vbl, threshhold) {

  moduleServer(id, function(input, output, session) {

    n <- reactive({sum(df()[[vbl]] > threshhold)})
    output$text <- renderText({
      paste("In this month",
            vbl,
            "exceeded the average daily threshhold of",
            threshhold,
            "a total of",
            n(),
            "days")
    })

  })

}

text_demo <- function() {

  df <- data.frame(day = 1:30, arr_delay = 1:30)
  ui <- fluidPage(text_ui("x"))
  server <- function(input, output, session) {
    text_server("x", reactive({df}), "arr_delay", 15)
  }
  shinyApp(ui, server)

}







################################################################################

viz_monthly <- function(df, y_var, threshhold = NULL) {

  ggplot(df) +
    aes(
      x = .data[["day"]],
      y = .data[[y_var]]
    ) +
    geom_line() +
    geom_hline(yintercept = threshhold, color = "red", linetype = 2) +
    scale_x_continuous(breaks = seq(1, 29, by = 7)) +
    theme_minimal()
}
