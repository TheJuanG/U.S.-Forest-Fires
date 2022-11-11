# Chart 1 - Mapping the locations/origin points of Forest Fires in the U.S.

# loading U.S. Fire Origin Points Data
library(dplyr)
library(devtools)
# devtools::install_github("redivis/redivis-r", ref="main")
user <- redivis::user("demo")
dataset <- user$dataset("us_forest_service_fires:5k9t:v1_1")
fire_origin_points <- dataset$table("us_fire_origin_points:5r3s")
View(fire_origin_points)
 