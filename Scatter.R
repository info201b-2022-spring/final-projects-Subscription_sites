library(tidyverse)
library(dplyr)
library(ggplot2)
library(ggpubr)

runtime <- read.csv("/Users/elenawhelan/Desktop/INFO-201/final-projects-Subscription_sites/data/NetflixOriginals.csv")
head(runtime)
colnames(runtime)

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
