#-----------------------------------------------------------------------------------------------------------------------

# Create map for Columbia Caribou Support Tool

library(sf)
library(dplyr)
library(leaflet)
library(leaflet.extras)

# Load data
sf_herd_boundaries <- st_read("./data/SMC_Southern.shp") %>%
  st_transform(4326)

sf_contours <- st_read("./data/caribou25_contours_220719_POLYGONS.shp") %>%
  st_transform(4326)

sf_vri_10 <- st_read("./data/vri_10th_percentiled.shp") %>%
  st_transform(4326)
sf_vri_20 <- st_read("./data/vri_20th_percentiled.shp") %>%
  st_transform(4326)
sf_vri_30 <- st_read("./data/vri_30th_percentiled.shp") %>%
  st_transform(4326)
sf_vri_40 <- st_read("./data/vri_40th_percentiled.shp") %>%
  st_transform(4326)
sf_vri_50 <- st_read("./data/vri_50th_percentiled.shp") %>%
  st_transform(4326)
sf_vri_60 <- st_read("./data/vri_60th_percentiled.shp") %>%
  st_transform(4326)
sf_vri_70 <- st_read("./data/vri_70th_percentiled.shp") %>%
  st_transform(4326)
sf_vri_80 <- st_read("./data/vri_80th_percentiled.shp") %>%
  st_transform(4326)
sf_vri_90 <- st_read("./data/vri_90th_percentiled.shp") %>%
  st_transform(4326)

sf_contours_90 <- sf_contours %>% filter(isopleth == "90%")
sf_contours_80 <- sf_contours %>% filter(isopleth == "80%")
sf_contours_70 <- sf_contours %>% filter(isopleth == "70%")
sf_contours_60 <- sf_contours %>% filter(isopleth == "60%")
sf_contours_50 <- sf_contours %>% filter(isopleth == "50%")
sf_contours_40 <- sf_contours %>% filter(isopleth == "40%")
sf_contours_30 <- sf_contours %>% filter(isopleth == "30%")
sf_contours_20 <- sf_contours %>% filter(isopleth == "20%")
sf_contours_10 <- sf_contours %>% filter(isopleth == "10%")

