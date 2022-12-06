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
    strong("1. What is the trend in frequency of forest fires?"), 
    p("This question investigates the number of forest fires per year nationally over the past few decades. This is important in 
      order to determine if more resources are needed to effectively fight fires."),
    br(),
    strong("2. Which locations do forest fires most frequently occur?"), br(),
    p("This question investigates the most common locations of forest fires over the past few decades. In order to determine if some areas are at higher risk to 
      forest fire exposure, which can lead to better allocation of wildfire agency resources and better prepare residents of those areas."),
    br(),
    strong("3. What is the most frequent cause of forest fires?"),
    p("Forest fires have a variety of different causes as determined by the USFS. It is important to know what is the most common cause of these incidents in order 
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
    h3("Key Findings:"),
    strong("From visualization #1:"),
    p("The highest annual number of forest fires was between
           0.26 and 9.99 acres. From 1992 to 2015, the counts for this size range were approximately 
           30,000 fires and above."),
    strong("From visualization #2:"),
    p("The map shows that the states California, Georgia, and Texas had the highest number
      of forest fires for most years."),
    strong("From visualization #3:"),
    p("Debris Burning is the leading cause of forest fires.")
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


# Page 3 -------------------------------------------------
# Map of Fires - investigating fire frequency per state

# define following 
fire_state_year <- read_csv('../../data/US_State_Fire_Year.csv')

years_state <- unique(fire_state_year$fire_year)
years_state <- sort(years_state, decreasing = FALSE)
    

# create the tab
map_graph_panel <- tabPanel(
  "Fires Per State",
  h2("Evolution of Forest Fires"),
  
  # slider bar layout content
  sidebarLayout(
    sidebarPanel(
      
      
      selectInput(inputId = "fire_year", label = "Year Choice", choices =
                    list("1992" = years_state[1], "1993" = years_state[2], "1994" = years_state[3],
                         "1995" = years_state[4], "1996" = years_state[5], "1997" = years_state[6], "1998" = years_state[7],
                  "1999" = years_state[8], "2000" = years_state[9], "2001" = years_state[10], "2002" = years_state[11],
                  "2003" = years_state[12], "2004" = years_state[13], "2005" = years_state[14], "2006" = years_state[15],
                  "2007" = years_state[16], "2008" = years_state[17], "2009" = years_state[18], "2010" = years_state[19],
                  "2011" = years_state[20], "2012" = years_state[21], "2013" = years_state[22], "2014" = years_state[23],
                  "2015" = years_state[24]), selected = years_state[1])
      
    ),
    
    # main panel layout content
    mainPanel(
      plotlyOutput(outputId = "map")
    )
  ),
  # Description of Graph
  h3(""),
  p("")
)
years_state[1]

# Page 4 -------------------------------------------------
# Bar Chart of Fire Causes - investigating most common fire causes

# define following 
fire_causes <- read_csv('../../data/US_Fire_Causes.csv')

year_select <- unique(fire_causes$fire_year)

# create the tab
bar_graph_panel <- tabPanel(
  "Fire Causes",
  h2("U.S. Fire Causes"),
  
  # slider bar layout content
  sidebarLayout(
    sidebarPanel(
      
      
      selectInput(inputId = "fire_year", label = "Year Choice", 
                  choices =
                    list("1992" = year_select[1], "1993" = year_select[2], "1994" = year_select[3],
                         "1995" = year_select[4], "1996" = year_select[5], "1997" = year_select[6], "1998" = year_select[7],
                         "1999" = year_select[8], "2000" = year_select[9], "2001" = year_select[10], "2002" = year_select[11],
                         "2003" = year_select[12], "2004" = year_select[13], "2005" = year_select[14], "2006" = year_select[15],
                         "2007" = year_select[16], "2008" = year_select[17], "2009" = year_select[18], "2010" = year_select[19],
                         "2011" = year_select[20], "2012" = year_select[21], "2013" = year_select[22], "2014" = year_select[23],
                         "2015" = year_select[24]), selected = year_select[1])
    ),

    # main panel layout content
    mainPanel(
      plotlyOutput(outputId = "bar")
    )
  ),
  # description of bar chart
  h3("What are the main causes of forest fires in the United States?"),
  p("The pie chart above allows you to determine the number of fires caused by 
    each factor per year, which can be filtered by using the drop-down menu. The 
    data was collected from the U.S. Forest Service (USFS), and from this chart 
    we can learn the most common causes of fires to be able to take necessary 
    precautions and prevent future ignitions.")
)

# Page 5 -------------------------------------------------
# Summary Takeaways

# create tab
takeaway_page_panel <- tabPanel(
  "Summary",
  h2("Summary Takeaways")
)

# Page 6 -------------------------------------------------
# Report

# create tab
report_page_panel <- tabPanel(
  "Report",
  h2("Summary Report"),
  br(),
  h3("U.S. Forest Fires"),
  p(""),
  strong("Code Name:"), 
  p("USFS"),
  strong("Authors:"), 
  p("Juan Carlos (juancg@uw.edu), Chantalle Matro (cmatro@uw.edu), Militha Madur (militham@uw.edu)"),
  strong("Affiliation:"),
  p("INFO-201: Technical Foundations of Informatics - The Information School - University of Washington"),
  strong("Date:"), 
  p("Autumn 2022"),
  h3("Abstract:"),
  p("Our main concern is the role of forest fires in climate change. This is 
    important because not only are there environmental consequences, but 
    socioeconomic effects as well. To address this concern, we plan to examine a
    dataset provided by the U.S. Forest Service that contains information about
    past and recent U.S. forest fires."),
  h3("Keywords:"),
  p("forest fires, climate change, global warming, housing crisis"),
  h3("Introduction:"),
  p("Climate change has caused many devastating environmental changes. One of 
    the most significant is the severe intensity and frequency of wildfires. 
    The timing of the fire season has evolved to reach a higher peak much 
    earlier and last much longer. While the record breaking temperatures and 
    dryness from human-caused climate change have increased the ability of fires
    to start and remain sustained, climate change is not the only cause of forest
    fires. Forest fires are caused by a variety of different factors including 
    lightning, unattended campfires, equipment use and malfunctions, and discarded 
    cigarettes. Based on  2000-2017 data almost 85% of wildland fires were caused 
    by humans in the United States (US National Park Services 2022). We aim to 
    identify most common causes of forest fires, highest at risk regions for fires,
    and the impact of forest fires on the environment in order to better inform
    policy and fire prevention/management efforts."),
  h3("Problem Domain:"),
  strong("Background:"),
  p(""),
  strong("Environmental Context:"),
  p("Human-caused global warming and climate change has resulted in record high
    temperatures and dryness that has resulted in devastating fires. In regions
    with histories of forest fires, the intensity and acreage of fires has vastly
    increased. Decreased rainfall and humidity have also increased the flammability 
    of vegetation, increasing the abundance of forest fire fuel, frequency of fires,
    and span of fires."),
  strong("Socioeconomic Context:"),
  p("Most wildfire damage occurs in transitional areas that border businesses 
    and homes and undeveloped areas. However, crowding and housing crises have 
    resulted in states restricting development in densely populated cities. More
    people are moving further away from city centers to where housing costs are
    lower. Both of these factors have resulted in an expansion in development on 
    the wildland-urban interface (WUI), which is a region near and part of 
    flammable vegetation (Popovich, Plumber, NY Times 2022)."),
  strong("Stakeholders:"),
  p("General Public: Forest fires can threaten their homes and communities. 
    Active fires can cause severe health risks due to smoke inhalation and 
    reduced air quality."),
  p("Wildfire Agencies: Wildfire agencies and fire departments develop and carry
  out interventions to curb and eliminate fires. Their aims are to ensure the 
  safety of firefighters, reduce or eliminate the fire such that it doesn’t harm 
  residents, and the most environmental benefit from the fire is received."),
  p("Meteorological/climate Agencies: Wildfires cause changes in air quality, 
  temperature, dryness, rainfall, and other measures of climate and weather. 
  Wildfires can cause long-term changes in the temperament of a region."),
  strong("Human Values:"),
  p("The interventions designed to fight and prevent forest fires must balance 
    the impact on the environment as well as prioritizing the safety of people 
    and their communities. Therefore, the  human values of environmental 
    sustainability and safety are the driving forces behind the issue of forest
    fires. Additionally, choosing which interventions to enact represents another 
    value tension. For example, prescribed burns are encouraged as a way to
    create more resilient forests, however too many fires put residents and their
    families at risk."),
  strong("Potential Benefits and Harms:"),
  p("Potential benefits of data/technology intervention  include implementing 
    more effective interventions that eliminate fires faster while reducing the
    risk for firefighters and wildfire agencies and predicting fire intensity, 
    location, and timing allowing wildfire agencies to better prepare resources
    and advise residents. This will help eliminate threats before they reach 
    communities and threaten the environment further. The potential harm of this
    solution is that it could contribute to creating an algorithm that 
    prioritizes certain fire prone regions over others. An unanticipated consequence
    is that the criteria that the algorithm uses could have biases that result 
    in inequities."),
  h3("Research Questions:"),
  strong("1. What is the trend in frequency of forest fires?"),
  p("Seeing the number of forest fires per year, whether it’s increasing or 
    decreasing, will help determine if there must be more resources available to 
    effectively fight fires. Also, it can aid in learning how these resources 
    and methods can be further improved."),
  br(),
  strong("2. Which locations do forest fires most frequently occur?"),
  p("Recognizing the locations in which forest fires happen the most allows for 
    more attention to these vulnerable areas. This aids in prevention by being
    more aware of fire hazards and better preparation of fire engines."),
  br(),
  strong("3. What is the most frequent cause of forest fires?"),
  p("Knowing the source of these forest fires is vital in the implementation of 
    prevention strategies. Wildfire agencies will also be able to prepare for 
    the effects of the disaster and even advise citizens about the fires and 
    steps to take."),
  
  
)

?toJSON


# Define UI
ui <- navbarPage(
  theme = bs_theme(bootswatch = "solar"),
  "Final Project",      # application title 
  intro_panel,            # intro page
  time_graph_panel,
  map_graph_panel,
  bar_graph_panel,
  takeaway_page_panel,
  report_page_panel
)
