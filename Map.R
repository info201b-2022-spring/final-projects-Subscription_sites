# Load the packages
library("dplyr")
library("tidyr")
library("ggplot2")

blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),        
    axis.text = element_blank(),        
    axis.ticks = element_blank(),     
    axis.title = element_blank(),     
    plot.background = element_blank(),  
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(),
    panel.border = element_blank()      
  )

fee_df <- read.csv("Netflix _fee.csv") %>% 
  mutate(total_cost = Cost.Per.Month...Standard.... + Cost.Per.Month...Basic....)

world_shape <- map_data("world") %>% 
  rename(Country = region) %>% 
  left_join(fee_df, by="Country") 

map_plot <- ggplot(world_shape) +
  geom_polygon(
    mapping = aes(x = long, y = lat, group = group, fill = total_cost),
    color = "white", 
    size = .1        
  ) +
  coord_map() + 
  scale_fill_continuous(low = "#132B43", high = "Red") +
  labs(title = "The subscription fee of Netflix in the world", fill = "Subscription fee $") +
  blank_theme
