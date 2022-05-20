library("dplyr")
library("tidyr")

fee_df <- read.csv("Netflix _fee.csv") %>% 
  mutate(total_fee = Cost.Per.Month...Standard.... + Cost.Per.Month...Basic....)

each_county_info <- fee_df %>% 
  group_by(Continent) %>% 
  summarise(mean_fee <- mean(total_fee),max_fee <- max(total_fee),
            min_fee <- min(total_fee), mean_num_movie <- mean(No..of.Movies),
            max_num_movie <- max(No..of.Movies),min_num_movie <- min(No..of.Movies))
  