#######################################
# Project: AV Parole
# File: parole_eligibility.R
# Authors: Mari Roberts
# Date last updated: March 13, 2023 (MAR)
# Description:
#    Parole eligibility tables and graphics for shiny app
#######################################

##########
# Parole Eligibility in 2020
##########

# filter to 2020 data
parole_elgibility_2020 <- yearendpop %>%
  filter(rptyear == 2020) %>%
  fnc_create_parelig_status() %>%
  mutate(
    state = str_sub(state, 6, -1),
    offgeneral = str_sub(offgeneral, 5, -1),
    race = str_sub(race, 5, -1)

  )

# get number and proportion of eligibility statuses
parole_eligibility_counts_2020 <- parole_elgibility_2020 %>%
  group_by(state) %>%
  count(parelig_status) %>%
  mutate(
    prop = n/sum(n)
    , yearendpop = sum(n)
  ) %>%
  ungroup()

# reformat for table viewing
parole_eligibility_table_2020 <- parole_eligibility_counts_2020 %>%
  pivot_longer(cols = c(n, prop), names_to = "type", values_to = "value") %>%
  mutate(name = case_when(
    type == "n"    ~ paste(parelig_status, "count")
    , type == "prop" ~ paste(parelig_status, "perc.")
  )) %>%
  select(state, yearendpop, name, value) %>%
  pivot_wider(names_from = name, values_from = value) %>%
  clean_names() %>%
  select(-c(missing_count, missing_perc))

parole_eligibility_missing_states_2020 <- paste(state.name[!state.name %in% parole_eligibility_table_2020$state], collapse = ", ") # Arizona, Michigan, New Jersey, New Mexico

# create reactable table
parole_eligibility_table_2020_reactable <-
  reactable(parole_eligibility_table_2020,
            style = list(fontFamily = "Graphik, sans-serif",
                         fontSize = "0.875rem"
            ),
            theme = reactableTheme(cellStyle = list(display = "flex", flexDirection = "column", justifyContent = "center")),
            defaultColDef = colDef(format = colFormat(separators = TRUE), align = "center"),
            compact = TRUE,
            fullWidth = FALSE,
            columns = list(
              state         = colDef(name = "State",
                                     align = "left",
                                     style = list(fontWeight = "bold"),
                                     minWidth = 200),

              yearendpop    = colDef(name = "Year End Population (2020)",
                                     minWidth = 95,
                                     style = list(position = "sticky", borderRight = "1px solid #d3d3d3")),

              # missing_count = colDef(name = "Missing Parole Eligibility Data in 2020 (N)",
              #                        minWidth = 95),
              # missing_perc  = colDef(name = "Missing Parole Eligibility Data in 2020 (%)",
              #                        minWidth = 95,
              #                        format = colFormat(percent = TRUE, digits = 1),
              #                        style = list(position = "sticky", borderRight = "1px solid #d3d3d3")),

              current_count = colDef(name = "Currently Eligible for Parole in 2020 (N)",
                                     minWidth = 95),
              current_perc  = colDef(name = "Currently Eligible for Parole in 2020 (%)",
                                     minWidth = 95,
                                     format = colFormat(percent = TRUE, digits = 1),
                                     style = list(position = "sticky", borderRight = "1px solid #d3d3d3")),

              future_count  = colDef(name = "Eligible for Parole in the Future in 2020 (N)",
                                     minWidth = 95),
              future_perc   = colDef(name = "Eligible for Parole in the Future in 2020 (%)",
                                     minWidth = 95,
                                     format = colFormat(percent = TRUE, digits = 1))
            ))




##########
# Offenses for those in prison but not released in 2020
##########

current_ped_2020_offenses <- parole_elgibility_2020 %>%
  filter(parelig_status == "Current") %>%
  filter(!is.na(offgeneral)) %>%
  group_by(state) %>%
  count(offgeneral) %>%
  mutate(
    prop = n/sum(n)
    , yearendpop_ped = sum(n)
  ) %>%
  ungroup() %>%
  mutate(tooltip = paste0("<b>", state, " - ", offgeneral, "</b><br>", paste(round(prop*100, 1), "%", sep = ""), "<br>"))

current_ped_2020_race <- parole_elgibility_2020 %>%
  filter(parelig_status == "Current") %>%
  filter(!is.na(race)) %>%
  group_by(state) %>%
  count(race) %>%
  mutate(
    prop = n/sum(n)
    , yearendpop_ped = sum(n)
  ) %>%
  ungroup() %>%
  mutate(tooltip = paste0("<b>", state, " - ", race, "</b><br>", paste(round(prop*100, 1), "%", sep = ""), "<br>"))



##########
# Save data
##########

theseFOLDERS <- c( "sharepoint" = paste0(sp_data_path, "/data/analysis"), "app" = "app/data")

for (folder in theseFOLDERS){

  save(parole_eligibility_table_2020,           file=file.path(folder, "parole_eligibility_table_2020.Rda"))
  save(parole_eligibility_table_2020_reactable, file=file.path(folder, "parole_eligibility_table_2020_reactable.Rda"))
  save(current_ped_2020_offenses,               file=file.path(folder, "current_ped_2020_offenses.Rda"))
  save(current_ped_2020_race,                   file=file.path(folder, "current_ped_2020_race.Rda"))

}
