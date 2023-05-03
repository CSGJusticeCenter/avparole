

library(dplyr)

# prepare data for analysis
# ncrp_releases_clean created in releases_ncrp.R
ncrp_pp_model_data <- ncrp_releases_clean %>%
  # filter to 2020 report year
  # remove releases that were classified as "other"
  filter(rptyear == 2020) %>%
  filter(state == x) %>%
  filter(reltype != "Other release (including death, transfer, AWOL, escape)") %>%
  filter(admtype != "Other admission (including unsentenced, transfer, AWOL/escapee return)") %>%
  filter(race != "Other race(s), non-Hispanic") %>%
  # create binary variable for being released within 1 year of parole eligibility
  mutate(release_within_1yr_ped =
           case_when(time_between_release_ped <= 1 ~ 1,
                     time_between_release_ped > 1  ~ 0)) %>%

  # remove other offenses
  filter(offgeneral != "Other/unspecified") %>%

  # factor variables
  mutate(release_within_1yr_ped = factor(release_within_1yr_ped),
         sex        = factor(sex),
         race       = factor(race),
         admtype    = factor(admtype),
         offgeneral = factor(offgeneral, ordered = TRUE,
                             levels = c("Other/unspecified",
                                        "Public order",
                                        "Drug",
                                        "Property",
                                        "Violent")),
         sentlgth   = factor(sentlgth, ordered = TRUE,
                             levels = c("< 1 year",
                                        "1-1.9 years",
                                        "2-4.9 years",
                                        "5-9.9 years",
                                        "10-24.9 years",
                                        ">=25 years")))  %>%
  # set reference levels
  mutate(sex     = relevel(sex,     ref = "Male"),
         race    = relevel(race,    ref = "White, non-Hispanic"),
         admtype= relevel(admtype, ref = "New court commitment")) %>%

  # create id
  mutate(release_id = row_number()) %>%

  # remove missing data and remove offenses in the general category.
  filter(!is.na(release_within_1yr_ped) &
           !is.na(sex) &
           !is.na(race) &
           !is.na(admtype) &
           !is.na(offgeneral) &
           !is.na(sentlgth)) %>%

  # select variables
  select(release_within_1yr_ped,
         sex,
         race,
         admtype,
         offgeneral,
         sentlgth) %>%

  droplevels()

# https://druedin.com/2016/01/16/predicted-probabilities-in-r/
# save the losgitic regression formula
fmla <- release_within_1yr_ped ~ sex + race + admtype + offgeneral + sentlgth

# run logistic regression
glm_model <- glm(fmla, family = "binomial", data = ncrp_pp_model_data)
summary(glm_model)

# calculate the predicted probabilities for each combination of predictor variables
new_data <- expand.grid(sex        = levels(ncrp_pp_model_data$sex),
                        race       = levels(ncrp_pp_model_data$race),
                        admtype    = levels(ncrp_pp_model_data$admtype),
                        offgeneral = levels(ncrp_pp_model_data$offgeneral),
                        sentlgth   = levels(ncrp_pp_model_data$sentlgth))
new_data$release_within_1yr_ped <- predict(glm_model,
                                           newdata = new_data,
                                           type = "response")

# save the predicted probabilities for each race
pp_by_race <- aggregate(release_within_1yr_ped ~ race,
                        data = new_data, FUN = mean)

# save the predicted probabilities for each sex
pp_by_sex <- aggregate(release_within_1yr_ped ~ sex,
                       data = new_data, FUN = mean)

# save the predicted probabilities for each admtype
pp_by_admtype <- aggregate(release_within_1yr_ped ~ admtype,
                           data = new_data, FUN = mean)

# save the predicted probabilities for each offgeneral
pp_by_offgeneral <- aggregate(release_within_1yr_ped ~ offgeneral,
                              data = new_data, FUN = mean)

# save the predicted probabilities for each sentlgth
pp_by_sentlgth <- aggregate(release_within_1yr_ped ~ sentlgth,
                            data = new_data, FUN = mean)





################################ TO DO
# write a loop and function to find predictive probabilties for each state








##########
# Save data
##########

theseFOLDERS <- c( "sharepoint" = paste0(sp_data_path, "/data/analysis"), "app" = "app/data")

for (folder in theseFOLDERS){

  save(all_pp_by_race,       file=file.path(folder, "all_pp_by_race.rds"))
  save(all_pp_by_sex,        file=file.path(folder, "all_pp_by_sex.rds"))
  save(all_pp_by_admtype,    file=file.path(folder, "all_pp_by_admtype.rds"))
  save(all_pp_by_offgeneral, file=file.path(folder, "all_pp_by_offgeneral.rds"))
  save(all_pp_by_sentlgth,   file=file.path(folder, "all_pp_by_sentlgth.rds"))

}
