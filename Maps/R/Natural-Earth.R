library(tidyverse)
library(here)
library(ggplot2)
library(ggthemes)
library(rgdal)
library(broom)

ne <- readOGR( 
  dsn= paste0(getwd(),"/Raw/ne_110m_admin_0_countries_lakes"), 
  layer="ne_110m_admin_0_countries_lakes",
  verbose=FALSE
  )

ne_fortified <- tidy(ne, region = "NAME")



ne_fortified %>% glimpse

ggplot() +
  geom_polygon(data = ne_fortified, aes(fill = "fill col", x = long, y = lat, group = group), 
               color="grey") +
  theme_void() +
  coord_map() +
  theme(legend.title = element_blank())


