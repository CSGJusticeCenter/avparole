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

  ######################
  # PAROLE ELIGIBILITY
  ######################

  # Title of panel
  output$parole_eligibility_title <- renderText({"Parole Eligibility Trends in 2020"})

  # Pie chart showing Parole Eligibility in Currently


  # Pie chart showing Parole Eligibility in the Future



  # Get parole eligibility data
  df_parole_eligibility <- reactive({filter(parole_eligibility_table_2020, state == input$state)})

  # Parole Eligibility in Currently
  output$table_parole_elgibility_current <- renderReactable({
    df1 <- df_parole_eligibility() %>% select(-state)
    reactable(df1,
              style = list(fontFamily = "Graphik, sans-serif",
                           fontSize = "1.5rem"),
              theme = reactableTheme(cellStyle = list(display = "flex",
                                                      flexDirection = "column",
                                                      justifyContent = "center")),
              defaultColDef = colDef(format = colFormat(separators = TRUE),
                                     align = "center"),
              compact = TRUE,
              fullWidth = FALSE,
              columns = list(
                yearendpop    = colDef(show = F,
                                       name = "Year End Population (2020)",
                                       minWidth = 95,
                                       style = list(position = "sticky",
                                                    borderRight = "1px solid #d3d3d3")),
                current_count = colDef(name = "Currently Eligible for Parole (N)",
                                       minWidth = 150),
                current_perc  = colDef(name = "Currently Eligible for Parole (%)",
                                       minWidth = 150,
                                       format = colFormat(percent = TRUE, digits = 1)),
                future_count  = colDef(show = F,
                                       name = "Eligible for Parole in the Future (N)",
                                       minWidth = 150),
                future_perc   = colDef(show = F,
                                       name = "Eligible for Parole in the Future (%)",
                                       minWidth = 150,
                                       format = colFormat(percent = TRUE, digits = 1))
              ))
  })

  # Parole Eligibility in the Future
  output$table_parole_elgibility_future <- renderReactable({
    df1 <- df_parole_eligibility() %>% select(-state)
    reactable(df1,
              style = list(fontFamily = "Graphik, sans-serif",
                           fontSize = "1.5rem"),
              theme = reactableTheme(cellStyle = list(display = "flex",
                                                      flexDirection = "column",
                                                      justifyContent = "center")),
              defaultColDef = colDef(format = colFormat(separators = TRUE),
                                     align = "center"),
              compact = TRUE,
              fullWidth = FALSE,
              columns = list(
                yearendpop    = colDef(show = F,
                                       name = "Year End Population (2020)",
                                       minWidth = 95,
                                       style = list(position = "sticky",
                                                    borderRight = "1px solid #d3d3d3")),
                current_count = colDef(show = F,
                                       name = "Currently Eligible for Parole (N)",
                                       minWidth = 150),
                current_perc  = colDef(show = F,
                                       name = "Currently Eligible for Parole (%)",
                                       minWidth = 150,
                                       format = colFormat(percent = TRUE, digits = 1)),
                future_count  = colDef(name = "Eligible for Parole in the Future (N)",
                                       minWidth = 150),
                future_perc   = colDef(name = "Eligible for Parole in the Future (%)",
                                       minWidth = 150,
                                       format = colFormat(percent = TRUE, digits = 1))
              ))
  })

  # Parole Eligibility and Offense Type
  output$parole_eligibility_offense_title <- renderText({"Parole Eligibility and Offense Type in 2020"})

  # Sentence explaining number of people eligible for release but not yet due to which offense type
  # "Of the X people eligible for release before 2020 but not yet released, the most serious offense was violent."
  df_ped_offense_type <- reactive({filter(current_ped_2020_offenses, state == input$state)})

  # Pie chart showing the proportion of people eligible for release but not yet due to each offense type
  output$pie_parole_elgibility_offense <- renderHighchart({
    df_ped_offense_type() %>%
      hchart("pie",
             hcaes(x = offgeneral, y = prop)) %>%
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
  })

  # Reactable table showing the number of people eligible for release but not yet due to each offense type
  output$table_parole_elgibility_offense <- renderReactable({
    df1 <- df_ped_offense_type() %>% select(-c(state, yearendpop_ped, tooltip)) %>% arrange(-n)
    reactable(df1,
              style = list(fontFamily = "Graphik, sans-serif",
                           fontSize = "1.5rem"
              ),
              theme = reactableTheme(cellStyle = list(display = "flex",
                                                      flexDirection = "column",
                                                      justifyContent = "center")),
              defaultColDef = colDef(format = colFormat(separators = TRUE),
                                     align = "center"),
              compact = TRUE,
              fullWidth = FALSE,
              columns = list(
                offgeneral    = colDef(name = "Offense Type",
                                       minWidth = 200,
                                       style = list(position = "sticky",
                                                    borderRight = "1px solid #d3d3d3")),
                n = colDef(name = "Number of People Arrested (N)",
                           minWidth = 95),
                prop   = colDef(name = "Proportion of People Arrested (%)",
                                minWidth = 95,
                                format = colFormat(percent = TRUE, digits = 1))
              ))
  })




  ######################
  # PAROLE BOARD
  ######################

  # Title of panel
  output$parole_board_title <- renderText({"Parole Board Decision-Making"})





  ######################
  # Disparities
  ######################

  # Title of panel
  output$parole_disparities_title <- renderText({"Racial, Ethnic, and Gender Disparities"})





}
