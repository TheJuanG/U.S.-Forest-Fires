library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(bslib)
library(stringr)
source("fire_app_server.R")
source("fire_app_ui.R")

# Run the application
shinyApp(ui = ui, server = server)

