# This file contains all of the UI code used to build the multi-page shiny app
# Page 1 -------------------------------------------------
# create tab for intro page
intro_panel <- tabPanel(
  "Introduction",
  fluidPage(
    h1("U.S. Forest Fires"),
    br(), 
    # show landing image
    imageOutput("forestfires"),
    p("source: NY Times: Fire burning in Long Meadow Grove in Sequoia National Forest"), 
    p("Credit...David Mcnew/Getty Images"),
    br(),
    # Intro and summary
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
    strong("Socioeconomic:"), p("Most wildfire damage occurs in transitional areas that border businesses and homes and undeveloped areas. 
    However, crowding and housing crises have resulted in states restricting development in densly populated cities. 
    More people are moving further away from city centers to where housing costs are lower. 
    Both of these factors have resulted in an expansion in development on the wildland-urban interface (WUI), 
    which is a region near and part of flammable vegetation (Popovich, Plumber, NY Times 2022)."),
    br(),
    strong("Stakeholders:"),
    br(),
    em("General public:"), p("Forest fires can threaten their homes and communities. Active fires can cause severe health risks due to smoke inhalation and reduced air quality."),
    em("Wildfire Agencies:"), p("Wildfire agencies and fire departments develop and carry out interventions to curb and eliminate fires. Their aims are to ensure the safety of firefighters, 
                                reduce or eliminate the fire such that it doesn’t harm residents, and the most environmental benefit from the fire is received."),
    em("Meteorological/climate Agencies:"), p("Wildfires cause changes in air quality, temperature, dryness, rainfall, and other measures of climate and weather. 
                                              Wildfires can cause long-term changes in the temperament of a region."),
    
    strong("Human Values:"),
    br(),
    em("1. Environmental Sustainability:"),
    em("2. Safety:"),
    p("The interventions designed to fight and prevent forest fires must balance the impact on the environment as well as prioritizing the safety of people and their communities.
      Additionally, choosing which interventions to enact represents another value tension. For example, prescribed burns are encouraged as a way to create more resilient forests, 
      however too many fires put residents and their families at risk."),
    h3("Research Questions:"),
    strong("1. What is trend in frequency of forest fires?"), 
    p("This question investigates the number of forest fires per year nationally over the past few decades. This is important in 
      order to determine if more resources are needed to effectively fight fires."),
    br(),
    strong("2. Which locations do forest fires most frequently occur?"), br(),
    p("This question investigates the most common locations of forest fires over the past few decades. In order to determine if some areas are at higher risk to 
      forest fire exposure, which can lead to better allocation of wildfire agency resources and better prepare residents of those areas."),
    br(),
    strong("3. What is the most frequent cause of forest fires?"),
    p("Forest fires have a variety of different causes as determined by the USFDS. It is important to know what is the most common cause of these incidents in order 
      to better educate people about how their individual actions can also impact forest fires."),
    h3("Datasets:"), 
    p("The dataset analyzed is the US Forest Service Fires hosted on Redvis, which is a data platform for academic research. This dataset was curated 
      by Ian Mathews and is derived from the U.S. Forest Service - Geospatial Data 
      Discovery. The dataset is comprised of the following three files."),
    strong("1. A compiled list of forest fires in the United States ranging from 1992-2015, with 1,880,465 total entries"),
    br(),
    strong("2. A list of forest fires with origin points information in the United States ranging from 1950-2021, with 328,985 total entries"),
    br(),
    strong("3. A list of forest fires with fire perimeters in the United States ranging from 1750 to 2019 with 46,557 total entries"),
    br(), br(),
    p("After exploratory analysis of all three data files, it was determined that data files 2 and 3 were too incomplete and insufficient sources
      in the larger context of national forest fires. Therefore, visualizations in this interactive report are created using the compiled dataset."),
    # add key findings to intro page -> Chantalle
    h3("Key Findings:")
  )
)
# Page 2 -------------------------------------------------
# Fires Over Time - investigating fire frequency

# define following 
fire_freq_per_yr <- read_csv('../../data/US_Fire_Freq_Per_Year.csv')
class <- unique(fire_freq_per_yr$fire_size_class)


# create the tab
time_graph_panel <- tabPanel(
  "Fires Over Time",
  h2("Evolution of Forest Fires"),
  
  # slider bar layout content
  sidebarLayout(
    sidebarPanel(
      selectInput("size_class", label = strong("Select Overall or Fire Size Classification"), 
                  choices = list("Overall" = class[1], "A: .00-0.25 Acres" = class[2], "B: .26-9.99 Acres" = class[3], "C: 10-99.99 Acres" = class[4], 
                                 "D: 100-299.99 Acres" = class[5], "E: 300-999.99 Acres" = class[6], 
                                 "F: 1000-4999.99 Acres" = class[7],"G: >5000 Acres" = class[8]),
                  selected = class[1]),
      
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
  "Final Project",      # application title 
  intro_panel,            # intro page
  time_graph_panel, 
)
