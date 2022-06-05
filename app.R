library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(stringr)

tv_shows <- read.csv("/Users/SkyShen/final-projects-Subscription_sites/data/tv_shows.csv")
netflix_original <- read.csv("/Users/SkyShen/final-projects-Subscription_sites/data/tv_shows.csv")
fee_df <- read.csv("/Users/SkyShen/final-projects-Subscription_sites/data/Netflix _fee.csv")

#Extract the dataset Netflixoriginals into a dataframe called ratings_df for page 3.
ratings_df <- read.csv("NetflixOriginals.csv")

# We need this new dataset (df) which has code for each country to create interactive map in this project
df <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv")
fee_df <- merge(fee_df,df,by.x = "Country", by.y = "COUNTRY")

tv_shows <- tv_shows %>% 
  mutate (Rotten.Tomatoes = str_sub(tv_shows$Rotten.Tomatoes, end = -5),
          IMDb = str_sub(tv_shows$IMDb, end = -4))
filter_df <- tv_shows

#Add a new column to ratings_df called "Year" which is extracts only the year from the Premiere column. 
ratings_df$Year <- gsub(".*,","",ratings_df$Premiere)
ratings_per_genre <- ratings_df

# Introduction
intro_page <- tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  p("This......"),
  
  mainPanel(
      img(src = "pic1.png", height = 140, width = 400)
    )
)


# Page 1 code
filter_page <- tabPanel(
  "page 1",
  titlePanel("TV shows data"),
  p("This interactive page is about comparing the Rotten Tomatoes scores and IMDb scores on
    each straming platform. Users can filter Rotten Tomatoes score by draging sliders. Moreover,
    users can drag the point on the graph, so they can check the information of the point they
    chose by viewing table."),
  sidebarLayout(
    sidebarPanel(
      h5("Controls"),
      
      sliderInput(inputId = "rotten_tomatoes",
                  label = "Filter by Rotten Tomatoes score (Full score is 100)",
                  min = 0,
                  max = 100,
                  value = 70 #default value
      )
      ),

    mainPanel(
      plotOutput(outputId = "scatter", brush = "plot_brush"), # you can drag more than one point
      tableOutput(outputId = "data")
    )
  )
  )

# Page 2 code
map_page <- tabPanel(
  "page 2",
  titlePanel("The map of the Netflix subscription fee"),
  p("This is a map including the Netflix standard subscription fee in the world.
    Users can interact with the map by checking the fee geographically. Also, if users
    wish to know more information about each country, they can select a specific
    country in the box and get more information about that country such as the total
    number of movies in that country, the continent that country from, etc."),
  sidebarLayout(
    sidebarPanel(
      h3("Contro Panel"),
      selectInput(
        inputId = "char",
        label = "Select a country",
        choices = fee_df$Country
      )
    ),

mainPanel(
  world_map <- plot_ly(fee_df, type='choropleth',locations=fee_df$CODE,
                       z=fee_df$Cost.Per.Month...Standard...., text=fee_df$Country, colorscale="Red") %>% 
    colorbar(title = "Standard fee $") %>% 
    layout(title = 'Netflix subscription fee in the world'),
  
  tableOutput(outputId = 'table')
)
)
)

#Page 3 code
third_page <- tabPanel(
  "page 3",
  titlePanel("Netflix Originals' Ratings in Each Year Per Genre"),
  mainPanel(
    plotOutput(outputId = "scatter_2", brush = "brush_2"),
    tableOutput(outputId = "table_info")
  ),
  selectInput(
    inputId = "genre_movie",
    label = h3("Pick a Movie Genre"),
    choices = unique(ratings_df$Genre)
  )
)

#Conclusion
conclu_page <- tabPanel(
  "Conclusion",
  titlePanel("Conclusion"),
  p("This......")
)



# set up the UI

ui <- navbarPage(
  "Final Project",
  intro_page,
  filter_page,
  map_page,
  third_page,
  conclu_page
)

# server logic goes here 
server <- function(input, output){
  output$scatter <- renderPlot({
    filter_df <- filter(tv_shows, Rotten.Tomatoes >= input$rotten_tomatoes)
    ggplot(data = filter_df, aes(x = IMDb, y = Rotten.Tomatoes)) +
      geom_point(aes(col = Year)) +
      ggtitle("The comparionsn between Rotten.Tomatoes and IMDb")
  })
  
  output$data <- renderTable({
    brushedPoints(filter_df, input$plot_brush)
  })
  
  make_table_df <- function(char_name) {
    table_df <- select(fee_df, -c(Country, Country_code,Cost.Per.Month...Premium....,
                                  Cost.Per.Month...Basic....,CODE,GDP..BILLIONS.))
    
    data_pt <-  filter(fee_df, Country == char_name)
    data_pt <-  select(data_pt, -c(Country, Country_code,Cost.Per.Month...Premium....,
                                   Cost.Per.Month...Basic....,CODE,GDP..BILLIONS.))
    return(do.call("rbind", list(data_pt)))
  }
  
  output$table <- renderTable({
    return(make_table_df(input$char))
  })
}

# this is the function that makes the shiny app
shinyApp(ui = ui, server = server)
