# Aim: create simple data frame and map for use in Geocomputation with R course
# Learn basic of R

# create object
x = 1:3
y = x^2

# plot objects
person_name  = c("Humphrey", "James", "Harvinder", "Tom")
n_coffee =  c(9, 7, 0, 5)
home_town = c("Worcester",  "Cheltenham", "Hayes", "Luton")

likes_tea = c(TRUE, FALSE, FALSE, TRUE)

class(person_name)
class(n_coffee)
class(likes_tea)

person_name[1:2]
person_name[likes_tea]
person_name[n_coffee >= 10]

coffee_df = tibble::tibble(
  person_name,
  n_coffee,
  hometown
)

coordinates = tmaptools::geocode_OSM(coffee_df$hometown)

coffee_df = tibble::tibble(
  person_name,
  n_coffee,
  hometown,
  lon = coordinates$lon,
  lat = coordinates$lat
)

library(sf)
coords = c("lon", "lat")
coffee_sf = st_as_sf(coffee_df, coords = coords)

library(tmap)
tmap_mode("view")
tm_shape(coffee_sf) + tm_dots()

write.csv(coffee_df, "coffee.csv")

#added data from back table
name=c("Izzie","Greg", "Katherine", "Jeremy", "Kara")
coffee=c(2,3,5,2,0)
town=c("High Wickham","Budapest","Bristol","Chester","Buffalo")
new_coffee=data.frame(name,coffee,town)
new_coffee
