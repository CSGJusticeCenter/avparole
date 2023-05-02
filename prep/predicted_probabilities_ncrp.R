
source("prep/releases_ncrp.R")

library(dplyr)

# prepare data for analysis
ncrp_pp_model_data <- ncrp_releases_clean %>%
  # filter to 2020 report year
  # remove releases that were classified as "other"
  filter(rptyear == 2020) %>%
  # filter(state == "Georgia") %>%
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
fmla <- release_within_1yr_ped ~ race

# run logistic regression
glm_model <- glm(fmla, family = "binomial", data = ncrp_pp_model_data)
summary(glm_model)

# create new data for predictions
newdata <- with(ncrp_pp_model_data,
                data.frame(race = "White, non-Hispanic"))

# calculate predictions
predict(glm_model, newdata, type="response")

