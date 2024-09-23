# function to pull given variables from ACS5 for given year

data_pull <- function(year, vars){
  get_acs(geography = "zcta", # census block group-level data
          variables = vars, # Total population
          year = year,
          survey = "acs5",
          show_call = T) %>%
    mutate(year = year)
}