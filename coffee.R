# Aim: create simple data frame and map for use in Geocomputation with R course
# Learn basic of R

# create object
x = 1:3
y = x^2

# plot objects
plot(x, y)

person_name = c("dani", "alistair", "robin")
n_coffee = c(10, 15, 6)
hometown = c("zaragoza", "edinburgh", "hereford")

likes_tea = c(TRUE, FALSE, FALSE)

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


#---------------------table by the window----------------
# recreation example
person_name <-
        c("olivia", "daniel", "phil", "claudia") # this is a vector (a series of vectors of the same class)

n_coffee <- c(7, 3, 10, 14)

hometown <- c("doncaster", "harlech", "pretoria", "mexico_city")

coffee_df_tbtw <- data.frame(person_name,
              n_coffee,
              hometown
              )
#---------------------------------------------------------

#added data from back table
name=c("Izzie","Greg", "Katherine", "Jeremy", "Kara")
coffee=c(2,3,5,2,0)
town=c("High Wickham","Budapest","Bristol","Chester","Buffalo")
new_coffee=data.frame(name,coffee,town)
new_coffee

#SANDRA_PAUL_MAGD

#create object
x=1:3
y=x^2

#plot objects
plot(x, y)

person_name = c("sandra", "Magd", "Paul")
n_coffee=c(1364,-533,2)
hometown=c("Triptis", "Damascus", "London")

person_name[n_coffee>= 0]


coffee_table_df = data.frame(
  person_name,
  n_coffee,
  hometown
)


#add more data
person_name <- c("Elle", "Nick", "Dan")
n_coffee <- c(3, 9, 20)
hometown <- c("London", "Cumbria", "Kent")
coffee_df <- data.frame(person_name, n_coffee, hometown)

#add in data 
person_name  = c("sam", "fazila","george", "david", "josh")
n_coffee = c(9, 0,15,10, 20)
hometown = c("london", "london","athens","carlisle","london")
likes_tea = c(TRUE,TRUE,TRUE,TRUE,FALSE)
class(person_name)
class(n_coffee)
class(hometown)

geotable = data.frame(
  person_name,
  n_coffee,
  hometown
)
