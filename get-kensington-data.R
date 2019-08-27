# Aim: get and upload data from near the RGS in london

# See https://www.openstreetmap.org/query?lat=51.50145&lon=-0.17489

library(sf)
library(pct)
library(tmap)
library(stats19)
library(osmdata)
osm_res = opq(bbox = "london") %>% 
  add_osm_feature(key = "name", value = "Royal Geographical Society") %>% 
  osmdata_sf()
rgs_building = osm_res$osm_polygons

plot(rgs_building)
mapview::mapview(rgs_building)

# create buffer
rgs_building_buffer = rgs_building %>% 
  st_transform(27700) %>% 
  st_buffer(1000) %>% 
  st_transform(4326)

plot(rgs_building_buffer$geometry)
plot(rgs_building$geometry, add = TRUE)

crashes = get_stats19(year = 2017, type = "ac")
casualties = get_stats19(year = 2017, type = "ca")
crashes_joined = dplyr::left_join(crashes, casualties)

class(crashes_joined)
crashes_geo = format_sf(crashes_joined, lonlat = TRUE)
class(crashes_geo)
crashes_geo

crashes_near_rgs =
  crashes_geo[rgs_building_buffer, ]
nrow(crashes_near_rgs)

table(crashes_near_rgs$casualty_type)

tmap_mode("view")

tm_shape(crashes_near_rgs) +
  tm_dots("accident_severity")

rf = pct::get_pct_routes_fast(region = "london")

rf_near_rgs = rf[rgs_building_buffer, ]
rf_near_rgs

plot(rf_near_rgs)

rnet_rgs = stplanr::overline2(rf_near_rgs, "dutch_slc")

tm_shape(crashes_near_rgs) +
  tm_dots("accident_severity") +
  tm_shape(rnet_rgs) +
  tm_lines(lwd = "dutch_slc", col = "blue", alpha = 0.5, scale = 8)

zones = get_pct_zones(region = "london")
zones_near_rgs = zones[rgs_building_buffer, ]
plot(zones_near_rgs)

library(osmdata)
kensington = getbb("kensington, london")
osm_data = opq(bbox = kensington) %>% 
  add_osm_feature(key = "leisure", value = "park") %>% 
  osmdata_sf()
parks = osm_data$osm_polygons

# save data ---------------------------------------------------------------

write_sf(rgs_building, "rgs_building.geojson")
write_sf(rgs_building_buffer, "rgs_building_buffer.geojson")
write_sf(crashes_near_rgs, "crashes_near_rgs.geojson")
write_sf(zones_near_rgs, "zones_near_rgs.geojson")
write_sf(parks, "parks.geojson")

saveRDS(rnet_rgs, "rnet_rgs.rds")
piggyback::pb_upload("rnet_rgs.rds")
