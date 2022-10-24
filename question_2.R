library(tidyverse)
library(sf)
library(spData)

setwd("~/Desktop/data_skills_2_r_hw2_Elia")

# 1.
## choropleth 1: Vaccination Series Completion Status in Chicago

vaxx <- read.csv("COVID-19_Vaccinations_by_ZIP_Code.csv")
vaxx_completed_per <- vaxx %>%
  filter(Date == "11/04/2021") %>%
  filter( !is.na(Vaccine.Series.Completed....Percent.Population), 
          Vaccine.Series.Completed....Percent.Population != 0) %>%
  mutate(complete_per = Vaccine.Series.Completed....Percent.Population * 100) %>%
  select(Zip.Code, complete_per)
  
path <- "~/Desktop/data_skills_2_r_hw2_Elia/Boundaries - ZIP Codes"
chicago_shape <- st_read(file.path(path,"geo_export_4431f834-b453-4cdc-a7d8-8fe7c1c612b3.shp"))

chicago_vaxx <- inner_join(vaxx_completed_per , chicago_shape, by = c("Zip.Code" = "zip"))
chicago_vaxx <- st_sf(chicago_vaxx)

ggplot() +
  geom_sf(data = chicago_vaxx, aes(fill = complete_per)) +
  labs(title = "Vaccination Series Completion Status in Chicago",
       fill = "Vaccination Completion Status\n(% of Population)",
       caption = "Source: Chicago Data Portal") +
  theme_void()

st_write(chicago_vaxx, "chicago_vaxx.shp")

## choropleth 2: COVID-19 Vulnerable Age Group in Chicago

## Since the lastest population counts by Zip code I can find on Chicago Data Portal is in 2019, I will
## use the 2019 population data for per person calculation.

pop<- read_csv("Chicago_Population_Counts.csv")
pop_over_60_per <- pop %>%
  filter(Year == 2019 & Geography != "Chicago") %>%
  filter(`Population - Total` != 0) %>%
  mutate(over_60_per = 100 * (`Population - Age 60-69` +`Population - Age 70-79` + `Population - Age 80+`) / `Population - Total`) %>%
  select(Geography, over_60_per)

chicago_pop_60plus <- inner_join(pop_over_60_per , chicago_shape, by = c("Geography" = "zip"))
chicago_pop_60plus <- st_sf(chicago_pop_60plus)

ggplot() +
  geom_sf(data = chicago_pop_60plus, aes(fill = over_60_per)) +
  labs(title = "COVID-19 Vulnerable Age Group Percentage in Chicago",
       fill = "Aged 60+\n(% of Population)",
       caption = "Source: Chicago Data Portal") +
  theme_void()

st_write(chicago_pop_60plus, "chicago_pop_60plus.shp")

## With the plot of Vaccination Series Completion Status in Chicago, I aim to display
## the vaccination rate in Chicago by Zip Code. Meanwhile, I also generate the 
## 60+ age group percentage in each Zip code area, in order to determine the 
## vulnerable population distribution in Chicago. Based on these two choropleths,
## we can clearly observe and determine which area should put more effort to improve 
## the vaccination rate (from the perspective of the end of 2019, as the data are
## from that period). We can clearly observe that there the rates of vulnerable age 
## group in south Chicago are generally high, while vaccination rates in these areas
## are comparatively low. This might have introduced the a more severe public health 
## issue, compraed to the north Chicago.
