library(data.table)

esco_occupations_files <- list.files("data-raw/esco_bundle_occupations_1.0.3/", full.names = TRUE)

occupations_bundle <- fread(
    input = esco_occupations_files[grep("_en", esco_occupations_files)],
    keepLeadingZeros = TRUE,
    select = c("conceptUri", "iscoGroup", "preferredLabel", "altLabels", "description"),
    stringsAsFactors = FALSE,
    encoding = "UTF-8"
  )

occupations_bundle[, conceptUri := gsub(".*/", "", conceptUri)]


for(col in names(occupations_bundle)){
  set(occupations_bundle, j = col, value = iconv(occupations_bundle[[col]], from="UTF-8", to="ASCII" ))
}

usethis::use_data(occupations_bundle, overwrite = TRUE, compress = "xz")

