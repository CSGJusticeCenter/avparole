

# Who is being released at first eligibility?
#   • How long after eligibility does release occur?
#   • How does release vary by the person’s demographic and criminal history characteristics?
#   • How many people are currently eligible for release but still in  prison? What percentage of the prison population is this?

# clean data
term_records_clean <- term_records %>%
  mutate(
    state = str_sub(state, 6, -1)
  )

# filter to people released in 2020
released_2020 <- term_records_clean %>%
  filter(releaseyr >= 2020)

