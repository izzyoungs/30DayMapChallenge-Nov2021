# 30DayMapChallenge November 2021

## Day 1: Points // Day 2: Lines
 
![alt text](https://github.com/izzyoungs/30DayMapChallenge-Nov2021/blob/main/Map-images/Global%20Earthquake%20Activity.png "Global Earthquake Activity")

Created using ArcGIS Pro

## Day 3: Polygons

![alt text](https://github.com/izzyoungs/30DayMapChallenge-Nov2021/blob/main/Map-images/Hilo%20Building%20Footprints.png "Hilo, Hawaii Growth Boundary")

Created using ArcGIS Pro

## Day 4: Hexagons
 
[![alt text](https://github.com/izzyoungs/30DayMapChallenge-Nov2021/blob/main/Map-images/Hexagons.png "Average US Elevation")](https://izzy-youngs.com/pages/30daymapchallenge.html)

Created using Tableau Desktop

## Day 5: OpenStreetMap

![alt text](https://github.com/izzyoungs/30DayMapChallenge-Nov2021/blob/main/Map-images/osm-map.png "Amsterdam, Netherlands")

Created using R and `osmplotr`:

```
library(tidyverse)
library(osmplotr)

bbox <- get_bbox(c (4.963140, 52.389737, 4.893471, 52.415745))

available_features()

parks <- extract_osm_objects(key = "park", bbox = bbox)
landuse <- extract_osm_objects(key = "landuse", value = "grass", bbox = bbox)
highways <- extract_osm_objects(key = "highway", bbox = bbox)
water <- extract_osm_objects(key = "natural", value = "water", bbox = bbox)
sport <- water <- extract_osm_objects(key = "leisure", value = "golf_course", bbox = bbox)
buildings <- extract_osm_objects(key = "building", bbox = bbox)


map <- osm_basemap(bbox = bbox, bg = "#ffeddf") %>%
  add_osm_objects(., water, col = "#6bc3e7") %>%
  add_osm_objects(., parks, col = "#9cd295") %>%
  add_osm_objects(., landuse, col = "#c5cb69") %>%
  add_osm_objects(., highways, col = "#5d5d5c") %>%
  add_osm_objects(., sport, col = "#9cd295") %>%
  add_osm_objects(., buildings, col = "#e6a89b")
  

print_osm_map(map) +
  theme_void() +
  labs(title = "Day 05 // OpenStreetMap", 
       subtitle = "Amsterdam, Netherlands",
       caption = "Data from OpenStreetMap") +
  theme(plot.title = element_text(family = "mono", size=10, hjust = 0.5),
        plot.subtitle = element_text(family = "mono", size=14, face="bold", hjust = 0.5),
        plot.caption = element_text(color="gray20", family = "mono", size=8),
        plot.background = element_rect(fill = "#ffeddf"))

ggsave("Map-images/osm-map.png")
```