map <- sf_herd_boundaries %>%
  leaflet() %>%
  addTiles() %>%
  addProviderTiles("Esri.WorldImagery",
                   group = "Satellite Imagery") %>%
  addFullscreenControl() %>%
  addResetMapButton() %>%
  addScaleBar(position = "bottomleft",
              options = scaleBarOptions(imperial = FALSE)) %>%
  addMeasure(position = "topleft",
             primaryLengthUnit = "meters",
             primaryAreaUnit = "sqmeters",
             secondaryLengthUnit = "kilometers",
             secondaryAreaUnit = "sqkilometers",
             activeColor = "cornflowerblue",
             completedColor = "cornflowerblue") %>%

  # Add polygon layers:

  # Herd boundaries
  addPolygons(color = "steelblue", weight = 2, smoothFactor = 0.2, opacity = 2,
              group = "Herd Boundaries",
              popup = paste0("Herd name: ", sf_herd_boundaries$HERD_NAME)) %>%

  # Contours
  addPolygons(data = sf_contours_10, color = "red", weight = 2, smoothFactor = 0.2, opacity = 2, fill = "red",
              group = "90th Percentile Contours",  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)) %>%

  addPolygons(data = sf_contours_80, color = "firebrick2", weight = 2, smoothFactor = 0.2, opacity = 2, fill = "firebrick2",
              group = "80th Percentile Contours",  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)) %>%

  addPolygons(data = sf_contours_70, color = "darkorange3", weight = 2, smoothFactor = 0.2, opacity = 2, fill = "darkorange3",
              group = "70th Percentile Contours",  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)) %>%

  addPolygons(data = sf_contours_60, color = "goldenrod", weight = 2, smoothFactor = 0.2, opacity = 2, fill = "goldenrod",
              group = "60th Percentile Contours",  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)) %>%

  addPolygons(data = sf_contours_50, color = "darkolivegreen1", weight = 2, smoothFactor = 0.2, opacity = 2, fill = "darkolivegreen1",
              group = "50th Percentile Contours",  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)) %>%

  addPolygons(data = sf_contours_40, color = "darkolivegreen3", weight = 2, smoothFactor = 0.2, opacity = 2, fill = "darkolivegreen3",
              group = "40th Percentile Contours",  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)) %>%

  addPolygons(data = sf_contours_30, color = "darkolivegreen4", weight = 2, smoothFactor = 0.2, opacity = 2, fill = "darkolivegreen4",
              group = "30th Percentile Contours",  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)) %>%

  addPolygons(data = sf_contours_20, color = "forestgreen", weight = 2, smoothFactor = 0.2, opacity = 3, fill = "forestgreen",
              group = "20th Percentile Contours",  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)) %>%

  addPolygons(data = sf_contours_10, color = "darkgreen", weight = 2, smoothFactor = 0.2, opacity = 3, fill = "darkgreen",
              group = "10th Percentile Contours",  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = FALSE)) %>%

  addPolygons(data = sf_vri_10, color = "darkgreen", weight = 1, smoothFactor = 0.2, opacity = 1, fill = "darkgreen",
              group = "10th Percentile VRI",  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE)) %>%

  addPolygons(data = sf_vri_20, color = "forestgreen", weight = 1, smoothFactor = 0.2, opacity = 1, fill = "forestgreen",
              group = "20th Percentile VRI",  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE)) %>%

  addPolygons(data = sf_vri_30, color = "forestgreen", weight = 1, smoothFactor = 0.2, opacity = 1, fill = "forestgreen",
              group = "30th Percentile VRI",  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE)) %>%

  #addPolygons(data = sf_vri_40, color = "darkolivegreen3", weight = 1, smoothFactor = 0.2, opacity = 1, fill = "darkolivegreen3",
              #group = "40th Percentile VRI",  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE)) %>%

  #addPolygons(data = sf_vri_50, color = "darkolivegreen1", weight = 1, smoothFactor = 0.2, opacity = 1, fill = "darkolivegreen1",
              #group = "50th Percentile VRI",  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE)) %>%

  #addPolygons(data = sf_vri_60, color = "goldenrod", weight = 1, smoothFactor = 0.2, opacity = 1, fill = "goldenrod",
              #group = "60th Percentile VRI",  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE)) %>%

  #addPolygons(data = sf_vri_70, color = "darkorange3", weight = 1, smoothFactor = 0.2, opacity = 1, fill = "darkorange3",
              #group = "70th Percentile VRI",  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE)) %>%

 # addPolygons(data = sf_vri_80, color = "firebrick2", weight = 1, smoothFactor = 0.2, opacity = 1, fill = "firebrick2",
              #group = "80th Percentile VRI",  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE)) %>%

  #addPolygons(data = sf_vri_90, color = "red", weight = 1, smoothFactor = 0.2, opacity = 1, fill = "red",
              #group = "90th Percentile VRI",  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE)) %>%

  # Add layers control
  addLayersControl(overlayGroups = c("Herd Boundaries",
                                     "Satellite Imagery",
                                     "90th Percentile Contours",
                                     "80th Percentile Contours",
                                     "70th Percentile Contours",
                                     "60th Percentile Contours",
                                     "50th Percentile Contours",
                                     "40th Percentile Contours",
                                     "30th Percentile Contours",
                                     "20th Percentile Contours",
                                     "10th Percentile Contours",
                                     "10th Percentile VRI",
                                     "20th Percentile VRI",
                                     "30th Percentile VRI"),
                                     #"40th Percentile VRI",
                                     #"50th Percentile VRI",
                                     #"60th Percentile VRI",
                                     #"70th Percentile VRI",
                                     #"80th Percentile VRI",
                                     #"90th Percentile VRI"),
                   options = layersControlOptions(collapsed = FALSE),
                   position = "topright")



# View map
map

# Save map
htmlwidgets::saveWidget(map, file = "./docs/contour-map.html", selfcontained = FALSE)









