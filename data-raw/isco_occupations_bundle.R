library(data.table)

isco_occupations_files <- list.files("data-raw/isco_bundle_occupations_1.0.3/", full.names = TRUE)

isco_occupations_bundle <- fread(
    input = isco_occupations_files[grep("_en", isco_occupations_files)],
    keepLeadingZeros = TRUE,
    select = c("code", "preferredLabel"),
    stringsAsFactors = FALSE,
    encoding = "UTF-8",
    data.table = TRUE
  ) %>%
  setnames("code", "iscoGroup")

for(col in names(isco_occupations_bundle)){
  set(isco_occupations_bundle, j = col, value = iconv(isco_occupations_bundle[[col]], from="UTF-8", to="ASCII" ))
}

isco_occupations_bundle[, iscoGroup := iconv(iscoGroup, from="UTF-8", to="ASCII")]
usethis::use_data(isco_occupations_bundle, overwrite = TRUE, compress = "xz")

