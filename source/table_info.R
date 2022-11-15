# USFS Summary Table

library(ggplot2)
library(tidyverse)
source("~/Documents/info201/assignments/project-group-2-section-af/source/summary_info.R")

table_info <- data.frame(most_common_fire_size = summary_info$fire_size,
                      most_common_state_origin = summary_info$max_state_origin,
                      most_common_cause = summary_info$stat_cause,
                      year_with_most_fires = summary_info$year_most_fires,
                      largest_total_acres = prettyNum(summary_info$max_total_acres, 
                                            big.mark = ",", scientific = FALSE))
