# function specific to ACS5 2020 to create desired variables from the raw data

clean_ACS_2020 <- function(data){
  
  data %>% 
    # rename GEOID to zcta
    rename(zcta = GEOID) %>%
    
    # pivot from long to wide
    pivot_wider(id_cols = zcta, 
               names_from = variable,
               values_from = estimate) %>% 
    
    # create % employed aged 16+ in white collar occupations variable
    mutate(wt_collar_16_plus = wt_collar_1 + wt_collar_2) %>%
    
    # create income disparity variable
    mutate(inc_disparity = log( 100 * (hh_less_10k/(hh_50_plus1+hh_50_plus2+ hh_50_plus3+hh_50_plus4+hh_50_plus5)) )) %>%
    
    # % home ownership rate
    mutate(home_own_rate = (home_own_rate_num/home_own_rate_denom)*100) %>%
    
    # % single parent households with children aged <18 years
    mutate(sin_parent_child_min = sin_parent_child_min2 + sin_parent_child_min1) %>%
    
    # % housing units without complete plumbing
    mutate(log_houses_no_plumbing = log(houses_no_plumbing)) %>%
    
    # % pop below 150% of threshold
    mutate(pop_below_150_poverty = (pop_below_150_poverty_est/pop_est_pov_status)*100) %>%
    
    # % housing units with crowding
    mutate(houses_with_crowding = houses_with_crowding1 + houses_with_crowding2) %>%
    
    # cleanup
    select(-c(wt_collar_1, wt_collar_2,
              hh_less_10k, hh_50_plus1, hh_50_plus2, hh_50_plus3, hh_50_plus4, hh_50_plus5,
              sin_parent_child_min2, sin_parent_child_min1,
              houses_no_plumbing,
              home_own_rate_num, home_own_rate_denom,
              houses_with_crowding1, houses_with_crowding2,
              pop_est_pov_status, pop_below_150_poverty_est)) 
  
}