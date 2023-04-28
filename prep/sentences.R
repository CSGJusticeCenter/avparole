

sentencing <- population %>%

  # create order for sentence length and time served length
  # for example, <1 is 1 and 1-1.9 is 2, and so on
  mutate(
    sentlgth_order = case_when(
      sentlgth == "< 1 year"      ~ 1,
      sentlgth == "1-1.9 years"   ~ 2,
      sentlgth == "2-4.9 years"   ~ 3,
      sentlgth == "5-9.9 years"   ~ 4,
      sentlgth == "10-24.9 years" ~ 5,
      sentlgth == ">=25 years"    ~ 6,
      sentlgth == "Life, LWOP, Life plus additional years, Death" ~ 7,
      TRUE ~ NA),
    timesrvd_rel_order = case_when(
      timesrvd_rel == "< 1 year"      ~ 1,
      timesrvd_rel == "1-1.9 years"   ~ 2,
      timesrvd_rel == "2-4.9 years"   ~ 3,
      timesrvd_rel == "5-9.9 years"   ~ 4,
      timesrvd_rel == ">=10 years"    ~ 5,
      TRUE ~ NA)) %>%

  # determine differences between time served and sentenced length
  mutate(
    timesrvd_rel_vs_sentlgth = case_when(
      is.na(timesrvd_rel_order) | is.na(sentlgth_order) ~ NA,
      timesrvd_rel_order == sentlgth_order ~ "Full Sentence Length Served",
      timesrvd_rel_order > sentlgth_order  ~ "More than Sentence Length Served",
      timesrvd_rel_order < sentlgth_order  ~ "Less than Sentence Length Served"))

# timesrvd_rel_vs_sentlgth <- sentencing %>%
#   filter(rptyear == 2020) %>%
#   filter(!is.na(timesrvd_rel_vs_sentlgth) & !is.na(reltype)) %>%
#   group_by(state, timesrvd_rel_vs_sentlgth, reltype) %>%
#   summarise(total = n())

temp <- sentencing %>%
  filter(rptyear == 2020) %>%

