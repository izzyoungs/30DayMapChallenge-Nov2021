library(tidyverse)
library(sf)
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
  select(string)

write_csv(final_dat, "Output/wolf-route.csv")
