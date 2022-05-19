
library("dplyr")
library("tidyr")

fee_df <- read.csv("Netflix _fee.csv")

each_state_fee <- fee_df %>% 
  group_by(Continent) %>% 
  summarize(mean = mean(Cost.Per.Month...Standard....))