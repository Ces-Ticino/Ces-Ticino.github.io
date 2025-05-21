library(sf)
library(readxl)
library(stringr)
library(dplyr)
library(lubridate)
library(purrr)
library(forcats)
xlsx <- list.files("Fundmeldungen", "\\.xlsx", full.names = TRUE)


xlsx <- xlsx[str_detect(xlsx, "(DH_Flora_Vegetation_LV95.xlsx)|(Gesamtartenliste)", negate = TRUE)]


xlsx_df <- tibble(xlsx) |> 
  mutate(
    name = str_remove(str_remove(basename(xlsx), "\\.xlsx"), "DH_"),
    crs = case_when(
      str_detect(name, "WGS")~4326L,
      str_detect(name, "LV95")~2056L,
      str_detect(name, "LV03")~21781L
    ),
    name = str_remove(name, "_\\w$")
         )

xlsx_df

# xlsx_df$date_pattern <- list(
#   NA,
#   NA,
#   c("%d.%m.%Y %H:%M", "%d.%m.%Y", "%Y"),
#   "%d.%m.%Y","%d.%m.%Y",
#   "%d.%m.%Y",
#   "%d.%m.%Y",
#   "%d.%m.%Y"
#   )
# # 
# tribble(
#   ~name, ~date_pattern,
#   "Amphibien_und_Reptilien_WGS", NA,
#   "Flechten_CH_LV95", NA
#   "Fledermäuse_LV95",
#   "Flora_Vegetation_LV95",
#   "Heuschrecken_Libellen_Tagfalter_WGS",
#   "Kleinsäuger_LV95",
#   "Mollusken_LV03",
#   "Moose_LV03",
#   "Sirfidi-neurotteri-mecotteri_LV03",
#   "Wildbienenerhebung_LV95",
# )


xlsx_sf <- xlsx_df |> 
  pmap(\(xlsx, name, crs){
    # browser()
  xi <- read_xlsx(xlsx)
  mycol <- c("Artname_lateinisch", "x-Koord", "y-Koord", "Praezision_Koord", "Funddatum", "Gefaehrdungsstatus") 
  
  # browser()
  
  # xi$Funddatum
  # if(!any(is.na(date_pattern))){
  #   xi$Funddatum <- parse_date_time(xi$Funddatum, date_pattern)
  # }
  
  xi$Funddatum <- as.character(xi$Funddatum)
  
  for (newcol in mycol[!(mycol %in% colnames(xi))]){
    xi[[newcol]] <- NA
  }
    
  
  xi[,mycol] |> 
    filter(!is.na(`y-Koord`)) |> 
    st_as_sf(coords = c("x-Koord", "y-Koord")) |> 
    mutate(Praezision_Koord = as.character(Praezision_Koord)) |>
    janitor::clean_names() |> 
    mutate(gruppe = name) |> 
    st_set_crs(crs) |> 
    st_transform(2056)
}) |> 
  do.call(rbind, args = _)


coords <- st_coordinates(xlsx_sf)

# there is one coordinate outside Switzerland:
within_CH <- coords[,1] < 2840919 & coords[,1] > 2459984 & coords[,2] < 1317513 & coords[,2] > 1066593


xlsx_sf <- xlsx_sf[within_CH, ]

xlsx_sf$gruppe <- str_remove(xlsx_sf$gruppe, "_(CH_LV95|WGS|LV03|LV95|Publik)")

xlsx_sf <- xlsx_sf |> 
  mutate(
    gefaehrdungsstatus = factor(gefaehrdungsstatus,levels = c("CR(PE)", "EN", "VU", "NT"), ordered = TRUE),
    gefaehrdungsstatus = fct_na_value_to_level(gefaehrdungsstatus, "LC/NE/NA/DD")
  ) |> 
  arrange(gruppe, desc(gefaehrdungsstatus))


xlsx_sf2 <- split(xlsx_sf, xlsx_sf$gruppe)

cat(names(xlsx_sf2), sep = "\n")

imap(xlsx_sf2, ~write_sf(.x, "Fundmeldungen/Fundmeldungen.gpkg", .y, append = FALSE))

