# USFS Summary Table

library(ggplot2)
library(tidyverse)
library(dplyr)
source("~/Documents/info201/assignments/project-group-2-section-af/source/summary_info.R")

# U.S. Fire Origin Points Summary Table

# code retrieved from 
# https://exploratory.io/note/kanaugust/1701090969905358#:~:text=Mode%20Function,write%20a%20custom%20R%20function.
calculate_mode <- function(x) {
  uniqx <- unique(na.omit(x))
  uniqx[which.max(tabulate(match(x, uniqx)))]
}

table_info <- origin_points %>%
  group_by(STATE_NAME) %>%
  summarize(county_most_fires = calculate_mode(COUNTY_NAME),
            common_fire_size = calculate_mode(FIRE_SIZE_CLASS),
            common_causes = calculate_mode(STATISTICAL_CAUSE))

table_info_2 <- perimeters %>% 
  group_by(FIREYEAR) %>% 
  summarize(max_total_acres = max(TOTALACRES, na.rm = TRUE),
            common_causes = calculate_mode(STATCAUSE))