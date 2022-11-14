# Summary Information

library(tidyverse)
library(dplyr)
library(ggplot2)

# U.S. Fire Origin Points Data
origin_points <- read_csv('https://media.githubusercontent.com/media/info201a-au2022/project-group-2-section-af/main/data/US_Fire_Origin_Points.csv')
View(origin_points)

summary_info <- list()

# info 1: most common fire size/class
summary_info$fire_size <- names(which.max(table(origin_points$FIRE_SIZE_CLASS)))
  
# info 2: most common state as origin
summary_info$max_state_origin <- names(which.max(table(origin_points$STATE_NAME)))

# info 3: most common statistical cause

summary_info$stat_cause <- names(which.max(table(origin_points$STATISTICAL_CAUSE)))

# U.S. Fire Perimeters Data
perimeters <- read_csv('https://media.githubusercontent.com/media/info201a-au2022/project-group-2-section-af/main/data/US_Fire_Perimeters.csv')
View(perimeters)

# info 4: year with most fires
summary_info$year_most_fires <- names(which.max(table(perimeters$FIREYEAR)))

# info 5: largest total acres
summary_info$max_total_acres <- perimeters %>%
  filter(TOTALACRES == max(TOTALACRES, na.rm = TRUE)) %>%
  pull(TOTALACRES)
