# Chart 1 - Mapping the locations/origin points of Forest Fires in the U.S.

# loading U.S. Fire Origin Points Data
library(tidyverse)
library(ggplot2)
library(maps)
library(leaflet)
data <- read_csv('https://media.githubusercontent.com/media/info201a-au2022/project-group-2-section-af/main/data/US_Fire_Origin_Points.csv')
View(data)

# get table of just latitudes and longitudes 
latitudes <- data %>% group_by(INITIAL_RESPONSE) %>% summarize(lat = (POO_LATITUDE))
longitudes <- data %>% group_by(INITIAL_RESPONSE) %>% summarize(long = (POO_LONGITUDE))
origin_location <- left_join(latitudes, longitudes, by = "INITIAL_RESPONSE")
origin_location <- origin_location[complete.cases(origin_location),]
origin_location <- origin_location %>% mutate(date = as.Date(INITIAL_RESPONSE, "%m/%d/%Y"))

# most recent date 5-30-21
year_2000_2021 <- origin_location %>% filter(date < "0023-01-01" ) 
year_2000_2021 <- year_2000_2021 %>% arrange(desc(date))
year_2010_2021 <- year_2000_2021 %>% filter(date >= "0010-01-01" )
year_2000_2010 <- year_2000_2021 %>% filter(date < "0011-01-01")
year_2018_2021 <- year_2000_2021 %>% filter(date >= "0018-01-01")

m <- leaflet(year_2018_2021) %>% 
  addTiles()  %>% 
  setView( lat=40, lng=-97 , zoom=2.5) %>%
  addProviderTiles("CartoDB.Positron") %>%
  addMarkers(~long, ~lat, popup = ~as.character(INITIAL_RESPONSE))  
m
  #addLegend( pal=mypalette, values=~mag, opacity=0.9, title = "Magnitude", position = "bottomright" )

 



