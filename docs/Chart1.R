# Chart 1 - Mapping the locations/origin points of Forest Fires in the U.S.

# loading U.S. Fire Origin Points Data
library(tidyverse)
library(plotly)

data <- read_csv('https://media.githubusercontent.com/media/info201a-au2022/project-group-2-section-af/main/data/US_Fire_Origin_Points.csv')
View(data)
fires_1990_2021 <- data %>% filter(DISCOVER_YEAR >= 1990) %>% filter(FIRE_SIZE_CLASS != "-")
# changing default color scale title
c <- list(colorbar = list(title = "Fire Size"))
# geo styling
g <- list(
  scope = 'north america',
  showland = TRUE,
  landcolor = toRGB("grey83"),
  subunitcolor = toRGB("white"),
  countrycolor = toRGB("white"),
  showlakes = TRUE,
  lakecolor = toRGB("white"),
  showsubunits = TRUE,
  showcountries = TRUE,
  resolution = 50,
  projection = list(
    type = 'conic conformal',
    rotation = list(lon = -100)
  ),
  lonaxis = list(
    showgrid = TRUE,
    gridwidth = 0.5,
    range = c(-140, -55),
    dtick = 5
  ),
  lataxis = list(
    showgrid = TRUE,
    gridwidth = 0.5,
    range = c(20, 60),
    dtick = 5
  )
)

fig <- plot_geo(fires_1990_2021, lat = ~POO_LATITUDE, lon = ~POO_LONGITUDE, color = ~FIRE_SIZE_CLASS, colors = "YlOrRd")
fig <- fig %>% add_markers(
  text = ~paste(fires_1990_2021$FIRE_SIZE_CLASS), hoverinfo = "text"
)
fig <- fig %>% layout(title = 'Origin and Size of U.S. Forest Fires 1990-2021', geo = g)

fig 





 



