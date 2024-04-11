library(tidyverse)
library(noradstats)
library(countrycode)
library(gt)

df_remote <- read_crs_database()


df_selected <- df_remote |> 
  filter(recipient_name %in% c("Yemen", "Serbia", "States Ex-Yugoslavia unspecified")) |> 
  collect()

table_aid <- df_selected |> 
  group_by(recipient_name, year) |> 
  summarise(aid = sum(usd_disbursement, na.rm = TRUE)) |> 
  ungroup()

table_aid <- table_aid |> 
gt() |> 
  tab_header(
    title = "Aid by Country and Year",
    subtitle = "Data for Yemen, Serbia and States Ex-Yugoslavia unspecified"
  )

gtsave(table_aid, "table_aid.html")

df_selected

glimpse(df_selected)

df <- df_remote |> 
  select(recipient_code, recipient_name) |> 
  collect()

df_countries <- df |> 
  # filter(!stringr::str_detect(recipient_name, "Regional|regional|Multilateral|Global|Administration|Bilateral, unspecified")) |> 
  unique()

# Add ISO3 codes
df_codes <- readxl::read_excel("DevFi_Classification.xlsx")
df_codes <- janitor::clean_names(df_codes)

# OBS: I CRS-filene finnes kode 9998 Bilateral, unspecified. Men det er ingen kode 998 Developing countries unspecified.
# OBS: I Devfi_clasification er det ingen 237 East African Community, som finnes i CRS-filene

df_countries <- left_join(df_countries, df_codes, by = "recipient_code")


# Konfliktdata
ged_raw <- readRDS("C:/Users/u14339/UD Office 365 AD/Norad-Avd-Kunnskap - Statistikk og analyse/11. Analyseprosjekter/Faste arrangementer/Tall som teller/2024/ucdp/GEDEvent_v23_1.rds.")

glimpse(ged_raw)

ged_countries <- ged_raw |> 
  select(country_id, country) |> 
  unique()

table_conflict <- ged_raw |> 
  filter(country %in% c("Yemen (North Yemen)", "Serbia (Yugoslavia)")) |> 
  group_by(country, year) |> 
  summarise(fatalities = sum(best)) |> 
  ungroup()

table_conflict <- table_conflict |> 
  gt() |> 
  tab_header(
    title = "Conflict Fatalities by Country and Year",
    subtitle = "Data for Yemen (North Yemen) and Serbia (Yugoslavia)"
  )

gtsave(table_conflict, "table_conflict.html")

ged_countries <- ged_countries |> 
  mutate(iso3 = countrycode(country_id, origin = "gwn", destination = "iso3c"))

# Jeg har lagt til ISO3-landkoder to datasett: UCDP konfliktdata og CRS internasjonal bistandsdata. Hensikten er å koble dem sammen per land.
# To land i UCDP konfliktdata har ingen ordinær landkode: "Yemen (North Yemen)" and "Serbia (Yugoslavia)".
# I CRS internasjonal bistandsdata er det to land som heter "Yemen", "Serbia" og "States Ex-Yugoslavia unspecified"
# Vi må avklare hva vi gjør her.
# Info: Til slutt i dette dokumentet er en oversikt over land i UCDP konfliktdata: https://ucdp.uu.se/downloads/ucdpprio/ucdp-prio-acd-231.pdf


# Norsk
df_nor <- noradstats::read_aiddata()
df_nor <- janitor::clean_names(df_nor)
df_nor <- df_nor |> 
  mutate(recipient_country_crs = case_match(
    recipient_country,
    "Israel" ~ 546,
    "Saudi Arabia" ~ 566,
    "Slovenia" ~ 61,
    "Kuwait" ~ 552,
    "Bahrain" ~ 530,
    "Cyprus" ~ 30,
    "Korea, Republic of" ~ 742,
    "Malta" ~ 45,
    "Singapore" ~ 761,
    "Qatar" ~ 561,
    "United Arab Emirates" ~ 576,
    .default = recipient_country_crs
  ))

# Hva heter de manglende landkodene i CRS da?

df_nor <- df_nor |> 
  select(recipient_country_crs, recipient_country) |> 
  unique()

df_nor <- left_join(df_nor, df_codes, by = c("recipient_country_crs" = "recipient_code"))

ged_countries$iso3
df_nor <- left_join(df_nor, ged_countries, by = c("iso3" = "iso3"))


