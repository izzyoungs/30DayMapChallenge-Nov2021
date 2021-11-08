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




