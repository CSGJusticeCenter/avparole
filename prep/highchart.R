#######################################
# Project: AV Parole
# File: highchart.R
# Authors: Mari Roberts
# Date last updated: May 3, 2023 (MAR)
# Description:
#    Pre-generate highchart graphics for shiny app
#######################################

# set options so that y axis has comma separator
hcoptslang <- getOption("highcharter.lang")
hcoptslang$thousandsSep <- ","
options(highcharter.lang = hcoptslang)





########################################

# Donuts at top of page showing currently and future PED percentages

########################################

# get list of states
states <- unique(parole_eligibility_table_2020$state)

all_donut_currently_eligible <- map(.x = states,  .f = function(x) {

  df1 <- parole_eligibility_table_2020 %>%
    filter(state == x) %>%
    select(state, current_perc) %>%
    mutate(rest = 1 - current_perc) %>%
    pivot_longer(cols      = c(current_perc:rest),
                 names_to  = "type",
                 values_to = "prop") %>%
    mutate(tooltip =
             case_when(type == "current_perc" ~
                         paste0("<b>", state, "</b><br>",
                                "Percentage of People Eligible for Release:<br>",
                                paste(round(prop*100, 0), "%</b>", sep = ""), "<br>"),
                       type == "rest" ~
                         paste0("<b>", state, "</b><br>",
                                "Percentage of People Not Eligible for Release:<br>",
                                paste(round(prop*100, 0), "%</b>", sep = ""), "<br>")))

  df2 <- df1 %>%
    filter(type == "current_perc") %>%
    mutate(chart_label = paste0(round(prop*100,0), "%"))

  highcharts <- fnc_donut_chart(df = df1,
                                df_pct = df2,
                                x_variable = "state",
                                y_variable = "prop",
                                point_format = "{point.chart_label}",
                                accessibility_text = "TBD.")
  return(highcharts)
})

all_donut_currently_eligible <- setNames(all_donut_currently_eligible, states)

all_donut_future_eligible <- map(.x = states,  .f = function(x) {

  df1 <- parole_eligibility_table_2020 %>%
    filter(state == x) %>%
    select(state, future_perc) %>%
    mutate(rest = 1 - future_perc) %>%
    pivot_longer(cols      = c(future_perc:rest),
                 names_to  = "type",
                 values_to = "prop") %>%
    mutate(tooltip =
             case_when(type == "future_perc" ~
                         paste0("<b>", state, "</b><br>",
                                "Percentage of People Eligible for Release:<br>",
                                paste(round(prop*100, 0), "%</b>", sep = ""), "<br>"),
                       type == "rest" ~
                         paste0("<b>", state, "</b><br>",
                                "Percentage of People Not Eligible for Release:<br>",
                                paste(round(prop*100, 0), "%</b>", sep = ""), "<br>")))

  df2 <- df1 %>%
    filter(type == "future_perc") %>%
    mutate(chart_label = paste0(round(prop*100,0), "%"))

  highcharts <- fnc_donut_chart(df = df1,
                                df_pct = df2,
                                x_variable = "state",
                                y_variable = "prop",
                                point_format = "{point.chart_label}",
                                accessibility_text = "TBD.")
  return(highcharts)
})

all_donut_future_eligible <- setNames(all_donut_future_eligible, states)


########################################

# Most serious sentenced offense for people eligible for parole but not yet released

########################################

# get list of states
states <- unique(current_ped_2020_offenses$state)

all_pie_parole_elgibility_offense <- map(.x = states,  .f = function(x) {
  df1 <- current_ped_2020_offenses %>% filter(state == x)
  highcharts <- fnc_pie_chart(df = df1,
                              x_variable = "offgeneral",
                              y_variable = "prop",
                              point_format = "{point.chart_label}",
                              accessibility_text = "TBD.")
  return(highcharts)
})

all_pie_parole_elgibility_offense <- setNames(all_pie_parole_elgibility_offense, states)





########################################

# Releases

# How many people are being released at first eligibility?
# How long after eligibility does release occur?
# How does release vary by the person's demographic and criminal history characteristics?
# What is the mean and median time between parole eligibility and release for those released after the PED, by maximum sentence length?

########################################

# Get list of states
states <- unique(released_at_ped$state)

# How many people are being released at first eligibility?
all_pie_released_at_ped <- map(.x = states,  .f = function(x) {
  df1 <- released_at_ped %>% filter(state == x)
  highcharts <- fnc_pie_chart(df = df1,
                              x_variable = "released_at_ped_status",
                              y_variable = "prop",
                              point_format = "{point.chart_label}",
                              accessibility_text = "TBD.")
  return(highcharts)
})

all_pie_released_at_ped <- setNames(all_pie_released_at_ped, states)














##########
# Save data
##########

theseFOLDERS <- c( "sharepoint" = paste0(sp_data_path, "/data/analysis"), "app" = "app/data")

for (folder in theseFOLDERS){

  save(all_donut_currently_eligible,      file=file.path(folder, "all_donut_currently_eligible.rds"))
  save(all_donut_future_eligible,         file=file.path(folder, "all_donut_future_eligible.rds"))

  save(all_pie_parole_elgibility_offense, file=file.path(folder, "all_pie_parole_elgibility_offense.rds"))
  save(all_pie_released_at_ped,           file=file.path(folder, "all_pie_released_at_ped.rds"))

}
