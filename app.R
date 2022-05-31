library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)
library(stringr)

tv_shows <- read.csv("/Users/SkyShen/final-projects-Subscription_sites/data/tv_shows.csv")
#netflix_original <- read.csv("/Users/SkyShen/final-projects-Subscription_sites/data/tv_shows.csv")
fee_df <- read.csv("/Users/SkyShen/final-projects-Subscription_sites/data/Netflix _fee.csv")

# We need this new dataset (df) which has code for each country to create interactive map in this project
df <- read.csv("https://raw.githubusercontent.com/plotly/datasets/master/2014_world_gdp_with_codes.csv")
fee_df <- merge(fee_df,df,by.x = "Country", by.y = "COUNTRY")

tv_shows <- tv_shows %>% 
  mutate (Rotten.Tomatoes = str_sub(tv_shows$Rotten.Tomatoes, end = -5),
          IMDb = str_sub(tv_shows$IMDb, end = -4))
filter_df <- tv_shows

# Introduction
intro_page <- tabPanel(
  "Introduction",
  titlePanel("Introduction"),
  p("This......")
)

# Page 1 code
filter_page <- tabPanel(
  "page 1",
  titlePanel("TV shows data"),
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
      tableOutput(outputId = "data"),
    )
  )
  )

# Page 2 code
map_page <- tabPanel(
  "page 2",
mainPanel(
  world_map <- plot_ly(fee_df, type='choropleth',locations=fee_df$CODE,
                       z=fee_df$Cost.Per.Month...Standard...., text=fee_df$Country, colorscale="Red") %>% 
    colorbar(title = "Standard fee $") %>% 
    layout(title = 'Netflix subscription fee in the world')
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
  conclu_page
)

# server logic goes here 
server <- function(input, output){
  
  output$scatter <- renderPlot({
    #filter_df <- filter(tv_shows, IMDb >= input$imdb)
    filter_df <- filter(tv_shows, Rotten.Tomatoes >= input$rotten_tomatoes)
    ggplot(data = filter_df, aes(x = IMDb, y = Rotten.Tomatoes)) +
      geom_point(aes(col = Year))
  })
  
  
  
  output$data <- renderTable({
    brushedPoints(filter_df, input$plot_brush)
  })
}


# this is the function that makes the shiny app

shinyApp(ui = ui, server = server)