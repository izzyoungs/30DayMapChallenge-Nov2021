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

## Day 6: Red // Day 7: Green // Day 8: Blue // Day 9: Monochrome

![alt text](https://github.com/izzyoungs/30DayMapChallenge-Nov2021/blob/main/Map-images/osm-red-blue-green-map.png "Reno, NV")

Created using R and `osmplotr`:

```
library(tidyverse)
library(osmplotr)
library(osmdata)
library(gridExtra)
library(grid)

reno <- get_bbox(c (-119.868203, 39.549925, -119.745688, 39.476285))


reno_highways <- extract_osm_objects(key = "highway", value = "motorway", bbox = reno)
reno_residential <- extract_osm_objects(key = "highway", value = "!motorway", bbox = reno)
reno_water <- extract_osm_objects(key = "water", bbox = reno)
reno_buildings <- extract_osm_objects(key = "building", bbox = reno)
reno_parks <- extract_osm_objects(key = "leisure", value = "park", bbox = reno)


reno_streets_map <- osm_basemap(bbox = reno, bg = "#eddbc3") %>%
  add_osm_objects(., reno_residential, col = "#dddddd", size = .25) %>%
  add_osm_objects(., reno_highways, col = "#b72a1b", size = .5) +
  theme_void() + 
  labs(subtitle = "Highways in Reno, NV") +
  theme(plot.title = element_text(family = "mono", size=10, hjust = 0.5),
        plot.subtitle = element_text(family = "mono", size=10, face="bold", hjust = 0.5),
        plot.caption = element_text(color="gray20", family = "mono", size=8),
        plot.background = element_rect(fill = "white", color = "white"))

reno_water_map <- osm_basemap(bbox = reno, bg = "#eddbc3") %>%
  add_osm_objects(., reno_residential, col = "#dddddd", size = .25) %>%
  add_osm_objects(., reno_water, col = "#00b5e2") +
  theme_void() + 
  labs(subtitle = "Water in Reno, NV") +
  theme(plot.title = element_text(family = "mono", size=10, hjust = 0.5),
        plot.subtitle = element_text(family = "mono", size=10, face="bold", hjust = 0.5),
        plot.caption = element_text(color="gray20", family = "mono", size=8),
        plot.background = element_rect(fill = "white", color = "white"))

reno_parks_map <- osm_basemap(bbox = reno, bg = "#eddbc3") %>%
  add_osm_objects(., reno_residential, col = "#dddddd", size = .25) %>%
  add_osm_objects(., reno_parks, col = "#4caf50") +
  theme_void() + 
  labs(subtitle = "Greenspace in Reno, NV") +
  theme(plot.title = element_text(family = "mono", size=10, hjust = 0.5),
        plot.subtitle = element_text(family = "mono", size=10, face="bold", hjust = 0.5),
        plot.caption = element_text(color="gray20", family = "mono", size=8),
        plot.background = element_rect(fill = "white", color = "white"))

reno_buildings_map <- osm_basemap(bbox = reno, bg = "#eddbc3") %>%
  add_osm_objects(., reno_buildings, col = "grey20") %>%
  add_osm_objects(., reno_residential, col = "#dddddd", size = .25) +
  theme_void() + 
  labs(subtitle = "Buildings in Reno, NV") +
  theme(plot.title = element_text(family = "mono", size=10, hjust = 0.5),
        plot.subtitle = element_text(family = "mono", size=10, face="bold", hjust = 0.5),
        plot.caption = element_text(color="gray20", family = "mono", size=8),
        plot.background = element_rect(fill = "white", color = "white"))


g <- arrangeGrob(reno_streets_map, reno_parks_map, reno_water_map, reno_buildings_map,
                 ncol = 2, 
                 top = textGrob("Day 06: Red // Day 07: Green // Day 08: Blue // Day 09: Monochrome",
                                gp = gpar(fontsize=8,fontfamily = "mono")), 
                 bottom = textGrob("Data from OpenStreetMap",
                                   gp = gpar(fontsize=6,fontfamily = "mono")))

ggsave(file="Map-images/osm-red-blue-green-map.png", g)
```
