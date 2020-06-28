# classify_occupation <- function(corpus, id_col = "id", text_col = "text", lang_col = "language", ...){
#
#   # due to NSE notes in R CMD check
#   NULL -> language
#
#   corpus <- as.data.table(corpus)
#   if(!lang_col %in% names(corpus)){
#     corpus[, language := identify_language(corpus[, get(text_col)])]
#   }
#
# }
