# extract-ACS-subcomponents-of-ADI

The ADI is based on variables available in the American Community Survey. [This](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1447923/) paper details the methodology by which ADI is created. We pulled data on the variables comprising the ADI from ACS 2020 and ACS 2015 and created three zip-level datasets for values of each of the variables in that zipcode. Two datasets have 2015 and 2020 variables each, whereas one has the values of variables from the two years averaged. Run `ACS_extract_ADI_comp.R` to recreate the data. The following functions are called by this script:

Functions

1.  `data_pull.R`: function to pull given variables from ACS5 for given year.

2.  `clean_ACS_2020.R`: function specific to ACS5 2020 to create desired variables from the raw data.

3.  `clean_ACS_2015.R`: function specific to ACS5 2015 to create desired variables from the raw data.

4.  `zcta_to_zip.R`: use the UDS ZCTA-ZIP crosswalk to bring cleaned ACS5 data from ZCTA to zipcode level.

5.  `merge_ACS_2020_2015.R`: to create the dataset with 2020 and 2015 ACS5 variables averaged, use this function on the prepares 2020 and 2015 datasets to average values and create one dataset.

6.  `NA_range_checks.R:` exploratory function to understand missingness and range of measures in combined 2015 and 2020 data.

### ACS5 2020 variables: ACS variable codes

1.  \% pop aged 25+ with \< 9y of edu: DP02_0060P
2.  \% pop aged 25+ with \>= HS diploma: DP02_0067P
3.  \% employed aged 16+ in white collar occupations: DP03_0027P + DP03_0029P
4.  median family income (\$): DP03_0086
5.  income disparity: log (100 \* no. of households \<\$10k income/no. of households \$50k+ income)
    1.  no. of households \<\$10k income: DP03_0052,
    2.  no. of households \$50k+ income: DP03_0057 + DP03_0058 + ...+ DP03_0061
6.  Median Home value (\$): B25077_001
7.  Median gross rent (\$): B25064_001
8.  median monthly mortgage (\$): B25105_001
9.  \% owner-occ housing units: S2501_C03_001/S2501_C01_001 \*100
10. \% civilian labor force aged 16+ unemployed: DP03_0005P
11. \% families below poverty level: S1702_C02_001
12. \% population below 150% of poverty threshold: S1701_C01_040/S1701_C01_001 \* 100
13. \% single parent households with children aged \<18 years: DP02_0011P + DP02_0007P
14. \% housing units without motor vehicle: DP04_0058P
15. \% housing units without telephone: DP04_0075P
16. \% housing units without complete plumbing: DP04_0073P
17. \% housing units with crowding (\>1 person/room): DP04_0078P + DP04_0079P

### ACS5 2015 variables: ACS variable codes

1.  \% pop aged 25+ with \< 9y of edu: DP02_0059P
2.  \% pop aged 25+ with \>= HS diploma: DP02_0066P
3.  \% employed aged 16+ in white collar occupations: DP03_0027P + DP03_0029P
4.  median family income (\$): DP03_0086
5.  income disparity: log (100 \* no. of households \<\$10k income/no. of households \$50k+ income)
    1.  no. of households \<\$10k income: DP03_0052,
    2.  no. of households \$50k+ income: DP03_0057 + DP03_0058 + ...+ DP03_0061
6.  Median Home value (\$): B25077_001
7.  Median gross rent (\$): B25064_001
8.  median monthly mortgage (\$): B25105_001
9.  \% owner-occ housing units: S2501_C02_001/S2501_C01_001 \*100
10. \% civilian labor force aged 16+ unemployed: DP03_0005P
11. \% families below poverty level: S1702_C02_001
12. \% population below 150% of poverty threshold: S1701_C01_040/S1701_C01_001 \* 100
13. \% single parent households with children aged \<18 years: DP02_0009P + DP02_0007P
14. \% housing units without motor vehicle: DP04_0058P
15. \% housing units without telephone: DP04_0075P
16. \% housing units without complete plumbing: DP04_0073P
17. \% housing units with crowding (\>1 person/room): DP04_0078P + DP04_0079P
