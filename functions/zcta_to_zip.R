# use the UDS ZCTA-ZIP crosswalk to bring cleaned ACS5 data from ZCTA to zipcode level

zcta_to_zip <- function(ACS_data){
  
  # read-in zcta-zip crosswalk
  zcta_zip_crosswalk <- read_excel(file.path(rdir, 
                                             "ZIPCodetoZCTACrosswalk2021UDS.xlsx")) %>%
    rename(zcta = ZCTA,zipcode = ZIP_CODE) %>%
    select(zcta, zipcode)
  
  # return ACS data after adding zipcode to it
  ACS_data %>% left_join(zcta_zip_crosswalk,
                         by = "zcta") %>%
    # bring zipcode to front
    select(zipcode, everything())
  
  }