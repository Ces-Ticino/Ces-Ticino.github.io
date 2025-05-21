library(sf)
library(tmap)
library(purrr)


layers <- c("Wald_1961", "Wald_1999", "Wald_2021")
names(layers) <- layers
gpkg <- "Waldentwicklung/02_cleaned/ces.gpkg"

lebensraum <- "Waldentwicklung/Lebensraumkartierung/Lebensraumkartierung.gpkg"


lebensraum_f <- st_read(lebensraum, "Flaechen")
lebensraum_l <- st_read(lebensraum, "Linien")

lebensraum_p <- st_read(lebensraum, "Punkte")



wald_l <- imap(layers, \(x,y)read_sf(gpkg, x))


tmap_mode("view")
tm_shape(lebensraum_f, name = "Typ") +
  tm_polygons(
    fill = "Broschüre", 
    fill.scale = tm_scale_categorical(),
    fill.legend = tm_legend("Lebensräume")) +
  tm_shape(wald_l$Wald_2021, name = "Wald 2021") +
  tm_polygons(fill = "#059600") +
  tm_shape(wald_l$Wald_1999, name = "Wald 1999") +
  tm_polygons(fill = "#066301") +
  tm_shape(wald_l$Wald_1961, name = "Wald 1961") +
  tm_polygons(fill = "#023000") +
  tm_shape(lebensraum_l) + 
  tm_lines(lty = "Broschüre", 
           col = "Broschüre", 
           col.legend = tm_legend(show = FALSE),
           lty.legend = tm_legend("Linien")) +
  tm_shape(lebensraum_p) +
  tm_dots(col = "Broschüre")
  
