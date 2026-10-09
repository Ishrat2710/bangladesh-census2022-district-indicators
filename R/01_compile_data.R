
# Project GEET
# Bangladesh Census 2022 District-Level Indicators
# Data compilation and cleaning


# Load packages
library(readr)
library(dplyr)
library(stringr)


# Import data
literacy <- read_csv(
  "data/p14_literacy.csv",
  show_col_types = FALSE
)

sex_ratio <- read_csv(
  "data/p11_sex_ratio.csv",
  show_col_types = FALSE
)

electricity <- read_csv(
  "data/hh12_electricity.csv",
  show_col_types = FALSE
)


# Clean district names
clean_district <- function(x) {
  x |>
    str_squish() |>
    str_replace_all("’", "'") |>
    str_to_title()
}

literacy <- literacy |>
  mutate(district = clean_district(district))

sex_ratio <- sex_ratio |>
  mutate(district = clean_district(district))

electricity <- electricity |>
  mutate(district = clean_district(district))


# Check number of districts
nrow(literacy)
nrow(sex_ratio)
nrow(electricity)

length(unique(literacy$district))
length(unique(sex_ratio$district))
length(unique(electricity$district))


# Check whether district names match
setdiff(literacy$district, sex_ratio$district)
setdiff(sex_ratio$district, literacy$district)

setdiff(literacy$district, electricity$district)
setdiff(electricity$district, literacy$district)


# Merge datasets
district_data <- literacy |>
  full_join(sex_ratio, by = "district") |>
  full_join(electricity, by = "district") |>
  arrange(district)


# Check merged dataset
print(dim(district_data))
colSums(is.na(district_data))

anti_join(literacy, sex_ratio, by = "district")
anti_join(literacy, electricity, by = "district")


# Keep final variables
district_data <- district_data |>
  select(
    district,
    literacy_rate_7plus,
    sex_ratio,
    electricity_coverage
  )


# Export final dataset
write_csv(
  district_data,
  "data/census2022_district_indicators.csv"
)





