library(tidyverse)
library(plotly)
library(ggplot2)
library(usmap)
library(scales)
library(shiny)
library(dplyr)
library(bslib)
library(stringr)

fire_freq_per_yr <- read_csv('US_Fire_Freq_Per_Year.csv')

fire_state_year <- read_csv('US_State_Fire_Year_New.csv')

fire_causes <- read_csv('US_Fire_Causes.csv')

report_table <- read_csv('ReportTable.csv')

summary_1 <- read_csv('Sum1.csv')

summary_2 <- read_csv('Sum2.csv')

summary_3 <- read_csv('Sum3.csv')

server <- function(input, output) {
  # show image on intro page
  output$forestfires <- renderImage({
    list(src = "forest_fires.png",
         width = "100%",
         height = "100%")
  }, deleteFile = FALSE)
  
  output$table <- renderTable(report_table)
  output$sum1 <- renderTable(summary_1)
  output$sum2 <- renderTable(summary_2)
  output$sum3 <- renderTable(summary_3)
  
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
    chosen <- fire_state_year %>% filter(fire_year == input$fire_year) %>%
      filter(stat_cause_descr == input$stat_cause_descr)
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
  
  output$bar <- renderPlotly({
    chosen <- fire_causes %>% filter(fire_year == input$yr) %>% 
      arrange(statistical_cause)
    fig <- plot_ly(chosen, labels = ~statistical_cause, values = ~num_fires_caused, type = "pie", textinfo = "none",
                   marker = list(colors = c('#d74c22', '#ed6010', '#fa7e00', '#f89a33', '#f9986a',
                                            '#fdc18d', '#fdd8bc', '#b02220', '#d31848', '#f3444f',
                                            '#f25371', '#f16d8b', '#f372a2')))
    fig <- fig %>% 
      layout(title = 'Number of Fires Occurred per Cause',
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    return(fig)
  })
}

?ggplotly
?renderPlotly
