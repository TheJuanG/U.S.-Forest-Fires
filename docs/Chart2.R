# Chart 2 - Visualization for the most frequent cause on BarChart


# loading U.S. Fire Origin Points Data
library(tidyverse)
library(ggplot2)
library(scales)
data <- read_csv('https://media.githubusercontent.com/media/info201a-au2022/project-group-2-section-af/main/data/US_Fire_Origin_Points.csv')
View(data)

graph <- ggplot(data, aes(x=STATISTICAL_CAUSE)) + 
  geom_bar(width = 0.7) +
  labs(x = "Causes", y = "Number of Fires Caused", title = "The Causes of Forest Fires") +
  scale_y_continuous(labels = label_number(suffix = " K", scale = 1e-3)) +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) # make x-axis labels readable
graph


# Scale_y_continuous used to make y values easier to read.

?ggplot


