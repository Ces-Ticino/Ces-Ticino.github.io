
library(stringr)
library(dplyr)
library(pandoc)
library(readr)
library(tidyr)
library(stringr)
# dirs <- list.dirs("Abgegebene_Berichte/Abgegebene_Berichte", recursive = FALSE)
docx <- list.files("Berichte_gesplittet", recursive = FALSE, full.names = TRUE)

# docx <- docx[str_detect(docx, "10|11")]


docx_df <-tibble(docx) |> 
  mutate(
    thema = str_remove(basename(docx), "\\.docx"),
    thema_clean = str_remove(str_replace_all(thema, "_", " "), "\\w+\\s\\d{2}\\s")
  )




write_csv(docx_df, "docx_df.csv",col_names = FALSE)







