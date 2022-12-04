# This following code was used to slim down the original data files to the 
# filtered datasets that are stored in the data folder

library(tidyverse)
library(dplyr)

# load data
compiled <- read_csv("../data/US_Fires_Compiled.csv")

# create df that has the year of fire, overall total fires for that year, and number of fires per 
# fire size class for that year 
tot_fires_per_yr <- compiled %>% select(fire_year) %>% group_by(fire_year) %>% summarise(num_fires = n()) %>%
  mutate(fire_size_class = "overall")
num_fires_by_class_per_year <- compiled %>% select(fire_year, fire_size_class) %>% group_by(fire_year, fire_size_class) %>%
  summarise(num_fires = n())
fire_freq_per_yr <- bind_rows(tot_fires_per_yr, num_fires_by_class_per_year)
write.csv(fire_freq_per_yr,"~/Documents/info201/assignments/project-group-2-section-af/data/US_Fire_Freq_Per_Year.csv", row.names = FALSE)

