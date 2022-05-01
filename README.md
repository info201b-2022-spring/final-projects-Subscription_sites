# final-projects-Subscription_sites
final-projects-Subscription_sites created by Sky Shen, Sarah Dicker, and Elena Whelan.


Domain of interest
As we've discussed, data science can expose underlying patterns in any domain that uses or collects data (which is nearly any domain). Anything from the forced relocation of homeless individuals (Links to an external site.) to how people gender representation (Links to an external site.) in the media, data can expose interesting (and actionable) patterns. In this section, you'll identify a domain that you are interested in (e.g., music, education, dance, immigration -- any field of your interest) and answer the following questions in your README.md file:

- Why are you interested in this field/domain?

We are interested in this domain because it is something that each of us use in our daily lives among with millions of other people around the world. We believed it would be insightful to gather data about these platforms and share it with our peers. Netflix was the first streaming service of its kind to produce original movies and as it continues to grow and hold a dominant position in this field we were intrigued to analyse its data in greater detail.
We also chose to explore the available movies across other sites so we could discover the advantages and disadvantages of each site in comparison to one another. 

- What other examples of data driven project have you found related to this domain (share at least 3)?

https://businesschronicler.com/swot/netflix-swot-analysis/#:~:text=In%202020%2C%20Netflix%20had%20annual,98.48%25%20from%20the%20previous%20year

https://www.tomsguide.com/us/best-streaming-video-services,review-2625.html

https://towardsdatascience.com/data-analysis-on-ott-platforms-which-service-should-i-choose-8eed953ff7d2

- What data-driven questions do you hope to answer about this domain (share at least 3)?
Which country requires the highest subscription price to avail of Netflix?
What is the Netflix price distribution across each of the countries?
Does Netflix or Disney offer more movies to their customers? 
Which sites offers the most movies?
Which Netflix original movie has scored the highest on IMDB ratings? 


Finding Data
We are lucky enough to live in a time when there is lots of publicly available data made possible by governments, journalists, academics, and companies. In this section, you will identify and download at least 3 sources of data related to your domain of interest described above (into a folder you create called data/). You won't be required to use all of these sources, but it will give you practice discovering data. If your data is made available through a Web API, you don't need to download it. For each source of data, provide the following information:

- Where did you download the data (e.g., a web URL)?
  
  We found datasets from the Kaggle. The links for each dataset are below:
  
1. https://www.kaggle.com/datasets/prasertk/netflix-subscription-price-in-different-countries

2. https://www.kaggle.com/datasets/ruchi798/movies-on-netflix-prime-video-hulu-and-disney

3. https://www.kaggle.com/datasets/luiscorter/netflix-original-films-imdb-scores

- How was the data collected or generated? Make sure to explain who collected the data (not necessarily the same people that host the data), and who or - - what the data is about?

- How many observations (rows) are in your data?
Our first dataset holds 66 observations, our second dataset

- How many features (columns) are in the data?

- What questions (from above) can be answered using the data in this dataset?

1. Our first dataset explores which countries paid the most and least for Netflix in 2021. The data was collected by Rebecca Moody, head of data research at Comparitech. In order to collect this data Rebecca first uncovered the figures based on the number of movies and TV shows available in 81 different countries. She also evaluated the cost per month of Netflix in each of these countries and how they compared to one another. This dataset holds 66 observations and 9 features. From this dataset we can answer what the basic, standard, and premium subscription price is relevant to the total library size of each country. 

2. Our second dataset offers a comprehensive list of all of the movies made available across the streaming services Netflix, Hulu, Prime Video and Disney+. The dataset creator, Ruchi Bhatia scraped the data from the various streaming platforms. This dataset contains 5,369 observations and 11 features. This dataset will allowus to answer which streaming site provides a particular movie as well as the movie's corresponding target age group, the year it was produced and its overall score on Rotten Tomatoes. 

3. Our third datset analyses all of Netflix's original films and their corresponding IMDB scores. Luis, the dataset creator scraped the list of all Netlfix original films off of a Wikipedia page and integrated it with another datset consisting of their IMDB scores. This dataset has 585 observations and 6 features. This dataset can answer a number of questions about a film including the genre, the date it premiered, its total runtime in minutes, its IMDB score as of 2021 and the languages it is available to watch in as of 2021. 

