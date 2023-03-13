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

# data prep ----
ua_data <-
  nycflights13::flights %>%
  filter(carrier == "UA") %>%
  mutate(ind_arr_delay = (arr_delay > 5)) %>%
  group_by(year, month, day) %>%
  summarize(
    n = n(),
    across(ends_with("delay"), mean, na.rm = TRUE)
  ) %>%
  ungroup()

ui <- fluidPage(

  titlePanel("Flight Delay Report"),

  sidebarLayout(
    sidebarPanel = sidebarPanel(
      selectInput("month", "Month",
                  choices = setNames(1:12, month.abb),
                  selected = 1
      )
    ),
    mainPanel = mainPanel(
      h2(textOutput("title")),
      h3("Average Departure Delay"),
      metric_ui("dep_delay"),
      h3("Average Arrival Delay"),
      metric_ui("arr_delay"),
      h3("Proportion Flights with >5 Min Arrival Delay"),
      metric_ui("ind_arr_delay")
    )
  )
)
