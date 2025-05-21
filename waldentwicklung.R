
# This script is used to clean the forest data and to create a new layer with the forest data and the CES data


library(sf)
library(stringr)
library(purrr)
library(tmap)

gpkg <- "Waldentwicklung/01_copped/ces.gpkg"
lyr <- st_layers(gpkg)

ces <- st_read(gpkg, "Ces")

lyrs <- lyr$name[startsWith(lyr$name, "Wald")]




names(lyrs) <- lyrs

wald_manual <- imap(lyrs, \(x,y) st_read(gpkg, x))

wald_cleaned <- imap(wald_manual, \(x, y){
  sfobj <-
    x |> 
    st_make_valid(geos_method = "valid_linework") |> 
    st_union() |> 
    # st_buffer(.5) |>    # this removes some artefacts for 1999
    # st_buffer(-.5) |> 
    st_as_sf()
  
  st_geometry(sfobj) <- "geom"
  sfobj <- sfobj[,"geom"]
  sfobj$jahr <- as.integer(str_remove(y, "Wald_"))
  
  st_intersection(sfobj, ces)
  
  # sfobj
  
  
})





# minimum_rotated_rectangle <- map(wald_cleaned, \(x)st_minimum_rotated_rectangle(st_union(st_make_valid(x))))
# 
# 

# minimum_rotated_rectangle2 <- reduce(minimum_rotated_rectangle, \(x,y)st_intersection(x,y)) |> 
#   st_minimum_rotated_rectangle()

imap(wald_cleaned, \(x,y){
  tm_shape(x,name = y) + tm_polygons(col = "red")
}) |>
  Reduce("+", x = _) 


# wald_harmonized <- map(wald_cleaned, \(x){st_intersection(x, minimum_rotated_rectangle)})
# 
# 

gpkg2 <- "Waldentwicklung/02_cleaned/ces.gpkg"

imap(wald_cleaned, \(x,y){st_write(x, gpkg2, y, append = FALSE)})

st_write(ces, gpkg2, "Ces", append = FALSE)









