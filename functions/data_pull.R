# function to pull given variables from ACS5 for given year

data_pull <- function(year, vars){
  get_acs(geography = "zcta", # 5-digit ZIP Code Tabulation Area (ZCTA)
          variables = vars, # Total population
          year = year,
          survey = "acs5",
          show_call = T) %>%
    mutate(year = year)
}