# Load the packages
library("dplyr")
library("tidyr")
library("ggplot2")

fee_df <- read.csv("Netflix _fee.csv") %>% 
  mutate(total_cost = Cost.Per.Month...Standard.... + Cost.Per.Month...Basic....) 


plot2 <- ggplot(fee_df , aes(x= Total_cost, y = Total.Library.Size)) +
  geom_point() +
  geom_smooth(method=lm , color="red", se=FALSE) 
  