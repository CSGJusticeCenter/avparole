#######################################
# Project: AV Parole
# File: server.R
# Authors: Mari Roberts
# Date last updated: May 3, 2023 (MAR)
# Description:
#    Server for shiny app
#######################################

server <- function(input, output, session) {

  ######################
  # Parole Overview
  ######################

  # get information on people on parole by race depending on state selection
  df_parole_profile_race <- reactive({filter(people_released_to_parole_race, state == input$state)})

  # create reactable table using df_parole_profile_race()
  output$table_parole_profile_race <- renderReactable({
    reactable(df_parole_profile_race(),
              style = hc_reactable_style,
              theme = hc_reactable_theme,
              defaultColDef = colDef(format = colFormat(separators = TRUE),
                                     align = "left"),
              compact = TRUE,
              fullWidth = FALSE,
              columns = list(
                state          = colDef(show = FALSE,
                                        name = "State"),
                race           = colDef(show = TRUE,
                                        name = "Race",
                                        minWidth = 215),
                total_race     = colDef(show = FALSE,
                                        name = "Total (Race)"),
                total_releases = colDef(show = FALSE,
                                        name = "Total (Releases)"),
                prop           = colDef(show = TRUE,
                                        align = "right",
                                        name = "",
                                        minWidth = 215,
                                        format = colFormat(percent = TRUE, digits = 1))))
  })

  # get information on people on parole by sex depending on state selection
  df_parole_profile_sex <- reactive({filter(people_released_to_parole_sex, state == input$state)})

  # create reactable table using df_parole_profile_sex()
  output$table_parole_profile_sex <- renderReactable({
    reactable(df_parole_profile_sex(),
              style = hc_reactable_style,
              theme = hc_reactable_theme,

              defaultColDef = colDef(format = colFormat(separators = TRUE),
                                     align = "left"),
              compact = TRUE,
              fullWidth = FALSE,
              columns = list(
                state          = colDef(show = FALSE,
                                        name = "State"),
                sex            = colDef(show = TRUE,
                                        name = "Gender",
                                        minWidth = 215),
                total_sex      = colDef(show = FALSE,
                                        name = "Total (Gender)"),
                total_releases = colDef(show = FALSE,
                                        name = "Total (Releases)"),
                prop           = colDef(show = TRUE,
                                        align = "right",
                                        name = "",
                                        minWidth = 215,
                                        format = colFormat(percent = TRUE,
                                                           digits = 1))))
  })

  # get information on people on parole by age depending on state selection
  df_parole_profile_age <-
    reactive({filter(people_released_to_parole_age,
                     state == input$state)})

  # create reactable table using df_parole_profile_age()
  output$table_parole_profile_age <- renderReactable({
    reactable(df_parole_profile_age(),
              style = hc_reactable_style,
              theme = hc_reactable_theme,
              defaultColDef = colDef(format = colFormat(separators = TRUE),
                                     align = "left"),
              compact = TRUE,
              fullWidth = FALSE,
              columns = list(
                state          = colDef(show = FALSE,
                                        name = "State"),
                agerlse        = colDef(show = TRUE,
                                        name = "Age",
                                        minWidth = 215),
                total_agerlse  = colDef(show = FALSE,
                                        name = "Total (Age)"),
                total_releases = colDef(show = FALSE,
                                        name = "Total (Releases)"),
                prop           = colDef(show = TRUE,
                                        name = "",
                                        align = "right",
                                        minWidth = 215,
                                        format = colFormat(percent = TRUE,
                                                           digits = 1))))
  })

  # get information on people on parole by age median depending on
  # state selection
  df_parole_profile_age_median <-
    reactive({filter(people_released_to_parole_age_median,
                     state == input$state)})

  # create reactable table using df_parole_profile_age()
  output$table_parole_profile_age_median <- renderReactable({
    reactable(df_parole_profile_age_median(),
              style = hc_reactable_style,
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
                       `border-color` = neutralBkgndLight)}},
              compact = TRUE,
              sortable = FALSE,
              fullWidth = FALSE,
              columns = list(
                state           = colDef(show = FALSE,
                                         name = "State"),
                data            = colDef(show = TRUE,
                                         name = "",
                                         minWidth = 215,
                                         style = list(fontWeight = "bold")),
                agerlse_median  = colDef(show = TRUE,
                                         name = "",
                                         align = "right",
                                         minWidth = 215)))
  })

  # get information on people on parole by education median depending on
  # state selection
  df_parole_profile_education_median <-
    reactive({filter(people_released_to_parole_education_median,
                     state == input$state)})

  # create reactable table using df_parole_profile_education()
  output$table_parole_profile_education_median <- renderReactable({
    reactable(df_parole_profile_education_median(),
              style = hc_reactable_style,
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
                       `border-color` = neutralBkgndLight)}},
              compact = TRUE,
              sortable = FALSE,
              fullWidth = FALSE,
              columns = list(
                state            = colDef(show = FALSE,
                                          name = "State"),
                data             = colDef(show = TRUE,
                                          name = "",
                                          minWidth = 215,
                                          style = list(fontWeight = "bold")),
                education_median = colDef(show = TRUE,
                                          name = "",
                                          align = "right",
                                          minWidth = 215)))
  })

  # Line chart showing the change in prison populations and
  # number of people released to parole by reporting year
  output$line_pop_released_to_parole <- renderHighchart({
    all_line_pop_released_to_parole[[input$state]] %>%
      highcharter::hc_add_dependency(name = "plugins/series-label.js") %>%
      highcharter::hc_add_dependency(name = "plugins/accessibility.js") %>%
      highcharter::hc_add_dependency(name = "plugins/exporting.js") %>%
      highcharter::hc_add_dependency(name = "plugins/export-data.js")
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

  # Pie chart showing Parole Eligibility in the Future
  output$donut_currently_eligible <- renderHighchart({
    all_donut_currently_eligible[[input$state]] %>%
      highcharter::hc_add_dependency(name = "plugins/series-label.js") %>%
      highcharter::hc_add_dependency(name = "plugins/accessibility.js") %>%
      highcharter::hc_add_dependency(name = "plugins/exporting.js") %>%
      highcharter::hc_add_dependency(name = "plugins/export-data.js")
  })

  # Pie chart showing Parole Eligibility in the Future
  output$donut_future_eligible <- renderHighchart({
    all_donut_future_eligible[[input$state]] %>%
      highcharter::hc_add_dependency(name = "plugins/series-label.js") %>%
      highcharter::hc_add_dependency(name = "plugins/accessibility.js") %>%
      highcharter::hc_add_dependency(name = "plugins/exporting.js") %>%
      highcharter::hc_add_dependency(name = "plugins/export-data.js")
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
  #               yearendpop    = colDef(show = FALSE,
  #                                      name = "Year End Population (2020)",
  #                                      minWidth = 95,
  #                                      style = list(position = "sticky",
  #                                                   borderRight = "1px solid #d3d3d3")),
  #               current_count = colDef(name = "Currently Eligible for Parole (N)",
  #                                      minWidth = 150),
  #               current_perc  = colDef(name = "Currently Eligible for Parole (%)",
  #                                      minWidth = 150,
  #                                      format = colFormat(percent = TRUE, digits = 1)),
  #               future_count  = colDef(show = FALSE,
  #                                      name = "Eligible for Parole in the Future (N)",
  #                                      minWidth = 150),
  #               future_perc   = colDef(show = FALSE,
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
  #               yearendpop    = colDef(show = FALSE,
  #                                      name = "Year End Population (2020)",
  #                                      minWidth = 95,
  #                                      style = list(position = "sticky",
  #                                                   borderRight = "1px solid #d3d3d3")),
  #               current_count = colDef(show = FALSE,
  #                                      name = "Currently Eligible for Parole (N)",
  #                                      minWidth = 150),
  #               current_perc  = colDef(show = FALSE,
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

  # Filter data depending on state for pie chart showing the percentage of
  # people eligible for release but not yet due to each offense type
  df_ped_offense_type <-
    reactive({filter(current_ped_2020_offenses,
                     state == input$state)})

  # Pie chart showing the percentage of people eligible for release but
  # not yet due to each offense type
  output$pie_parole_elgibility_offense <- renderHighchart({
      all_pie_parole_elgibility_offense[[input$state]] %>%
        highcharter::hc_add_dependency(name = "plugins/series-label.js") %>%
        highcharter::hc_add_dependency(name = "plugins/accessibility.js") %>%
        highcharter::hc_add_dependency(name = "plugins/exporting.js") %>%
        highcharter::hc_add_dependency(name = "plugins/export-data.js")
  })

  # Reactable table showing the number of people eligible for release
  # but not yet due to each offense type
  output$table_parole_elgibility_offense <- renderReactable({

    df1 <- df_ped_offense_type() %>%
      select(-c(state, yearendpop_ped, tooltip)) %>%
      arrange(-n)

    reactable(df1,
              style = hc_reactable_style,
              theme = hc_reactable_theme,
              defaultColDef = colDef(format = colFormat(separators = TRUE),
                                     align = "left"),
              compact = TRUE,
              fullWidth = FALSE,
              columns = list(
                chart_label   = colDef(show = FALSE),
                offgeneral    = colDef(name = "Most Serious Sentenced Offense",
                                       minWidth = 200),
                n = colDef(name = "Number of People",
                           minWidth = 100,
                           align = "right"),
                prop   = colDef(name = "Percentage of People Eligible for
                                Parole but not yet Released",
                                minWidth = 175,
                                align = "right",
                                format = colFormat(percent = TRUE,
                                                   digits = 1))))
  })


  ######################
  # Releases
  ######################

  # Pie chart showing the percentage of people released before, at, or after ped
  output$pie_released_at_ped <- renderHighchart({
    all_pie_released_at_ped [[input$state]] %>%
      highcharter::hc_add_dependency(name = "plugins/series-label.js") %>%
      highcharter::hc_add_dependency(name = "plugins/accessibility.js") %>%
      highcharter::hc_add_dependency(name = "plugins/exporting.js") %>%
      highcharter::hc_add_dependency(name = "plugins/export-data.js")
  })

  # Reactable tables showing the predicted probabilties of being released
  # within 1 year of parole eligbility
  df_pp_by_race <-
    reactive({filter(all_pp,
                     state == input$state)})




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
