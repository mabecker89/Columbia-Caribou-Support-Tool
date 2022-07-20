#-----------------------------------------------------------------------------------------------------------------------

# Create map for Columbia Caribou Support Tool

library(sf)
library(dplyr)
library(leaflet)
library(leaflet.extras)

# Load data
sf_herd_boundaries <- st_read("./data/SMC_Southern.shp") |>
  st_transform(4326)

sf_contours <- st_read("./data/UD_contours_polygon_albers.shp") |>
  st_transform(4326)

sf_contours_95 <- sf_contours |> filter(pctile == "95")
sf_contours_75 <- sf_contours |> filter(pctile == "75")
sf_contours_50 <- sf_contours |> filter(pctile == "50")
sf_contours_25 <- sf_contours |> filter(pctile == "25")
sf_contours_21 <- sf_contours |> filter(pctile == "21")
sf_contours_2 <- sf_contours |> filter(pctile == "2")

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
              popup = paste0("Herd name: ", sf_herd_boundaries$HERD_NAME)) |>

  # Contours
  addPolygons(data = sf_contours_95, color = "red", weight = 2, smoothFactor = 0.2, opacity = 2, fill = FALSE,
              group = "95th Percentile Contours") |>

  addPolygons(data = sf_contours_75, color = "red", weight = 2, smoothFactor = 0.2, opacity = 2, fill = FALSE,
              group = "75th Percentile Contours") |>

  addPolygons(data = sf_contours_50, color = "red", weight = 2, smoothFactor = 0.2, opacity = 2, fill = FALSE,
              group = "50th Percentile Contours") |>

  addPolygons(data = sf_contours_25, color = "red", weight = 2, smoothFactor = 0.2, opacity = 2, fill = FALSE,
              group = "25th Percentile Contours") |>

  addPolygons(data = sf_contours_21, color = "red", weight = 2, smoothFactor = 0.2, opacity = 2, fill = FALSE,
              group = "21st Percentile Contours") |>

  addPolygons(data = sf_contours_2, color = "red", weight = 2, smoothFactor = 0.2, opacity = 2, fill = FALSE,
              group = "2nd Percentile Contours") |>

  # Add layers control
  addLayersControl(overlayGroups = c("Herd Boundaries",
                                     "95th Percentile Contours",
                                     "75th Percentile Contours",
                                     "50th Percentile Contours",
                                     "25th Percentile Contours",
                                     "21st Percentile Contours",
                                     "2nd Percentile Contours"),
                   options = layersControlOptions(collapsed = FALSE),
                   position = "topright")


map








