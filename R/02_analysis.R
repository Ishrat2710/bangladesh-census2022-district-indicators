# Project GEET
# Bangladesh Census 2022 District-Level Indicators
# Basic analysis

# Load packages
library(readr)
library(dplyr)


# Load the final dataset
district_data <- read_csv(
  "data/census2022_district_indicators.csv",
  show_col_types = FALSE
)


# Inspect the dataset
print(dim(district_data))

print(district_data)

View(district_data)

getwd()

list.files()
list.files("R")
list.files("data")













