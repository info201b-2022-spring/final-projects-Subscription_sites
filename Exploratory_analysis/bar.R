library("dplyr")
library("tidyverse")

ratings_df <- read.csv("Downloads/tv_shows.csv")

grouped <- group_by(filter(ratings_df, Year >= 2015), Year)

each_year_ratings <- summarize(
  grouped,
  total_90_plus = length(Rotten.Tomatoes >= 90/100)
)

#bar_plot <- barplot(each_year_ratings$total_90_plus, names = each_year_ratings$Year,
#                                   main = "Number of movies rated 90%+ per year (after 2015)", 
#                                   xlab = "Year", ylab = "No. movies with 90%+ rating")

#The above block of code seems to print the bar plot while simply sourcing the file in the initial lines of the .rmd file, so instead of putting it here
#we've added this code to the .rmd file as that seems to work better.
