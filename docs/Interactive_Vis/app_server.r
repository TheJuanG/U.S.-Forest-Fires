library(tidyverse)
library(plotly)
library(ggplot2)

fire_freq_per_yr <- read_csv('../../data/US_Fire_Freq_Per_Year.csv')
server <- function(input, output) {
  # show image on intro page
  output$forestfires <- renderImage({
    list(src = "forestfires.png",
         width = "100%",
         height = "100%")
  }, deleteFile = FALSE)
  
  # show scatter plot on Fires Over Time Page
  output$scatter <- renderPlotly({
    
    chosen <- fire_freq_per_yr %>% filter(fire_year >= input$year[1] & fire_year <= input$year[2])
    chosen <- chosen %>% filter(fire_size_class == input$size_class)
    p <- ggplot(data = chosen) +
      geom_line(aes(x = fire_year, y = num_fires, color = '#59b2a2')) +
      geom_point(aes(x = fire_year, y = num_fires, color = '#59b2a2',  text = paste0("Year: ",fire_year,"\nFires: ", num_fires))) +
      labs(title = "United States Forest Fires Trend", x = "Year of Observation", y = "Annual Number of Fires") +
      scale_y_continuous(labels = scales::comma) +
      scale_x_continuous()
    p <- p + theme(legend.title = element_blank())
    p <- p + theme(legend.position='none')
    # plotly
    p_plotly <- ggplotly(p, tooltip = "text")
    return(p_plotly)
  })
}