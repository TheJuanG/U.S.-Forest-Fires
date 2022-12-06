library(tidyverse)
library(plotly)
library(ggplot2)
library(usmap)
library(scales)

fire_freq_per_yr <- read_csv('../../data/US_Fire_Freq_Per_Year.csv')

fire_state_year <- read_csv('../../data/US_State_Fire_Year.csv')

fire_causes <- read_csv('../../data/US_Fire_Causes.csv')

server <- function(input, output) {
  # show image on intro page
  output$forestfires <- renderImage({
    list(src = "forest_fires.png",
         width = "100%",
         height = "100%")
  }, deleteFile = FALSE)
  
  # show scatter plot on Fires Over Time Page
  output$scatter <- renderPlotly({
    chosen <- fire_freq_per_yr %>% filter(fire_year >= input$year[1] & fire_year <= input$year[2])
    chosen <- chosen %>% filter(fire_size_class == input$size_class)
    p <- ggplot(data = chosen) +
      geom_line(aes(x = fire_year, y = num_fires, color = 'F9785E')) +
      geom_point(aes(x = fire_year, y = num_fires, color = 'F9785E',  text = paste0("Year: ",fire_year,"\nFires: ", num_fires))) +
      labs(title = "United States Forest Fires Trend", x = "Year of Observation", y = "Annual Number of Fires") +
      scale_y_continuous(labels = scales::comma) +
      scale_x_continuous()
    p <- p + theme(legend.title = element_blank())
    p <- p + theme(legend.position='none')
    # plotly
    p_plotly <- ggplotly(p, tooltip = "text")
    return(p_plotly)
  })
  
  # Show map of fires per state in given year
  output$map <- renderPlotly({
    chosen <- fire_state_year %>% filter(fire_year == input$fire_year)
    p <- plot_usmap(data = chosen, values = "total_fires") +
      scale_fill_continuous(
        low = "white",
        high = "red",
        name = "Total Fires"
      ) +
      labs(title = "United States", subtitle = "Number of Fires") +
      theme(legend.position = "right")
    p_plotly <- ggplotly(p, tooltip = "text")
   return(p)
  })
  
  # Show bar chart of US fire causes
  output$bar <- renderPlotly({
    chosen <- fire_causes %>% filter(fire_year == input$fire_year)
  barchart <- ggplot(chosen) +
    geom_col(mapping = aes(x = statistical_cause, y = num_fires_caused)) +
    labs(x = "Causes", y = "Number of Fires Caused", title = "The Causes of Forest Fires") +
    scale_y_continuous(labels = scales::comma) +
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
  bar_plotly <- ggplotly(barchart, tooltip = "text")
  return(bar_plotly)
  })
}

?ggplotly
?renderPlotly
