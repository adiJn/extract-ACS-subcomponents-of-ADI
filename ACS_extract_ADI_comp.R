
# define code directory --------------------------------------------------------

# get the path to this file (master.R)
root <- rstudioapi::getSourceEditorContext()$path

# until the last path separator is the name of the root directory, shorten the 
# file path to get the root
while (basename(root) != "OneDrive - Northwestern University") {
  root <- dirname(root)
}

# define code directory 
cdir <- file.path(root, "code")

# packages, preferences, directories -------------------------------------------

# source the setup script
source(file.path(cdir, "ACS_extract_ADI_comp", "setup", "setup.R")) 
rdir <- file.path(rdir, "ACS")

# constants --------------------------------------------------------------------
KEY <- "f01e69284a6f915e3fe2bd1ed4bf1f6c5b9ebf53"

YEARS <- c(2015, 2020)

# ACS5 2020 variable codes

# % pop aged 25+ with < 9y of edu: DP02_0060P
# % pop aged 25+ with >= HS diploma: DP02_0067P
# % employed aged 16+ in white collar occupations: DP03_0027P + DP03_0029P
# median family income ($): DP03_0086
# income disparity: 
# no. of households <$10k income: DP03_0052,
# no. of households $50k+ income:  DP03_0057 + DP03_0058 + ...+ DP03_0061
# median home value ($): B25077_001
# median gross rent ($): B25064_001
# median monthly mortgage ($): B25105_001
# % owner-occ housing units: S2501_C04_001
# % civilian labor force aged 16+ unemployed: DP03_0005P
# % families below poverty level: S1702_C02_001
# % population below 150% of poverty threshold: S1701_C03_040
# % single parent households with children aged <18 years: DP02_0011P + DP02_0007P
# % housing units without motor vehicle: DP04_0058P
# % housing units without telephone: DP04_0075P
# % housing units without complete plumbing: 	DP04_0073P
# % housing units with crowding (>1 person/room): DP04_0078P + DP04_0079P

VARS_2020 <- c(pop_less_9y_edu = "DP02_0060P", # % pop aged 25+ with < 9y of education
               
               # % pop aged 25+ with >= HS diploma
               pop_HS_plus = "DP02_0067P",
               
               # % employed aged 16+ in white collar occupations 
               wt_collar_1 = "DP03_0027P", 
               wt_collar_2 = "DP03_0029P",
               
               # median family income 
               med_fam_inc = "DP03_0086", 
               
               # income disparity
               hh_less_10k = "DP03_0052", 
               hh_50_plus1 = "DP03_0057", 
               hh_50_plus2 = "DP03_0058", 
               hh_50_plus3 = "DP03_0059", 
               hh_50_plus4 = "DP03_0060",
               hh_50_plus5 = "DP03_0061", 
               
               # median home value
               med_hom_val = "B25077_001", 
               
               # median gross rent
               med_gross_rent = "B25064_001",
               
               # median monthly mortgage
               med_house_cost = "B25105_001",
               
               # home ownership rate
               home_own_rate_num = "S2501_C03_001",
               home_own_rate_denom = "S2501_C01_001",
               
               # unemployment rate
               unemp_rate = "DP03_0005P", 
               
               # % families below poverty level
               fam_poverty = "S1702_C02_001", 
               
               # % pop below 150% of threshold
               pop_below_150_poverty_est = "S1701_C01_040",
               pop_est_pov_status = "S1701_C01_001",
               
               # % single parent households with children aged <18 years
               sin_parent_child_min1 = "DP02_0007P", 
               sin_parent_child_min2 = "DP02_0011P", 
               
               # % housing units without motor vehicle
               houses_no_vehicle = "DP04_0058P", 
               
               # % housing units without telephone
               houses_no_tele = "DP04_0075P", 
               
               # % housing units without complete plumbing
               houses_no_plumbing =  "DP04_0073P", 
               
               # % housing units with crowding
               houses_with_crowding1 = "DP04_0078P",
               houses_with_crowding2 = "DP04_0079P") 


# ACS5 2015 variable codes

