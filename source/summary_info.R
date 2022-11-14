# Summary Information

library(tidyverse)
library(ggplot2)

# U.S. Fire Origin Points Data
origin_points <- read.csv("https://media.githubusercontent.com/media/info201a-au2022/project-group-2-section-af/main/data/US_Fire_Origin_Points.csv")
View(origin_points)

summary_info <- list()

# info 1
summary_info$origin_num_observations <- nrow(origin_points)

# info 2
summary_info$max_state_origin <- origin_points %>%
  filter(STATE_NAME == max(STATE_NAME, na.rm = TRUE)) %>%
  select(STATE_NAME)

# U.S. Fire Perimeters
perimeters <- read.csv("https://media.githubusercontent.com/media/info201a-au2022/project-group-2-section-af/main/data/US_Fire_Perimeters.csv")
View(perimeters)

# info 3
summary_info$perimeters_num_observations <- nrow(perimeters)

# info 4

# info 5
