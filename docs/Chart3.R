
# Chart 2 - Visualization for the density of fires for every year


# loading U.S. Fire Perimeters Data
library(tidyverse)
library(ggplot2)
the_data <- read_csv('https://media.githubusercontent.com/media/info201a-au2022/project-group-2-section-af/main/data/US_Fire_Perimeters.csv')

plot <- the_data %>% filter( 1900 < FIREYEAR) %>% filter( FIREYEAR < 2023) %>%
  ggplot(aes(x = FIREYEAR)) +
  geom_density(fill="#69b3a2", color="#e9ecef", alpha=0.8) +
  labs( x = "Year", y = "Density of Fires")
  
plot
