# average the 2020 and 2015 ACS5 variables used in ADI to create one dataset

merge_ACS_2020_2015 <- function(data_2020, data_2015){
  
  # append datasets
  rbind(data_2020, data_2015) %>%
    
    # bring to zcta level
    group_by(zcta) %>% 
    
    # for all variables except zcta and zipcode, calculate mean of 2015 and 2020 estimates
    summarize(across(contains("_"),
                     # calculate mean and remove NAs when doing so
                     ~ mean(.x, na.rm = T))) %>%
    ungroup()
  
}