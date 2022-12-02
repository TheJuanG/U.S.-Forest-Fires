library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(bslib)
library(stringr)
source("app_server.R")
source("app_ui.R")

# Run the application
shinyApp(ui = ui, server = server)

