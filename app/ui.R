#######################################
# Project: AV Parole
# File: ui.R
# Authors: Mari Roberts
# Date last updated: April 28, 2023 (MAR)
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

                           tabPanel("State Reports", id = "statereports",

                                    br(), br(),

                                    div(id = "app-body",

                                        ##########################################
                                        # State Report
                                        ##########################################

                                        # STATE SELECTED

                                        fluidRow(column(width = 1),
                                                 column(width = 10,
                                                        # div(id = "selected-state",
                                                        #     textOutput("selected_state"))),
                                                        div(id = "selected-state",
                                                            pickerInput('state',
                                                                        label = NULL,
                                                                        width = "fit",
                                                                        choices = unique(parole_eligibility_table_2020$state),
                                                                        options = list(style = "re-picker"),
                                                                        selected = "Georgia",
                                                                        inline = TRUE))),
                                                 column(width = 1)),
                                        br(),

                                        # Pie charts
                                        fluidRow(column(width = 3),
                                                 column(width = 2,
                                                        div(id = "subsection-header",
                                                            htmlOutput("top_pie_title1"))),
                                                 column(width = 2,
                                                        div(id = "subsection-header",
                                                            htmlOutput("top_pie_title2"))),
                                                 column(width = 2,
                                                        div(id = "subsection-header",
                                                            htmlOutput("top_pie_title3"))),
                                                 column(width = 3)),

                                        fluidRow(column(width = 3),
                                                 column(width = 2,
                                                        div(id = "pie-chart",
                                                            highchartOutput("pie_currently_eligible",
                                                                            height = 150))),
                                                 column(width = 2,
                                                        div(id = "pie-chart",
                                                            highchartOutput("pie_future_eligible",
                                                                            height = 150))),
                                                 column(width = 5)),
                                        br(),

                                        fluidRow(column(width = 1),
                                                 column(width = 10,

                                                        tabsetPanel(selected = "1", type = "tabs", id = "tabsetpanel",

                                                                    ##################
                                                                    # Parole Overview
                                                                    ##################

                                                                    tabPanel(value="1","Parole Overview",

                                                                             br(),br(),
                                                                             fluidRow(column(width = 6,
                                                                                             div(id = "section-header",
                                                                                                 "Profile of People Released to Parole in 2020"),      br(),
                                                                                             reactableOutput("table_parole_profile_race"),             br(),
                                                                                             reactableOutput("table_parole_profile_sex"),              br(),
                                                                                             reactableOutput("table_parole_profile_age"),
                                                                                             reactableOutput("table_parole_profile_age_median"),
                                                                                             reactableOutput("table_parole_profile_education_median"), br()
                                                                                             ),
                                                                                      column(width = 6,
                                                                                             div(id = "section-header",
                                                                                                 "Change in X from X Year to Y Year"))),
                                                                             br(), br()

                                                                    ), # end tabPanel

                                                                    ##################
                                                                    # Parole Eligibility
                                                                    ##################

                                                                    tabPanel(value="2","Parole Eligibility",

                                                                             # Redundant information
                                                                             # # Reactable tables
                                                                             # fluidRow(column(width = 2),
                                                                             #          column(width = 3,
                                                                             #                 div(id = "reactable-table",
                                                                             #                     reactableOutput("table_parole_elgibility_current"))),
                                                                             #          column(width = 2),
                                                                             #          column(width = 3,
                                                                             #                 div(id = "reactable-table",
                                                                             #                     reactableOutput("table_parole_elgibility_future"))),
                                                                             #          column(width = 2)),
                                                                             # br(), br(),

                                                                             # Title
                                                                             br(), br(),
                                                                             fluidRow(
                                                                               column(width = 6,
                                                                                      div(id = "section-header",
                                                                                          "Most Serious Sentenced Offense for People Eligible for
                                                                                          Parole but not yet Released in 2020")),
                                                                               column(width = 6,
                                                                                      div(id = "section-header",
                                                                                          "More Information on Eligibility TBD"))
                                                                             ),
                                                                             br(),

                                                                             # Pie chart
                                                                             fluidRow(
                                                                               column(width = 6,
                                                                                      div(id = "pie-chart",
                                                                                          highchartOutput("pie_parole_elgibility_offense",
                                                                                                          height = 250))),
                                                                               column(width = 6)
                                                                             ),
                                                                             br(),

                                                                             # Reactable table
                                                                             fluidRow(
                                                                               column(width = 6,
                                                                                      div(id = "reactable-table",
                                                                                          reactableOutput("table_parole_elgibility_offense"))),
                                                                               column(width = 6)
                                                                             ),
                                                                             br(), br(),



                                                                    ), # end tabPanel

                                                                    ##################
                                                                    # Releases from Prison
                                                                    ##################

                                                                    tabPanel(value="3","Releases from Prison",

                                                                             br(),br(),
                                                                             fluidRow(column(width = 1),
                                                                                      column(width = 10,
                                                                                             div(id = "section-header",
                                                                                                 "Releases from Prison"),
                                                                                             div(id = "section-body",
                                                                                             "Who is being released at first eligibility?", br(),br(),
                                                                                             "How long after eligibility does release occur?", br(),br(),
                                                                                             "How does release vary by the person's demographic and criminal history characteristics?", br(),br(),
                                                                                             "What is the mean and median time between parole eligibility and release for those released after the PED, by maximum sentence length?", br(),br(),
                                                                                             "How many people are currently eligible for release but still in prison? What percentage of the prison population is this?", br(),br(),
                                                                                             "Number/percentage of release types from X year to Y year.", br(),br(),
                                                                                             "Marginal Effects of Year of Release on Days Between PED and Release for the X Offense Class (Days between PED and release by year of release)", br(),br(),
                                                                                             "Predicted probabilities of being released within 1 year of parole eligibility. For example (Male = 53%, Female = 65%, Max Sentence <2 years = 82%, Max Sentence +15 years-less than life = 34%, Race, Most Serious Sentence Offense)", br(),br()
                                                                                             )),
                                                                                      column(width = 1)),
                                                                             br(), br()

                                                                    ), # end tabPanel

                                                                    ##################
                                                                    # Sentencing
                                                                    ##################

                                                                    tabPanel(value="4","Sentencing",

                                                                             br(),br(),
                                                                             fluidRow(column(width = 1),
                                                                                      column(width = 10,
                                                                                             div(id = "section-header",
                                                                                                 "Sentencing")),
                                                                                      column(width = 1)),
                                                                             br(), br()

                                                                    ), # end tabPanel

                                                                    ##################
                                                                    # Parole Board Decision-Making
                                                                    ##################

                                                                    tabPanel(value="5","Parole Board",

                                                                             br(),br(),
                                                                             fluidRow(column(width = 1),
                                                                                      column(width = 10,
                                                                                             div(id = "section-header",
                                                                                                 "Parole Board")),
                                                                                      column(width = 1)),
                                                                             br(), br(),

                                                                    ), # end tabPanel

                                                                    ##################
                                                                    # Disparities
                                                                    ##################

                                                                    tabPanel(value="6","Disparities",

                                                                             br(),br(),
                                                                             fluidRow(column(width = 1),
                                                                                      column(width = 10,
                                                                                             div(id = "section-header",
                                                                                                 "Disparities")),
                                                                                      column(width = 1)),
                                                                             br(), br()

                                                                    ) # end tabPanel

                                                        ) # tabsetPanel
                                                 ),
                                                 column(width = 1))


                                    ) # end div

                           ), # end tabPanel

                           tabPanel("Nationwide Overview", id = "nationwideoverview",
                                    br(), br(),

                                    div(id = "app-body",

                                        fluidRow(column(width = 1),
                                                 column(width = 10,
                                                        div(id = "section-header", "Overview"), br(),
                                                        div(id = "section-body",
                                                        "[Interactive Graph] People Under U.S. Correctional Supervision from X year to Y year (Prison, jail, parole, probation)", br(), br(),
                                                        "[Interactive Graph] Prison Rate Change in X State(s) from X year to Y year (Each state will have it's own line)", br(), br(),
                                                        "[Interactive Graph] Racial/Ethnic/Gender Disparities in Prisons from X year to Y year", br(),br(),
                                                        "[Interactive Graph] Prison Population by Offense in X year", br(),br(),
                                                        "[Interactive Graph] The Growth of Life Sentences from X year to Y year (Life without Parole, Life with Parole)", br(),br(),
                                                        "[Interactive Graph] X Race/Ethnicity Americans of the US Population, Total Prison Population, and Who Have Served at Least 10 years", br(), br(),
                                                        "[Interactive Graph] Ranked state imprisonment rates in X year", br(), br(),
                                                        )
                                                        ),
                                                 column(width = 1)),
                                        br(),

                                        fluidRow(column(width = 1),
                                                 column(width = 10,
                                                        div(id = "section-header", "Parole"), br(),
                                                        div(id = "section-body",
                                                        "[Visual TBD] Determine sentencing states, indeterminate sentencing states", br(), br(),
                                                        "[Visual TBD] Truth in sentencing (TIS) grant program", br(), br(),
                                                        "[Interactive Graph] Ranked states for number of people or percentage of state poulation under US correctional supervision in X year", br(), br(),
                                                        "[Interactive Graph] Releases over time (conditional vs unconditional) as a percentage of all releases from X year to Y year", br(), br(),
                                                        "[Interactive Map] Parole violators as a percentage of all prison admissions by state in X year (Each state will have it's own line)", br(), br(),
                                                        "[Interactive Graph] Number of people released to parole supervision from X year to Y year for X state(s)", br(), br(),
                                                        )
                                                 ),
                                                 column(width = 1)),
                                        br()

                                    ) # end div
                                    ),
                           tabPanel("Map Explorer",        id = "mapexplorer"),
                           tabPanel("Data Download",       id = "downloaddata")

                ))
