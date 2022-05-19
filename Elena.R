library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggpubr)

runtime <- read.csv("/Users/elenawhelan/Desktop/INFO-201/final-projects-Subscription_sites/data/NetflixOriginals.csv")
head(runtime)
colnames(runtime)
sum(duplicated('runtime'))
sum(is.na('runtime'))

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

ggplot(data = most_viewed) + geom_bar(mapping = aes(x = Genre , fill = IMDB.Score)) +
  labs(title = " Most viewed movie Genre") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 0.5))
