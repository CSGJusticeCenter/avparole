#######################################
# Project: AV Parole
# File: server.R
# Authors: Mari Roberts
# Date last updated: April 25, 2023 (MAR)
# Description:
#    Server for shiny app
#######################################

server <- function(input, output, session) {

  ######################
  # Parole Overview
  ######################

  # get information on people on parole by race depending on state selection
  df_parole_profile_race <- reactive({filter(people_on_parole_race, state == input$state)})

  # create reactable table using df_parole_profile_race()
  output$table_parole_profile_race <- renderReactable({
    reactable(df_parole_profile_race(),
              style = list(fontFamily = "Graphik, sans-serif",
                           fontSize = "1.5rem"),
              theme = hc_reactable_theme,
              defaultColDef = colDef(format = colFormat(separators = TRUE),
                                     align = "left"),
              compact = TRUE,
              fullWidth = FALSE,
              columns = list(
                state          = colDef(show = F, name = "State"),
                race           = colDef(show = T, name = "Race", minWidth = 215),
                total_race     = colDef(show = F, name = "Total (Race)"),
                total_releases = colDef(show = F, name = "Total (Releases)"),
                prop           = colDef(show = T,
                                        align = "right",
                                        name = "",
                                        minWidth = 215,
                                        format = colFormat(percent = TRUE, digits = 1))
              ))
  })

  # get information on people on parole by sex depending on state selection
  df_parole_profile_sex <- reactive({filter(people_on_parole_sex, state == input$state)})

  # create reactable table using df_parole_profile_sex()
  output$table_parole_profile_sex <- renderReactable({
    reactable(df_parole_profile_sex(),
              style = list(fontFamily = "Graphik, sans-serif",
                           fontSize = "1.5rem"),
              theme = hc_reactable_theme,

              defaultColDef = colDef(format = colFormat(separators = TRUE),
                                     align = "left"),
              compact = TRUE,
              fullWidth = FALSE,
              columns = list(
                state          = colDef(show = F, name = "State"),
                sex            = colDef(show = T, name = "Gender", minWidth = 215),
                total_sex      = colDef(show = F, name = "Total (Gender)"),
                total_releases = colDef(show = F, name = "Total (Releases)"),
                prop           = colDef(show = T,
                                        align = "right",
                                        name = "",
                                        minWidth = 215,
                                        format = colFormat(percent = TRUE, digits = 1))
              ))
  })

  # get information on people on parole by age depending on state selection
  df_parole_profile_age <- reactive({filter(people_on_parole_age, state == input$state)})

  # create reactable table using df_parole_profile_age()
  output$table_parole_profile_age <- renderReactable({
    reactable(df_parole_profile_age(),
              style = list(fontFamily = "Graphik, sans-serif",
                           fontSize = "1.5rem"),
              theme = hc_reactable_theme,

              defaultColDef = colDef(format = colFormat(separators = TRUE),
                                     align = "left"),
              compact = TRUE,
              fullWidth = FALSE,
              columns = list(
                state          = colDef(show = F, name = "State"),
                agerlse        = colDef(show = T, name = "Age", minWidth = 215),
                total_agerlse  = colDef(show = F, name = "Total (Age)"),
                total_releases = colDef(show = F, name = "Total (Releases)"),
                prop           = colDef(show = T,
                                        name = "",
                                        align = "right",
                                        minWidth = 215,
                                        format = colFormat(percent = TRUE, digits = 1))
              ))
  })

  # get information on people on parole by age median depending on state selection
  df_parole_profile_age_median <- reactive({filter(people_on_parole_age_median, state == input$state)})

  # create reactable table using df_parole_profile_age()
  output$table_parole_profile_age_median <- renderReactable({
    reactable(df_parole_profile_age_median(),
              style = list(fontFamily = "Graphik, sans-serif",
                           fontSize = "1.5rem"),
              theme = reactableTheme(
                borderColor = neutralBkgndLight,
                stripedColor = neutralBkgndLight,

                cellStyle = list(display = "flex",
                                 flexDirection = "column",
                                 justifyContent = "center"),
                headerStyle = list(borderColor = "#FFFFFF")),
              defaultColDef = colDef(format = colFormat(separators = TRUE),
                                     align = "left"),
              rowStyle = function(index) {
                if (index %in% c(1)) {
                  list(`border-bottom` = "thin solid",
                       `border-color` = neutralBkgndLight)
                }
              },
              compact = TRUE,
              sortable = FALSE,
              fullWidth = FALSE,
              columns = list(
                state           = colDef(show = F, name = "State"),
                data            = colDef(show = T, name = "", minWidth = 215, style = list(fontWeight = "bold")),
                agerlse_median  = colDef(show = T, name = "", align = "right", minWidth = 215))
              )
  })

  # get information on people on parole by education median depending on state selection
  df_parole_profile_education_median <- reactive({filter(people_on_parole_education_median, state == input$state)})

  # create reactable table using df_parole_profile_education()
  output$table_parole_profile_education_median <- renderReactable({
    reactable(df_parole_profile_education_median(),
              style = list(fontFamily = "Graphik, sans-serif",
                           fontSize = "1.5rem"),
              theme = reactableTheme(
                borderColor = neutralBkgndLight,
                stripedColor = neutralBkgndLight,

                cellStyle = list(display = "flex",
                                 flexDirection = "column",
                                 justifyContent = "center"),
                headerStyle = list(borderColor = "#FFFFFF")),
              defaultColDef = colDef(format = colFormat(separators = TRUE),
                                     align = "left"),
              rowStyle = function(index) {
                if (index %in% c(1)) {
                  list(`border-bottom` = "thin solid",
                       `border-color` = neutralBkgndLight)
                }
              },
              compact = TRUE,
              sortable = FALSE,
              fullWidth = FALSE,
              columns = list(
                state            = colDef(show = F, name = "State"),
                data             = colDef(show = T, name = "", minWidth = 215, style = list(fontWeight = "bold")),
                education_median = colDef(show = T, name = "", align = "right", minWidth = 215))
    )
  })

  ######################
  # Parole eligibility
  ######################

  # Title of pie charts about parole eligibility
  output$top_pie_title1 <-
    renderText({paste0("Currently Eligible", "<br>" , "for Parole")})
  output$top_pie_title2 <-
    renderText({paste0("Eligible for Parole", "<br>", "in the Future")})
  output$top_pie_title3 <-
    renderText({paste0("Another", "<br>", "Finding TBD")})

  # Get parole eligibility data
  df_parole_eligibility <-
    reactive({filter(parole_eligibility_table_2020, state == input$state)})

  # Get parole eligibility data for pie charts
  df_parole_eligibility_current <- reactive({
    df <- parole_eligibility_table_2020 %>%
    filter(state == input$state) %>%
    select(state, current_perc) %>%
    mutate(rest = 1-current_perc) %>%
    pivot_longer(cols      = c(current_perc:rest),
                 names_to  = "type",
                 values_to = "pct") %>%
    mutate(tooltip =
             case_when(type == "current_perc" ~
                         paste0("<b>", state, "</b><br>",
                                "Percentage of People Eligible for Release:<br>",
                                paste(round(pct*100, 0), "%</b>", sep = ""), "<br>"),
                       type == "rest" ~
                         paste0("<b>", state, "</b><br>",
                                "Percentage of People Not Eligible for Release:<br>",
                                paste(round(pct*100, 0), "%</b>", sep = ""), "<br>")))
  })

  # Get parole eligibility data for pie charts
  df_parole_eligibility_future <- reactive({
    df <- parole_eligibility_table_2020 %>%
      filter(state == input$state) %>%
      select(state, future_perc) %>%
      mutate(rest = 1-future_perc) %>%
      pivot_longer(cols      = c(future_perc:rest),
                   names_to  = "type",
                   values_to = "pct") %>%
      mutate(tooltip =
               case_when(type == "future_perc" ~
                           paste0("<b>", state, "</b><br>",
                                  "Percentage of People Eligible for Release in the Future:<br>",
                                  paste(round(pct*100, 0), "%</b>", sep = ""), "<br>"),
                         type == "rest" ~
                           paste0("<b>", state, "</b><br>",
                                  "Percentage of People Not Eligible for Release in the Future:<br>",
                                  paste(round(pct*100, 0), "%</b>", sep = ""), "<br>")))
  })

  # Pie chart showing Parole Eligibility in Currently
  output$pie_currently_eligible <- renderHighchart({

    df1 <- df_parole_eligibility_current() %>%
      filter(type == "current_perc") %>%
      mutate(pctlabel = paste0(round(pct*100,0), "%"))

    highchart() %>%

      hc_add_series(type = "pie",
                    data = df1,
                    hcaes(state, pct),
                    size = "100%",
                    name = "TBD",
                    center = c(50, 50),
                    innerSize="60%",
                    dataLabels = list(
                      style = list(fontSize = "2em",
                                   color = neutralBlackText),
                      enabled = TRUE,
                      distance= -65,
                      format = "{point.pctlabel}")
      ) %>%
      hc_add_series(type = "pie",
                    data = df_parole_eligibility_current(),
                    hcaes(state, pct),
                    size = "100%",
                    name = "TBD",
                    center = c(50, 50),
                    innerSize="60%",
                    dataLabels = list(enabled = FALSE)
      ) %>%

      hc_tooltip(formatter = JS("function(){return(this.point.tooltip)}")) %>%

      hc_add_theme(hc_theme_jc_pie) %>%

      hc_plotOptions(innersize="50%",
                     startAngle=90,
                     endAngle=90,
                     center=list('50%', '75%'),
                     size='110%',
                     series = list(animation = FALSE,
                                   cursor = "pointer",
                                   borderWidth = 3),
                     accessibility = list(enabled = TRUE,
                                          keyboardNavigation = list(enabled = TRUE),
                                          linkedDescription = 'TBD.',
                                          landmarkVerbosity = "one"),
                     area = list(accessibility = list(description = "TBD.")))
  })

  # Pie chart showing Parole Eligibility in the Future
  output$pie_future_eligible <- renderHighchart({

    df1 <- df_parole_eligibility_future() %>%
      filter(type == "future_perc") %>%
      mutate(pctlabel = paste0(round(pct*100,0), "%"))

    highchart() %>%

      hc_add_series(type = "pie",
                    data = df1,
                    hcaes(state, pct),
                    size = "100%",
                    name = "TBD",
                    center = c(50, 50),
                    innerSize="60%",
                    dataLabels = list(
                      style = list(fontSize = "2em",
                                   color = neutralBlackText),
                      enabled = TRUE,
                      distance= -65,
                      format = "{point.pctlabel}")
      ) %>%
      hc_add_series(type = "pie",
                    data = df_parole_eligibility_future(),
                    hcaes(state, pct),
                    size = "100%",
                    name = "TBD",
                    center = c(50, 50),
                    innerSize="60%",
                    dataLabels = list(enabled = FALSE)
      ) %>%

      hc_tooltip(formatter = JS("function(){return(this.point.tooltip)}")) %>%

      hc_add_theme(hc_theme_jc_pie) %>%

      hc_plotOptions(innersize="50%",
                     startAngle=90,
                     endAngle=90,
                     center=list('50%', '75%'),
                     size='110%',
                     series = list(animation = FALSE,
                                   cursor = "pointer",
                                   borderWidth = 3),
                     accessibility = list(enabled = TRUE,
                                          keyboardNavigation = list(enabled = TRUE),
                                          linkedDescription = 'TBD.',
                                          landmarkVerbosity = "one"),
                     area = list(accessibility = list(description = "TBD.")))
  })

  # # Parole Eligibility in Currently
  # output$table_parole_elgibility_current <- renderReactable({
  #   df1 <- df_parole_eligibility() %>% select(-state)
  #   reactable(df1,
  #             style = list(fontFamily = "Graphik, sans-serif",
  #                          fontSize = "1.5rem"),
  #             theme = reactableTheme(cellStyle = list(display = "flex",
  #                                                     flexDirection = "column",
  #                                                     justifyContent = "center")),
  #             defaultColDef = colDef(format = colFormat(separators = TRUE),
  #                                    align = "center"),
  #             compact = TRUE,
  #             fullWidth = FALSE,
  #             columns = list(
  #               yearendpop    = colDef(show = F,
  #                                      name = "Year End Population (2020)",
  #                                      minWidth = 95,
  #                                      style = list(position = "sticky",
  #                                                   borderRight = "1px solid #d3d3d3")),
  #               current_count = colDef(name = "Currently Eligible for Parole (N)",
  #                                      minWidth = 150),
  #               current_perc  = colDef(name = "Currently Eligible for Parole (%)",
  #                                      minWidth = 150,
  #                                      format = colFormat(percent = TRUE, digits = 1)),
  #               future_count  = colDef(show = F,
  #                                      name = "Eligible for Parole in the Future (N)",
  #                                      minWidth = 150),
  #               future_perc   = colDef(show = F,
  #                                      name = "Eligible for Parole in the Future (%)",
  #                                      minWidth = 150,
  #                                      format = colFormat(percent = TRUE, digits = 1))
  #             ))
  # })

  # # Parole Eligibility in the Future
  # output$table_parole_elgibility_future <- renderReactable({
  #   df1 <- df_parole_eligibility() %>% select(-state)
  #   reactable(df1,
  #             style = list(fontFamily = "Graphik, sans-serif",
  #                          fontSize = "1.5rem"),
  #             theme = reactableTheme(cellStyle = list(display = "flex",
  #                                                     flexDirection = "column",
  #                                                     justifyContent = "center")),
  #             defaultColDef = colDef(format = colFormat(separators = TRUE),
  #                                    align = "center"),
  #             compact = TRUE,
  #             fullWidth = FALSE,
  #             columns = list(
  #               yearendpop    = colDef(show = F,
  #                                      name = "Year End Population (2020)",
  #                                      minWidth = 95,
  #                                      style = list(position = "sticky",
  #                                                   borderRight = "1px solid #d3d3d3")),
  #               current_count = colDef(show = F,
  #                                      name = "Currently Eligible for Parole (N)",
  #                                      minWidth = 150),
  #               current_perc  = colDef(show = F,
  #                                      name = "Currently Eligible for Parole (%)",
  #                                      minWidth = 150,
  #                                      format = colFormat(percent = TRUE, digits = 1)),
  #               future_count  = colDef(name = "Eligible for Parole in the Future (N)",
  #                                      minWidth = 150),
  #               future_perc   = colDef(name = "Eligible for Parole in the Future (%)",
  #                                      minWidth = 150,
  #                                      format = colFormat(percent = TRUE, digits = 1))
  #             ))
  # })

  # Sentence explaining number of people eligible for release but not yet due to which offense type
  # "Of the X people eligible for release before 2020 but not yet released, the most serious offense was violent."
  df_ped_offense_type <- reactive({filter(current_ped_2020_offenses, state == input$state)})

  # Pie chart showing the percentage of people eligible for release but not yet due to each offense type
  output$pie_parole_elgibility_offense <- renderHighchart({

    df_ped_offense_type() %>%

      hchart("pie",
             hcaes(x = offgeneral, y = prop),
             dataLabels = list(
               style = list(fontSize = "1.25em",
                            fontWeight = "regular",
                            color = neutralBlackText),
               enabled = TRUE,
               format = "{point.offgeneral}")) %>%

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
                           fontSize = "1.5rem"),
              theme = hc_reactable_theme,
              defaultColDef = colDef(format = colFormat(separators = TRUE),
                                     align = "left"),
              compact = TRUE,
              fullWidth = FALSE,
              columns = list(
                offgeneral    = colDef(name = "Most Serious Sentenced Offense",
                                       minWidth = 200),
                n = colDef(name = "Number of People",
                           minWidth = 100,
                           align = "right"),
                prop   = colDef(name = "Percentage of People Eligible for Parole but not yet Released",
                                minWidth = 175,
                                align = "right",
                                format = colFormat(percent = TRUE, digits = 1))
              ))
  })


  ######################
  # Releases
  ######################






  ######################
  # Sentencing
  ######################






  ######################
  # Parole Board
  ######################





  ######################
  # Disparities
  ######################





}
