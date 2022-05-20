library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggpubr)

runtime <- read.csv("/Users/elenawhelan/Desktop/INFO-201/final-projects-Subscription_sites/data/NetflixOriginals.csv")
head(runtime)
colnames(runtime)

sum(duplicated('runtime'))
sum(is.na('runtime'))

summary(runtime)
#The above code gives us following information:
  #1. The total amount movies (unique observations) are 584.
  #2. The Maximum IMDB score of the movies is 9 and the minimum is 2.5
  #3. The Maximum Runtime for the movies is 209 and the average is 93.58

#amount of movies per genre
genre_num <- runtime %>%
  group_by(Genre) %>%
  summarize(number_of_films = n()) %>%
  arrange(desc(number_of_films))
head(movie_score)

#filtering data to score >= 6 & most viewed movie genre
most_viewed <- runtime %>%
  filter(IMDB.Score >= 6)
head(most_viewed)

#Vizualizing the correlation between two variables: Movie Runtime and IMDB Score 
ggscatter(most_viewed, x = "Runtime", y = "IMDB.Score", 
          add = "reg.line", conf.int = TRUE, 
          cor.coef = TRUE, cor.method = "pearson",
          xlab = "Movie Runtime", ylab = "IMDB Score")
#from this plot we can see that there is no correlation
