
# set options so that y axis has comma separator
hcoptslang <- getOption("highcharter.lang")
hcoptslang$thousandsSep <- ","
options(highcharter.lang = hcoptslang)

# get list of states
states <- unique(current_ped_2020_offenses$state)





########################################

# Most serious sentenced offense for people eligible for parole but not yet released

########################################

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

  save(all_pie_parole_elgibility_offense, file=file.path(folder, "all_pie_parole_elgibility_offense.rds"))
  save(all_pie_released_at_ped,           file=file.path(folder, "all_pie_released_at_ped.rds"))

}
