library(data.table)
library(magrittr)

esco_occupations_files <- list.files("data-raw/esco_bundle_occupations_1.0.3/", full.names = TRUE)
esco_languages <- get_language_code(esco_occupations_files)
names(esco_occupations_files) <- esco_languages

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

tfidf_tokens <- lapply(esco_languages, function(lang){
  corpus <- occupations_bundle[language == lang, list(conceptUri, text)]
  corpus[, text := cleansing_corpus(text)]
  tf_idf(corpus, id_col = "conceptUri", stopwords = get_stopwords(lang))
})
names(tfidf_tokens) <- esco_languages

tfidf_tokens %<>%
  rbindlist(idcol = TRUE) %>%
  setnames(".id", "language")

tfidf_tokens[, tfIdf := round(tfIdf, 4)]

names_factors <- c("language" ,"class")

for(col in names_factors)
  set(tfidf_tokens, j = col, value = as.factor(tfidf_tokens[[col]]))

usethis::use_data(tfidf_tokens, compress = "xz",internal = TRUE, overwrite = TRUE)
