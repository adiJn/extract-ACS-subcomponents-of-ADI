# conduct basic checks to understand missingness and range of values for each measure

NA_range_checks <- function(dflist){
print("percentage of NAs in each column")
lapply(dflist, function(dataset) {
  sapply(dataset, function(x) { mean(is.na(x))*100 %>% round(2) })
  })

print("range for each numeric column, non-finite elements not omitted")
lapply(dflist, function(dataset) {
  sapply(dataset %>% select_if(is.numeric), 
         function(x) { range(x, na.rm = T, finite = F) })
})

print("range for each numeric column, non-finite elements omitted")
lapply(dflist, function(dataset) {
  sapply(dataset %>% select_if(is.numeric), 
         function(x) { range(x, na.rm = T, finite = T) })
})
}