library(data.table)
library(magrittr)

esco_occupations_files <- list.files("data-raw/esco_bundle_occupations_1.0.3/", full.names = TRUE)
names(esco_occupations_files) <- get_language_code(esco_occupations_files)

esco_bundle <- lapply(esco_occupations_files, function(path){
  fread(
    input = path,
    keepLeadingZeros = TRUE,
    select = c("conceptUri", "iscoGroup", "preferredLabel", "altLabels"),
    stringsAsFactors = FALSE,
    encoding = "UTF-8"
  )
}) %>% rbindlist(idcol = TRUE)

esco_bundle[, conceptUri := gsub(".*/", "", conceptUri)]
esco_bundle[, altLabels := ifelse(is.na(altLabels), "", altLabels)]
esco_bundle[, text := paste(preferredLabel, altLabels)]
setnames(esco_bundle, ".id", "language")
occupations_bundle <- esco_bundle[, .(language, conceptUri, iscoGroup, text)]

usethis::use_data(occupations_bundle, compress = "xz", overwrite = TRUE)
