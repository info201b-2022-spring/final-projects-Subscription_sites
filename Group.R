
library("dplyr")
library("tidyr")

fee_df <- read.csv("Netflix _fee.csv")

each_state_info <- fee_df %>% 
  mutate(total_cost = Cost.Per.Month...Standard.... + Cost.Per.Month...Basic....) %>% 
  group_by(Continent) %>% 
  summarize(mean_cost = mean(total_cost),mean_size = mean(Total.Library.Size)) %>% 
  arrange(-mean_cost)
  