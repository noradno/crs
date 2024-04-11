# Script to read OECD CRS bulk data files and save as rds and database file
# Load packages
library(here)
library(tidyverse)
library(janitor)

# Manually download zip files from the OECD to project sub folder named raw: https://stats.oecd.org/DownloadFiles.aspx?DatasetCode=CRS1

# A vector of all zipfiles in raw folder
v_zipfiles <- list.files(path = here("raw"), pattern = "*.zip", full.names = TRUE)

# Unzip each zipfile and save files in data folder
purrr::walk(v_zipfiles, ~ unzip(., exdir = here("data")))

# A vector of all txt files in data folder
v_txtfiles <- list.files(path = here("data"), pattern = "*.txt", full.names = TRUE)

# Function to read files in UTF-16 format
read_file_utf16 <- function(file_path) {
  read_delim(file_path, delim = "|", locale = locale(encoding = "UTF-16"),
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
               USD_Export_Credit = readr::col_double(),
               USD_Expert_Extended = readr::col_double(),
               USD_Adjustment = readr::col_double(),
               USD_Adjustment_Defl = readr::col_double(),
               PSIAddAssess = readr::col_character(),
               SDGfocus = readr::col_character(),
               Year = readr::col_character(),
               
               Biodiversity = readr::col_integer(),
               ClimateMitigation = readr::col_integer(),
               ClimateAdaptation = readr::col_integer(),
               Desertification = readr::col_integer(),
               Gender = readr::col_integer(),
               Environment = readr::col_integer(),
               DIG = readr::col_integer(),
               Trade = readr::col_integer(),
               RMNCH = readr::col_integer(),
               Nutrition = readr::col_integer(),
               Disability = readr::col_integer(),
               FTC = readr::col_double(),
               DRR = readr::col_integer(),
               PBA = readr::col_integer(),
               USD_Expert_Commitment = readr::col_double(),
               GrantEquiv = readr::col_double(),
               USD_GrantEquiv = readr::col_double()
             )
  )
}

# Function to read files in UTF-16 format
read_file_utf8 <- function(file_path) {
  read_delim(file_path, delim = "|", locale = locale(encoding = "UTF-8"),
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
                   USD_Export_Credit = readr::col_double(),
                   USD_Expert_Extended = readr::col_double(),
                   USD_Adjustment = readr::col_double(),
                   USD_Adjustment_Defl = readr::col_double(),
                   PSIAddAssess = readr::col_character(),
                   SDGfocus = readr::col_character(),
                   Year = readr::col_character(),
                   
                   Biodiversity = readr::col_integer(),
                   ClimateMitigation = readr::col_integer(),
                   ClimateAdaptation = readr::col_integer(),
                   Desertification = readr::col_integer(),
                   Gender = readr::col_integer(),
                   Environment = readr::col_integer(),
                   DIG = readr::col_integer(),
                   Trade = readr::col_integer(),
                   RMNCH = readr::col_integer(),
                   Nutrition = readr::col_integer(),
                   Disability = readr::col_integer(),
                   FTC = readr::col_double(),
                   DRR = readr::col_integer(),
                   PBA = readr::col_integer(),
                   USD_Expert_Commitment = readr::col_double(),
                   GrantEquiv = readr::col_double(),
                   USD_GrantEquiv = readr::col_double()
                   )
             )
}

# Read files in UTF-8 format -------------------------------------

df_1973_94 <- read_file_utf8(v_txtfiles[1]) # OK
df_1995_99 <- read_file_utf8(v_txtfiles[2]) # OK
df_2000_01 <- read_file_utf8(v_txtfiles[3]) # OK
df_2002_03 <- read_file_utf8(v_txtfiles[4]) # OK
df_2004_05 <- read_file_utf8(v_txtfiles[5]) # Problem Interest1
df_2006 <- read_file_utf8(v_txtfiles[6]) # OK
df_2007 <- read_file_utf8(v_txtfiles[7]) # OK
df_2008 <- read_file_utf8(v_txtfiles[8]) # OK
df_2009 <- read_file_utf8(v_txtfiles[9]) # Problem Interest1
df_2010 <- read_file_utf8(v_txtfiles[10]) # OK
df_2011 <- read_file_utf8(v_txtfiles[11]) # OK
df_2012 <- read_file_utf8(v_txtfiles[12]) # OK


df_2013 <- read_file_utf8(v_txtfiles[13]) # OK
df_2014 <- read_file_utf8(v_txtfiles[14]) # OK
df_2015 <- read_file_utf8(v_txtfiles[15]) # OK
df_2016 <- read_file_utf8(v_txtfiles[16]) # OK
df_2017 <- read_file_utf8(v_txtfiles[17]) # OK
df_2018 <- read_file_utf8(v_txtfiles[18]) # OK
df_2019 <- read_file_utf8(v_txtfiles[19]) # OK
df_2020 <- read_file_utf8(v_txtfiles[20]) # OK
df_2022 <- read_file_utf8(v_txtfiles[22]) # OK

