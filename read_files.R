# Script to read OECD CRS bulk data files
# Load packages
library(here)
library(tidyverse)
library(janitor)

# Manually download zip files from the OECD to project sub folder named raw: https://stats.oecd.org/DownloadFiles.aspx?DatasetCode=CRS1

# A vector of all zipfiles in raw folder
v_zipfiles <- list.files(path = here("raw"), pattern = "*.zip", full.names = TRUE)

# Unzip each zipfile and save files in data folder
purrr::walk(v_zipfiles, ~ unzip(., exdir = here("data")))

# Read data with column type specifications and clean names
df <- read_delim("data/CRS 2021 data.txt", delim = "|", locale = locale(encoding = "UTF-16LE"),
                 col_types = readr::cols(
                   NumberRepayment = readr::col_character(),
                   Interest1 = readr::col_character(),
                   Interest2 = readr::col_character(),
                   Repaydate1 = readr::col_date(format = ""),
                   Repaydate2 = readr::col_date(format = ""),
                   USD_Interest = readr::col_double(),
                   USD_Outstanding = readr::col_double(),
                   CapitalExpend = readr::col_double(),
                   USD_IRTC = readr::col_double(),
                   USD_Export_Credit = readr::col_double()))

df <- clean_names(df)