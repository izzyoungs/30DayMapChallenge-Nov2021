library(tidyverse)
library(sf)
library(rgdal)
library(sfheaders)

dat <- readOGR( 
    dsn= paste0(getwd(),"/Raw/grey-wolf-shapefiles"), 
    layer="lines",
    verbose=FALSE
  )

dat2 <- st_as_sf(dat) %>% 
  filter(name == "35260-35260")


dat3 <- sf_to_df(dat2, fill = TRUE )

final_dat <- dat3 %>%
  mutate(string = paste0("[", x, ", ", y, "],")) %>%
  select(string) %>%
  slice(which(row_number() %% 65 == 1))

camera <- dat3 %>% 
  mutate(x = x + .1, 
         y = y + .1,
         string = paste0("[", x, ", ", y, "],")) %>%
  select(string) %>%
  slice(which(row_number() %% 65 == 1))
  



write_csv(final_dat, "Output/wolf-route.csv")

write_csv(camera, "Output/wolf-route-camera.csv")

