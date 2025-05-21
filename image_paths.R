
library(purrr)
images <- list.files("Abgegebene_Berichte/Abgegebene_Berichte", pattern = "JPG|jpg|JPEG|jpeg|png|PNG", recursive = TRUE, full.names = TRUE)


images_bn <- basename(images)

# are any duplicates?
any(duplicated(images_bn))

# which ones? are they the same?
images[images_bn %in% images_bn[(duplicated(images_bn))]]
# yes

file.copy(images, file.path("images",images_bn))

# now, in VSCode / Positron, search for 
# (.+.(jpe?g|JPE?G))\s(.+)
# and replace with
# ![$3](/images/$1)\n
# only inlucding
# tmpdir/02


