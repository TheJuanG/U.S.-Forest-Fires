library(shiny)
library(ggplot2)
# Page 1 -------------------------------------------------
# create tab
intro_panel <- tabPanel(
  "Introduction",
  fluidPage(
    h1("U.S. Forest Fires"),
    br(), 
    imageOutput("forestfires"),
    br(), br(), br(),
    h3("Introduction:"),
    p("Forest fires are becoming increasingly severe in intensity and frequency across the United States. According to the NOAA, each wildfire season from 2020 to 2022 
    has exceeded the average of 1.2 million acres burned since 2016. As these fires continue to evolve to become more aggessive in response to climate change, communities,
      and the environment are increasingly threatened. We aim to identify most common causes of forest fires, highest at risk regions for fires, 
      and the impact of forest fires on the environment in order to better inform policy and fire prevention/management efforts."),
    h3("Problem Domain:"),
    strong("Environmental:"), p("Human-caused global warming and climate change has resulted in record high temperatures and dryness that has resulted in devastating fires.
           In regions with histories of forest fires, the intensity and acreage of fires has vastly increased. Decreased rainfall and humidity have also increased the 
           flammability of vegetation, increasing the abundance of forest fire fuel, frequency of fires, and span of fires."),
    br(),
    strong("Socioeconomic:"), p("Human-caused global warming and climate change has resulted in record high temperatures and dryness that has resulted in devastating fires.
           In regions with histories of forest fires, the intensity and acreage of fires has vastly increased. Decreased rainfall and humidity have also increased the 
           flammability of vegetation, increasing the abundance of forest fire fuel, frequency of fires, and span of fires."),
    br(),
    strong("Stakeholders:"),
    br(),
    em("General public:"), p("Forest fires can threaten their homes and communities. Active fires can cause severe health risks due to smoke inhalation and reduced air quality."),
    br(),
    em("Wildfire Agencies:"), p("Wildfire agencies and fire departments develop and carry out interventions to curb and eliminate fires. Their aims are to ensure the safety of firefighters, 
                                reduce or eliminate the fire such that it doesn’t harm residents, and the most environmental benefit from the fire is received."),
    h3("Research Questions:"),
    strong("1. What is trend in frequency of forest fires?"), 
    br(),
    strong("2. Which locations do forest fires most frequently occur?"), br(),
    strong("3. What is the most frequent cause of forest fires?"),
    
    h3("Datasets:"), 
    p("The following findings are analyzed from three different datasets from Redivis:"),
    p("1. A list of forest fires in the United States ranging from 1992-2015, with 1,880,465 total entries"),
    p("2. A list of forest fires with origin points information in the United States ranging from 1950-2021, with 328,985 total entries"),
    p("3. A list of forest fires with fire perimeters in the United States ranging from 1750 to 2019 with 46,557 total entries")
  )
)
# Page 2 -------------------------------------------------

# define following 
class <- unique(fire_freq_per_yr$fire_size_class)
class <- append(class, "overall")

# create the tab
time_graph_panel <- tabPanel(
  "Fires Over Time",
  h2("Evolution of Forest Fires"),
  
  # slider bar layout content
  sidebarLayout(
    sidebarPanel(
      selectInput("size_class", label = strong("Select Overall or Fire Size Classification"), 
                  choices = list("Overall" = class[8], "A: .00-0.25 Acres" = class[1], "B: .26-9.99 Acres" = class[2], "C: 10-99.99 Acres" = class[3], 
                                 "D: 100-299.99 Acres" = class[6], "E: 300-999.99 Acres" = class[5], 
                                 "F: 1000-4999.99 Acres" = class[4],"G: >5000 Acres" = class[7]),
                  selected = class[8]),
      
      sliderInput(inputId = "year", label = "Year Range", min = 1992, max = 2015, step = 1,
                  value = c(1992, 2015), sep = "")
      
    ),
    # main panel layout content
    mainPanel(
      plotlyOutput(outputId = "scatter")
      
    )
  ),
  # Description of Graph
  h3("What is the trend in frequency of forest fires in the United States?"),
  p("The graph above allows you to view the total number of forest fires per each fire size classification determined by the National Wildlife Coordinating Group (NWCG) for each year.
    The year slider can be used to change the range of years displayed. Fire size classification is a direct measure of the perimeter of a forest fire. This purpose of this graph is to analyze 
    the trends in the frequency of forest fires based on the fire size perimeter classification in comparison to the annual overall total.")
)

# Define UI
ui <- navbarPage(
  theme = bs_theme(bootswatch = "solar"),
  "USFDS",      # application title 
  intro_panel,            # intro page
  time_graph_panel, 
)
