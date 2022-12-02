# Script to read OECD bulk data files

# Load packages
library(here)
library(tidyverse)
library(janitor)

# Download zip file from OECD : https://stats.oecd.org/DownloadFiles.aspx?DatasetCode=CRS1 and save file in the project sub folder raw



# Unzip files from raw folder

#v_zipfiles <- list.files(path = here("raw"), pattern = "*.zip", full.names = TRUE)

unzip(here("raw", "CRS 2020 data.zip"))

df <- read_delim("CRS 2020 data.txt",
                 col_types = readr::cols(
                   NumberRepayment = readr::col_character(),
                   Interest1 = readr::col_character(),
                   Interest2 = readr::col_character(),
                   Repaydate1 = readr::col_date(format = ""),
                   Repaydate2 = readr::col_date(format = ""),
                   USD_Interest = readr::col_double(),
                   USD_Outstanding = readr::col_double(),
                   CapitalExpend = readr::col_double())
                 )


glimpse(df)


df <- clean_names(df)