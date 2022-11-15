# USFS Summary Table

library(ggplot2)
library(tidyverse)
library(dplyr)
source("~/Documents/info201/assignments/project-group-2-section-af/source/summary_info.R")

# Table containing summary info
# table_info <- data.frame(most_common_fire_size = summary_info$fire_size,
#                       most_common_state_origin = summary_info$max_state_origin,
#                       most_common_cause = summary_info$stat_cause,
#                       year_with_most_fires = summary_info$year_most_fires,
#                       largest_total_acres = prettyNum(summary_info$max_total_acres, 
#                                             big.mark = ",", scientific = FALSE))

table_info_2 <- origin_points %>% 
  group_by(STATISTICAL_CAUSE) %>% 
  select(INITIAL_RESPONSE, STATE_NAME, COUNTY_NAME, FIRE_NAME, FIRE_SIZE_CLASS)