# % pop aged 25+ with < 9y of edu: DP02_0059P
# % pop aged 25+ with >= HS diploma: DP02_0066P
# % employed aged 16+ in white collar occupations: DP03_0027P + DP03_0029P
# median family income ($): DP03_0086
# income disparity: 
# no. of households <$10k income: DP03_0052,
# no. of households $50k+ income:  DP03_0057 + DP03_0058 + ...+ DP03_0061
# median home value ($): B25077_001
# median gross rent ($): B25064_001
# median monthly mortgage ($): B25105_001
# % owner-occ housing units: S2501_C02_001/S2501_C01_001 *100
# % civilian labor force aged 16+ unemployed: DP03_0005P
# % families below poverty level: S1702_C02_001
# % population below 150% of poverty threshold: S1701_C01_040/S1701_C01_001 * 100
# % single parent households with children aged <18 years: DP02_0009P + DP02_0007P
# % housing units without motor vehicle: DP04_0058P
# % housing units without telephone: DP04_0075P
# % housing units without complete plumbing: 	DP04_0073P
# % housing units with crowding (>1 person/room): DP04_0078P + DP04_0079P

VARS_2015 <- c(pop_less_9y_edu = "DP02_0059P", # % pop aged 25+ with < 9y of education
               
               # % pop aged 25+ with >= HS diploma
               pop_HS_plus = "DP02_0066P",
               
               # % employed aged 16+ in white collar occupations 
               wt_collar_1 = "DP03_0027P", 
               wt_collar_2 = "DP03_0029P",
               
               # median family income 
               med_fam_inc = "DP03_0086", 
               
               # income disparity
               hh_less_10k = "DP03_0052", 
               hh_50_plus1 = "DP03_0057", 
               hh_50_plus2 = "DP03_0058", 
               hh_50_plus3 = "DP03_0059", 
               hh_50_plus4 = "DP03_0060",
               hh_50_plus5 = "DP03_0061", 
               
               # median home value
               med_hom_val = "B25077_001", 
               
               # median gross rent
               med_gross_rent = "B25064_001",
               
               # median monthly mortgage
               med_house_cost = "B25105_001",
               
               # home ownership rate
               home_own_rate_num = "S2501_C02_001",
               home_own_rate_denom = "S2501_C01_001",
               
               # unemployment rate
               unemp_rate = "DP03_0005P", 
               
               # % families below poverty level
               fam_poverty = "S1702_C02_001", 
               
               # % pop below 150% of threshold
               pop_below_150_poverty_est = "S1701_C01_040",
               pop_est_pov_status = "S1701_C01_001",
               
               # % single parent households with children aged <18 years
               sin_parent_child_min1 = "DP02_0007P", 
               sin_parent_child_min2 = "DP02_0009P", 
               
               # % housing units without motor vehicle
               houses_no_vehicle = "DP04_0058P", 
               
               # % housing units without telephone
               houses_no_tele = "DP04_0075P", 
               
               # % housing units without complete plumbing
               houses_no_plumbing =  "DP04_0073P", 
               
               # % housing units with crowding
               houses_with_crowding1 = "DP04_0078P",
               houses_with_crowding2 = "DP04_0079P")

# source functions
source(file.path(cdir, "ACS_extract_ADI_comp/functions/data_pull.R"))
source(file.path(cdir, "ACS_extract_ADI_comp/functions/clean_ACS_2020.R"))
source(file.path(cdir, "ACS_extract_ADI_comp/functions/clean_ACS_2015.R"))
source(file.path(cdir, "ACS_extract_ADI_comp/functions/merge_ACS_2020_2015.R"))
source(file.path(cdir, "ACS_extract_ADI_comp/functions/zcta_to_zip.R"))
source(file.path(cdir, "ACS_extract_ADI_comp/functions/NA_range_checks.R"))

# pull, clean data -------------------------------------------------------------
census_api_key(KEY)

# pull data, clean data
tic('API Data pull, clean') # 145 sec to run
data_2020 <- data_pull(2020, VARS_2020)

# pivot census data wide 
data2020 <-  data_2020 %>% 
  # rename GEOID to zcta
  rename(zcta = GEOID) %>%
  # pivot from long to wide
  pivot_wider(id_cols = zcta, 
              names_from = variable,
              values_from = estimate) %>% zcta_to_zip()

# clean data and bring to zip level
data_2020 <- data_2020 %>% clean_ACS_2020 %>% zcta_to_zip()

