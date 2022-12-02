library(tidyverse)
library(plotly)
library(ggplot2)
compiled <- read_csv("https://media.githubusercontent.com/media/info201a-au2022/project-group-2-section-af/main/data/US_Fires_Compiled.csv")
tot_fires_per_yr <- compiled %>% select(fire_year) %>% group_by(fire_year) %>% summarise(num_fires = n()) %>%
  mutate(fire_size_class = "overall")
num_fires_by_class_per_year <- compiled %>% select(fire_year, fire_size_class) %>% group_by(fire_year, fire_size_class) %>%
  summarise(num_fires = n())
fire_freq_per_yr <- bind_rows(tot_fires_per_yr, num_fires_by_class_per_year)

server <- function(input, output) {
  # show image
  output$forestfires <- renderImage({
    list(src = "forestfires.png",
         width = "100%",
         height = "100%", deleteFile=FALSE)
  })
  # show scatter plot
  output$scatter <- renderPlotly({
    
    chosen <- fire_freq_per_yr %>% filter(fire_year >= input$year[1] & fire_year <= input$year[2])
    chosen <- chosen %>% filter(fire_size_class == input$size_class)
    p <- ggplot(data = chosen, aes(x = fire_year, y = num_fires)) +
      geom_point(color = 'aquamarine3') +
      geom_line(color = 'aquamarine3') +
      labs(title = "United States Forest Fires Trend", x = "Year of Observation", y = "Annual Number of Fires") +
      scale_y_continuous(labels = scales::comma) +
      scale_x_continuous()
    # plotly
    p_plotly <- ggplotly(p)
    return(p_plotly)
  })
  output$info <- renderText({
    paste0("Year: ", input$scatter_click$x, "\nFires: ", input$scatter_click$y)
  })
}