# Read files in UTF-16 format -------------------------------------
df_2021 <- read_file_utf16(v_txtfiles[21]) # OK

write_csv(df_2021, "output/CRS 2021.csv")

rm(df_2021)

df_2021 <- read_csv("output/CRS 2021.csv", locale = locale(encoding = "UTF-8"),
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
             USD_Export_Credit = readr::col_double(),
             USD_Expert_Extended = readr::col_double(),
             USD_Adjustment = readr::col_double(),
             USD_Adjustment_Defl = readr::col_double(),
             PSIAddAssess = readr::col_character(),
             SDGfocus = readr::col_character(),
             
             Biodiversity = readr::col_integer(),
             ClimateMitigation = readr::col_integer(),
             ClimateAdaptation = readr::col_integer(),
             Desertification = readr::col_integer(),
             Gender = readr::col_integer(),
             Environment = readr::col_integer(),
             DIG = readr::col_integer(),
             Trade = readr::col_integer(),
             RMNCH = readr::col_integer(),
             Nutrition = readr::col_integer(),
             Disability = readr::col_integer(),
             FTC = readr::col_double(),
             DRR = readr::col_integer(),
             PBA = readr::col_integer(),
             USD_Expert_Commitment = readr::col_double(),
             GrantEquiv = readr::col_double(),
             USD_GrantEquiv = readr::col_double()
           )
)

# Fix the PDGG / DIG inconsistency column names in 2020 and 2021
df_2020 <- df_2020 |> 
  mutate(DIG = as.integer(PDGG)) |> 
  select(-PDGG)

df_2021 <- df_2021 |> 
  mutate(DIG = as.integer(PDGG)) |> 
  select(-PDGG)

# Fix 2021 year
df_2021 <- df_2021 |> 
  mutate(Year = stringr::str_trim(Year, "both"))


# Combine datasets to one -------------------------------------------------

# List of all dataframes
list_of_dfs <- list(df_1973_94,
                    df_1995_99,
                    df_2000_01,
                    df_2002_03,
                    df_2004_05,
                    df_2006,
                    df_2007,
                    df_2008,
                    df_2009,
                    df_2010,
                    df_2011,
                    df_2012,
                    df_2013,
                    df_2014,
                    df_2015,
                    df_2016,
                    df_2017,
                    df_2018,
                    df_2019,
                    df_2020,
                    df_2021,
                    df_2022)

# Combine all dataframes into one
crs <- bind_rows(list_of_dfs)

# Clean names
crs <- clean_names(crs)

# Year column as integer
crs <- crs |> 
  mutate(year = as.integer(year))

# Replace any problematic characters with a single-byte representation and then remove whitespace
crs <- crs |>
  mutate(across(where(is.character), ~iconv(., to = "UTF-8", sub = "byte"))) |>
  mutate(across(where(is.character), stringr::str_trim))

# Clean types
crs <- crs |> 
  mutate(
    donor_code = as.integer(donor_code),
    agency_code = as.integer(agency_code),
    initial_report = as.integer(initial_report),
    recipient_code = as.integer(recipient_code),
    region_code = as.integer(region_code),
    incomegroup_code = as.integer(incomegroup_code),
    flow_code = as.integer(flow_code),
    bi_multi = as.integer(bi_multi),
    category = as.integer(category),
    finance_t = as.integer(finance_t),
    currency_code = as.integer(currency_code),
    purpose_code = as.integer(purpose_code),
    sector_code = as.integer(sector_code),
    channel_code = as.integer(channel_code),
    parent_channel_code = as.integer(parent_channel_code),
    ld_cflag = as.integer(ld_cflag),
    ftc = as.integer(ftc),
    investment_project = as.integer(investment_project),
    assoc_finance = as.integer(assoc_finance),
    type_repayment = as.integer(type_repayment),
    ps_iflag = as.integer(ps_iflag),
    psi_add_type = as.integer(psi_add_type)
  )

# Save as rds and in database file ----------------------------------------

# Save in rds
saveRDS(crs, file = "output/crs.rds")

library(dbplyr)
library(duckdb)
library(DBI)
# Save in DuckDB
con <- DBI::dbConnect(duckdb::duckdb(), "C:/Users/u14339/UD Office 365 AD/Norad-Avd-Kunnskap - Statistikk og analyse/13. Annen data/CRS bulk files/crs_database.duckdb")

# Write tibble called crs_ten to database
dbWriteTable(con, "crs", crs)

# Check Tables in database
dbListTables(con)

# Properly closing the connection
dbDisconnect(con, shutdown=TRUE)
