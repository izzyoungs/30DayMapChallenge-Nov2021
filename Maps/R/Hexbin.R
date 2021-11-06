# library
library(tidyverse)
library(geojsonio)
library(RColorBrewer)
library(rgdal)
library(broom)
library(rgeos)
library(viridis)
library(tidycensus)

# Download the Hexagones boundaries at geojson format here: https://team.carto.com/u/andrew/tables/andrew.us_states_hexgrid/public/map.

# Load this file. (Note: I stored in a folder called DATA)
spdf <- geojson_read("Maps/R/Data/us_states_hexgrid.geojson",  what = "sp")

# I need to 'fortify' the data to be able to show it with ggplot2 (we need a data frame format)
spdf@data = spdf@data %>% mutate(google_name = gsub(" \\(United States\\)", "", google_name))
spdf_fortified <- tidy(spdf, region = "google_name")

# Calculate the centroid of each hexagon to add the label:
centers <- cbind.data.frame(data.frame(gCentroid(spdf, byid=TRUE), id=spdf@data$iso3166_2))

ncsc <- read_csv("Maps/R/Data/ncsc.csv") %>%
  filter(`Data element` == "Total Judges") %>%
  group_by(State) %>%
  mutate(Response = as.numeric(Response)) %>%
  summarize(judges = sum(Response)) %>%
  select(state = State, judges)

pop <- get_decennial(geography = "state", 
                     variables = "P1_001N", 
                     year = 2020) %>%
  select(state = NAME, population = value)

ncsc_pop <- left_join(ncsc, pop) %>%
  mutate(judges_per_hundred_thousand = ifelse(judges == 0, 0, judges/(population/100000)))

spdf_fortified <- left_join(spdf_fortified, ncsc_pop, by=c("id"="state"))

spdf_fortified$bin <- cut(spdf_fortified$judges_per_hundred_thousand, breaks=5, labels=c("< 7", "7 - 8", "8 - 10", "12 - 15", "> 15"), include.lowest = TRUE)

my_palette <- magma(8)[c(-1,-8)]

# plot
# plot <- 
  ggplot() +
  geom_polygon(data = spdf_fortified, aes(fill = bin, x = long, y = lat, group = group) , size=2, alpha=0.9, color = "white") +
  geom_text(data=centers, aes(x=x, y=y, label=id), color="white", size=3, alpha=0.6, family = "mono") +
  theme_void() +
  scale_fill_manual( 
    values=my_palette, na.value="gray",
    name="Judges per 100,000 residents", 
    guide = guide_legend( keyheight = unit(3, units = "mm"), keywidth=unit(12, units = "mm"), label.position = "bottom", title.position = 'top', nrow=1) 
  ) +
  labs(title = "Judges per 100,000 Residents in each State",
       caption = "Data source: National Center for State Courts") +
  theme(legend.position = c(0.5, 0.9),
    text = element_text(color = "black", family="mono", size=12),
    plot.title = element_text(size= 22, hjust = 0.5, color = "black", margin = margin(b = -0.1, t = 0.4, l = 2, unit = "cm")),
    plot.background = element_rect(fill = "white", color = NA),
    plot.caption = element_text(hjust = 0.5)
  )

ggsave("Map-images/Judges.png")
