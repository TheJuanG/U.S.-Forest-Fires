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
    br(),
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
fire_freq_per_yr <- read_csv('US_Fire_Freq_Per_Year.csv')
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
fire_state_year <- read_csv('US_State_Fire_Year_New.csv')

years_state <- unique(fire_state_year$fire_year)
years_state <- sort(years_state, decreasing = FALSE)

years_cause <- unique(fire_state_year$stat_cause_descr)
    

# create the tab
map_graph_panel <- tabPanel(
  "Fires Per State",
  h2("Map of Forest Fires"),
  
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
                  "2015" = years_state[24]), selected = years_state[1]),
      
    
    
    selectInput(inputId = "stat_cause_descr", label = "Cause Choice", choices =
                  list("All" = years_cause[1], "Arson" = years_cause[2], "Smoking" = years_cause[3], "Campfire" = years_cause[4],
                       "Children" = years_cause[5], "Railroad" = years_cause[6], "Fireworks" = years_cause[7],
                       "Lightning" = years_cause[8], "Powerline" = years_cause[9], "Structure" = years_cause[10],
                       "Equipment Use" = years_cause[11], "Miscellaneous" = years_cause[12], "Debris Burning" = years_cause[13],
                       "Missing/Undefined" = years_cause[14]), selected = years_cause[1]),
    ),
    
    # main panel layout content
    mainPanel(
      plotlyOutput(outputId = "map")
    )
  ),
  # Description of Graph
  h3("Which locations do forest fires most occur?"),
  p("The map allows you to view the total number of fires that have occurred in each state when choosing the cause of the fire and the year you want to see.
    Being able to change the year and cause of fires lets you see how different states or regions are impacted by a specific cause of fire for a given year compared to others.")
)
years_state[1]

# Page 4 -------------------------------------------------
# Bar Chart of Fire Causes - investigating most common fire causes

# define following 
fire_causes <- read_csv('US_Fire_Causes.csv')

year_select <- unique(fire_causes$fire_year)

