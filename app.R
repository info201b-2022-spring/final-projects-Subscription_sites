library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(stringr)

tv_shows <- read.csv("tv_shows.csv")
fee_df <- read.csv("Netflix _fee.csv")

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
  
  mainPanel(
      img(src = "pic1.png", height = 200, width = 800)
    ),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  br(),
  p("For this project, we created a shiny application dedicated to allowing users to explore our chosen datasets through engaging visualisations and interactions. We chose these datasets as we felt it would be insightful to gather and display data about the variety of streaming platforms (Netflix, Hulu etc.) we use today, and to showcase this to our peers. We wanted to explore this further by answering three major questions through interactive datasets:"),
  
  em("1.	TV Show Dataset: What are the highest scored movies based on IMDB and Rotten Tomatoes’ scores and what streaming platforms are they available on?"), 

  p("Using this interactive scatterplot, we can effectively study what movies scored highest and where they are available for customers to watch. We can tailor our searches by using the “Filter by Rotten Tomatoes score” control. In order to discover the names and streaming platforms of these movies, we simply must highlight the area of interest on the scatterplot, which will return a chart of information about these movies."), 

  em("2.	Subscription Fee Dataset: What is the standard Netflix subscription fee ($/month) in different countries of the world?"),
  
  p("This world map visualisation helps us to understand the different Netflix subscription fees in US dollars depending on whereabouts you are in the world. The legend to the right of the map shows the different prices per month, through colour coding price to country. By simply hovering over a country, we can see how much their monthly subscription fee is for Netflix customers, e.g.: $12.12 per month for customers in Australia."), 
  
  em("3.  Netflix Originals Dataset: How did Netflix Original TV show/ movie rate as an IMDB score based on their genre?"),

  p("Using our third interactive page, we are using a scatterplot to study the relationship between the genre of a Netflix Original TV show or movie and how well it did as an IMDB rating each year. There is a select box underneath the graph that allows the user to choose a specific genre to study. There is also a brush argument that allows users to view the data they have selected in the form of a separate table, allowing a more clear view of the information this dataset provides."),
  
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
   p("This third interactive page explores the relationship between the genre of a 
    TV show/movie and how well it does in terms of reviews. There is a select box provided
    for the user to specify which genre's data they would like to view on the graph, and the use
    of the brush argument lets users view the selected data in the form of a table (as a subset
    of the entire dataset). The ideal way to view this data (compare the rating trends across 
    different genres) is to look at the boxplots for each year in a particular genre, get a 
    sense of the trend in median values across the years, and then do the same for another genre
    that you want to compare to."),
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
  p("From our analysis of our three datasets, we gathered the following major takeaways that we found in each our interactive pages:"),
  
  em("TV Show Dataset:"),
  
  p("We found that the Rotten Tomatoes scores were positively correlated to the IMDB scores. As Rotten Tomatoes scores increased, so did that of the IMDB scores."), 
  
  em("Subscription Fee Dataset:"),
  
  p("We noticed that developed countries had a higher subscription fee per month than that of developing counties. We assume this is down to the fact that Netflix subscribers in developing countries have lower incomes, resulting in lower subscription fees. The most expensive subscription fees are in central Europe, with a total fee cost of $33.34 per month. The cheapest are in Asia, with a total fee cost of $4.97 per month."), 
  
  em("Netflix Originals Dataset:"),
  
  p("We discovered that the genre of a movie/ tv show is in fact correlated to it’s probable IMDB rating. For example, documentaries, on average, have a high rating (around 8/10) whereas comedy shows/ movies have a much lower rating (median values generally lie between 5-6/10)."),
  
  )
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
  
  output$scatter_2 <- renderPlot({
    ratings_per_genre <- filter(group_by(ratings_df, Year), Genre == input$genre_movie) 
    ggplot(data = ratings_per_genre, aes(x = Year, y = IMDB.Score)) +
      geom_point(aes(col = Runtime)) +
      geom_smooth(method='lm', formula = y ~ x) +
      geom_boxplot() + 
      geom_boxplot(outlier.shape = NA) + 
      geom_jitter(width = 0.2)
  })
  
  output$table_info <- renderTable({
    brushedPoints(filter(ratings_per_genre, ratings_per_genre$Genre == input$genre_movie), input$brush_2)
  })
}

# this is the function that makes the shiny app
shinyApp(ui = ui, server = server)
