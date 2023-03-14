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
                                    ), # end div header

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
                                                 column(width = 1)),                                        br(),br(),br(),

                                        # PAROLE ELIGIBILITY
                                        fluidRow(column(width = 1),
                                                 column(width = 10,
                                                        div(id = "viz-header",
                                                            textOutput("parole_eligibility_viz_title"))),
                                                 column(width = 1)),                                        br(), br(),
                                        parole_eligibility_ui("parole_eligibility_reactable"),              br(), br(), br(),

                                        # ELIGIBILITY AND OFFENSES
                                        fluidRow(column(width = 1),
                                                 column(width = 10,
                                                        div(id = "viz-header",
                                                            textOutput("ped_offense_type_viz_title"))),
                                                 column(width = 1)),                                        br(),br(),
                                        ped_offense_type_sentence_ui("ped_offense_type_sentence"),          br(),
                                        ped_offense_type_ui("ped_offense_type_reactable"),                  br(), br(), br()

                                    ) # end div

                           ) # end tabPanel
                ))
