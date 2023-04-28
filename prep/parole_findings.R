

# clean data
term_records_clean <- term_records %>%
  mutate(
    state = str_sub(state, 6, -1))

# filter to people in Georgia
# terms with an admission date of 1989 or after
# excluded terms with an admission type other than a court commitment or probation revocation
# excluded terms missing a PED and 6% of terms where the PED is before the admission date
ga_term_data <- term_records_clean %>%
  filter(state == "Georgia") %>%
  filter(admityr >= 1989) %>%
  filter(admtype == "New court commitment" | admtype ==  "Parole return/revocation") %>%
  filter(!is.na(parelig_year) & parelig_year >= admityr)

# create variable to flag people who were eligible for release but not released
georgia  <- georgia %>%
  mutate(time_between_ped_release = releaseyr - parelig_year)