# create the tab
bar_graph_panel <- tabPanel(
  "Fire Causes",
  h2("U.S. Forest Fire Causes"),
  
  # slider bar layout content
  sidebarLayout(
    sidebarPanel(
      
      
      selectInput(inputId = "yr", label = "Year Choice", 
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
  h2("Summary Takeaways"),
  h3("From visualization #1:"),
  strong("Forest Fire Counts"),
  tableOutput("sum1"),
  p("This table shows the highest, lowest, and most recent forest fire counts
    for the 'Overall' fire size classification. This information is important in
    determining if our country's response to forest fires is improving throughout 
    the years. The graph shows that the count fluctuates, but at least we can see
    that it has not reached a really high number since 2006."),
  h3("From visualization #2:"),
  strong("States with Most Forest Fires (2015)"),
  tableOutput("sum2"),
  p("This table shows the three states that had the most number of forest fires 
    that occurred through all causes in the year 2015. Texas and California had 
    the highest count in 2015 and for most years, which means that these areas
    need more attention."),
  h3("From visualization #3:"),
  strong("Top Forest Fire Causes (1992-2015)"),
  tableOutput("sum3"),
  p("This table shows the top three causes of forest fires in the U.S. and how
    many years (from 1992-2015) they were the most frequent cause. By knowing that
    Debris Burning is the leading cause of forest fires, we can hopefully reduce
    its occurrence in the future.")
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
  h3("The Dataset:"),
  p("The dataset on Redivis (derived from the U.S. Forest Service) provides 
    information about U.S. forest fires from 1992 to 2022. It contains data 
    such as fire location, size, cause, etc. Since the concern is climate change,
    this source will help in the preparation for future fires and their prevention. 
    With this dataset, readers are able to be informed and even use it to create 
    new resources (such as apps) to spread awareness about the world's current 
    state."),
  tableOutput("table"),
  p(""),
  p("The data is distributed by the U.S. Forest Services (USFS), and the main 
    contributor is Ian Mathews (data curator). The datasets were last updated 
    on October 6, 2022 and dates back from as early as 1992. USFS, an agency 
    under the U.S. Department of Agriculture, encourages citizens to use their
    data to create maps, apps, and other information products. Those who utilize
    this resource are able to make money with their creations. The dataset was 
    obtained from Redivis, a site that allows different organizations to upload 
    and manage datasets."),
  p("Creator: Redivis Demo Organization"),
  p("Contributors: Ian Mathews (Data curator)"),
  p("Related identifiers: https://data-usfs.hub.arcgis.com/"),
  p("Citation: Redivis Demo Organization (2022). US Forest Service Fires (v1.1). 
    Redivis. (Dataset) https://redivis.com/datasets/5k9t-07xsg7ckc?v=1.1"),
  h3("Findings:"),
  strong("1. What is trend in frequency of forest fires?"),
  p("From the overall graph, we can see that the greatest annual number of fires 
    in our dataset occurred in 2006 over the time period from 1992 to 2015. 
    Additionally, over this time period, most of the fires that occurred were 
    of size classification B: .26-9.99 Acres, ranging from a minimum of 29,624 
    in 2013 to a peak of 59,411 in 2006. The trend in total forest fires in the
    United States is that the annual number of fires increased from 67,975 fires
    in 1992 to max of 114,004 fires  in 2005, and decreased to 74,491 fires in 
    2015. The trend in G classification fires (>5000 acres) large fires  is that 
    the annual number of fires was 58 in 1992 and then began to experience a 
    series of sharp increases and sharp declines at the same rate. Throughout 
    this period, the peaks of the cycles increased and the peak of the last cycle
    is almost double the peak of the first cycle. The trends in size classification
    B fires over this period closely mirrors the overall trend and range of values
    as the total fires graph."),
  h3("Discussion:"),
  p("The trends in frequency of forest fires over the time period of 1992-2015 
    are characterized by a series of sharp increases mirrored by sharp declines.
    This indicates the natural cyclic behavior of wildfires. The aftermath of a 
    forest fire leaves little debris leftover, so the likelihood of another fire
    starting immediately after is low. This is seen in this visualization 
    following a year or two with a huge increase in annual forest fires, the 
    next year or two experience a decline. Comparing the scales of each fire 
    size classification tells us that the majority of forest fires over this 
    time period are small fires, and although larger fires occur on a much
    smaller scale, the annual number of large fires has increased since 1992 
    as of 2015. This indicates that smaller fires may actually be a greater 
    threat in the United States."),
  h3("Conclusion:"),
  h3("Acknowledgements:"),
  h3("References:"),
  strong("Research References:"),
  p("Popovich, Nadja, and Brad Plumer. 'As Wildfires Grow, Millions of Homes 
  Are Being Built in Harm's Way.' The New York Times, The New York Times, 9 Sept. 
  2022, https://www.nytimes.com/interactive/2022/09/09/climate/growing-wildfire-risk-homes.html."),
  p("Redivis Demo Organization (2022). US Forest Service Fires (v1.1). Redivis. 
    (Dataset) https://redivis.com/datasets/5k9t-07xsg7ckc?v=1.1"),
  p("'Wildfire Causes and Evaluations (U.S. National Park Service).' National 
    Parks Service, U.S. Department of the Interior, https://www.nps.gov/articles/wildfire-causes-and-evaluation.htm."),
  p("'Wildfire Climate Connection.' National Oceanic and Atmospheric Administration, 
    https://www.noaa.gov/noaa-wildfire/wildfire-climate-connection#:~:text=Research%20shows%20that%20changes%20in,fuels%20during%20the%20fire%20season."),
  p("Zhong, Raymond. 'Climate Scientists Warn of a 'Global Wildfire Crisis'.' 
    The New York Times, The New York Times, 23 Feb. 2022, https://www.nytimes.com/2022/02/23/climate/climate-change-un-wildfire-report.html."),
  strong("Image References:"),
  p("Mcnew, David. 'The Windy Fire Burning in the Long Meadow Grove in Sequoia
    National Forest in California Earlier This Year.' The New York Times, 2021, 
    https://www.nytimes.com/2021/11/17/climate/climate-change-wildfire-risk.html."),
  strong("Code References:"),
  p("'Scatter Plots on Maps in R.' Plotly| Graphing Libraries, 
    https://plotly.com/r/scatter-plots-on-maps/."),
  h3("Appendix A:"),
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
