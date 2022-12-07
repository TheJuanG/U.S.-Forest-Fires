library(tidyverse)
library(plotly)
library(ggplot2)
library(usmap)
library(scales)
library(shiny)
library(dplyr)
library(bslib)
library(stringr)

#library("rsconnect")

source("app_server.r")
source("app_ui.r")

# Run the application
shinyApp(ui = ui, server = server)

