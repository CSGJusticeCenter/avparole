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
source("functions.R")
source("dataframes.R")
source("modules.R")

ui <- fluidPage(includeCSS("www/theme.css"),

  navbarPage(id = "navbarID",

     # formats light blue header
     tags$style(type = "text/css", ".container-fluid {padding-left:0px; padding-right:0px;}"),
     tags$style(type = "text/css", ".navbar {margin-bottom: .5px;}"),
     tags$style(type = "text/css", ".container-fluid .navbar-header .navbar-brand {margin-left: 0px;}"),

     # hide errors on user-end
     tags$style(type="text/css",
                ".shiny-output-error { visibility: hidden; }",
                ".shiny-output-error:before { visibility: visible; content: ''; }"),

     title = "AV Parole Dashboard",
     tags$html(lang="en"),

     tabPanel("statereports", id = "statereports",

              #######
              # Dropdown and download buttons
              #######

              div(id = "app-header",
                  fluidRow(# Select State
                    column(width = 2),
                    column(width = 8, align = "left", class = "input-col",
                           selectInput("state", "State",
                                       choices = unique(parole_eligibility_table_2020$state),
                                       selected = "Georgia")),
                    column(width = 2)
                  ) # fluidRow
              ), # end div app-header
              br(), br(),

              div(id = "app-body",

                  ##########################################
                  # State Report
                  ##########################################

                  # STATE SELECTED

                  fluidRow(column(width = 1),
                           column(width = 10,
                                  div(id = "selected-state",
                                      textOutput("selected_state"))),
                           column(width = 1)),
                  br(),br(),

                  fluidRow(column(width = 1),
                           column(width = 10,

                                  tabsetPanel(selected = "1", type = "tabs",id = "tabsetpanel",

                                              tabPanel(value="1","Parole Eligibility",

                                                       ##############################
                                                       # Parole Eligibility in 2020
                                                       ##############################

                                                       # Title
                                                       br(),br(),
                                                       fluidRow(column(width = 1),
                                                                column(width = 10,
                                                                       div(id = "section-header",
                                                                           textOutput("parole_eligibility_title"))),
                                                                column(width = 1)),
                                                       br(), br(),

                                                       # Pie charts

                                                       # Reactable tables
                                                       fluidRow(column(width = 2),
                                                                column(width = 3, align = "center",
                                                                       div(id = "reactable-table",
                                                                           reactableOutput("table_parole_elgibility_current"))),
                                                                column(width = 2),
                                                                column(width = 3, align = "center",
                                                                       div(id = "reactable-table",
                                                                           reactableOutput("table_parole_elgibility_future"))),
                                                                column(width = 2)),
                                                       br(), br(),

                                                       ##############################
                                                       # Parole Eligibility and Offense Type in 2020
                                                       ##############################

                                                       # Title
                                                       fluidRow(column(width = 1),
                                                                column(width = 10,
                                                                       div(id = "section-header",
                                                                           textOutput("parole_eligibility_offense_title"))),
                                                                column(width = 1)),
                                                       br(), br(),

                                                       # Reactable table and pie chart
                                                       fluidRow(column(width = 1),
                                                                column(width = 4,
                                                                       br(), br(),
                                                                       div(id = "reactable-table",
                                                                           reactableOutput("table_parole_elgibility_offense"))),
                                                                column(width = 1),
                                                                column(width = 5,
                                                                       div(id = "pie-chart",
                                                                           highchartOutput("pie_parole_elgibility_offense", height = 300))),
                                                                column(width = 1)),
                                                       br(), br(),



                                              ), # end tabPanel








                                              tabPanel(value="2","Parole Board Decision-Making",

                                                       br(),br(),
                                                       fluidRow(column(width = 1),
                                                                column(width = 10,
                                                                       div(id = "section-header",
                                                                           textOutput("parole_board_title"))),
                                                                column(width = 1)),
                                                       br(), br()

                                              ), # end tabPanel









                                              tabPanel(value="3","Disparities",

                                                       br(),br(),
                                                       fluidRow(column(width = 1),
                                                                column(width = 10,
                                                                       div(id = "section-header",
                                                                           textOutput("parole_disparities_title"))),
                                                                column(width = 1)),
                                                       br(), br()

                                              ) # end tabPanel
                                  ) # tabsetPanel
                           ),
                           column(width = 1))


              ) # end div

     ) # end tabPanel
))