# 2015 ------------
data_2015 <- data_pull(2015, VARS_2015) 
# pivot census data wide 
data2015 <-  data_2015 %>% 
  # rename GEOID to zcta
  rename(zcta = GEOID) %>%
  # pivot from long to wide
  pivot_wider(id_cols = zcta, 
              names_from = variable,
              values_from = estimate) %>% zcta_to_zip()

# clean data and bring to zip level
data_2015 <- data_2015 %>% clean_ACS_2015 %>% zcta_to_zip()
toc()

# clean prepared datasets ------------------------------------------------------

# replace NaNs with NAs
data_2015 <- data_2015 %>%
  mutate(across(everything(), ~ifelse(is.nan(.), NA, .)))

data_2020 <- data_2020 %>%
  mutate(across(everything(), ~ifelse(is.nan(.), NA, .)))

# basic checks on datasets -----------------------------------------------------

dflist <- list(data2020, data2015, data_2020, data_2015)
NA_range_checks(dflist)
rm(dflist)

# save data --------------------------------------------------------------------

# save raw data for future use
write_parquet(data2020, file.path(rdir, "ACS_2020_ADI_comp_raw.parquet"))
write_parquet(data2015, file.path(rdir, "ACS_2015_ADI_comp_raw.parquet"))

write_csv(data2020, file.path(rdir, "ACS_2020_ADI_comp_raw.csv"))
write_csv(data2015, file.path(rdir, "ACS_2015_ADI_comp_raw.csv"))

write_dta(data2020, file.path(rdir, "ACS_2020_ADI_comp_raw.dta"))
write_dta(data2015, file.path(rdir, "ACS_2015_ADI_comp_raw.dta"))
# remove raw data
rm(data2020, data2015)

# export cleaned data
write_parquet(data_2020, file.path(rdir, "ACS_2020_ADI_comp.parquet"))
write_parquet(data_2015, file.path(rdir, "ACS_2015_ADI_comp.parquet"))

write_csv(data_2020, file.path(rdir, "ACS_2020_ADI_comp.csv"))
write_csv(data_2015, file.path(rdir, "ACS_2015_ADI_comp.csv"))

write_dta(data_2020, file.path(rdir, "ACS_2020_ADI_comp.dta"))
write_dta(data_2015, file.path(rdir, "ACS_2015_ADI_comp.dta"))

# understand single parent in household columns for 2020 data ------------------

if(F){
# Female and male householder, no spouse/partner present!!With children of 
# the householder under 18 year, test for 2020 data finds all missing

test_single_parent <- get_acs(geography = "zcta", # census block group-level data
                              variables = c("DP02_0011P",
                                            "DP02_0007P"), # Total population
                              year = 2015,
                              survey = "acs5",
                              show_call = T)

# try actual estimates instead of percent--they are missing too
test_single_parent_est <- get_acs(geography = "zcta", # census block group-level data
                              variables = c("DP02_0011",
                                            "DP02_0007"), # Total population
                              year = 2020,
                              survey = "acs5",
                              show_call = T)

# pivot wider for ease of viewing
test_single_parent_est <- test_single_parent_est %>% pivot_wider(id_cols = GEOID, 
                                                   names_from = variable,
                                                   values_from = estimate) 
rm(test_single_parent, test_single_parent_est)
}

# merge dataset ----------------------------------------------------------------

export_data <- merge_ACS_2020_2015(data_2020, data_2015) %>%
  # replace NaNs arising from mean of NA values with NAs
  mutate(across(everything(), ~ifelse(is.nan(.), NA, .)))

# basic checks on data ---------------------------------------------------------

#"percentage of NAs in each column")
sapply(export_data, function(x) { mean(is.na(x))*100 %>% round(2) })

#"range for each numeric column, non-finite elements not omitted")
sapply(export_data %>% select_if(is.numeric), 
       function(x) { range(x, na.rm = T, finite = F) })

#"range for each numeric column, non-finite elements omitted")
sapply(export_data %>% select_if(is.numeric), 
       function(x) { range(x, na.rm = T, finite = T) })

# export -----------------------------------------------------------------------

# dta, csv, and parquet file
write_dta(export_data, file.path(ddir, "ACS_ADI", "ADI_comp_2020_2015.dta"))
write_csv(export_data, file.path(ddir, "ACS_ADI", "ADI_comp_2020_2015.csv"))
write_parquet(export_data, file.path(ddir, "ACS_ADI", "ADI_comp_2020_2015.parquet"))
  