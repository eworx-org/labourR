#' Term frequency–Inverse document frequency
#'
#' @description Measure weighted amount of information concerning the specificity of terms in a corpus.
#' Term frequency–Inverse document frequency is one of the most frequently applied weighting schemes in information retrieval systems.
#' The tf–idf is a statistical measure proportional to the number of times a word appears in the document, but is offset by the number of documents
#' in the corpus that contain the word. Variations of the tf–idf are often used to estimate a document's relevance given a
#' free-text query.
#'
#' @param corpus Input data, with an id column and a text column. Can be of type data.frame or data.table.
#' @param stopwords A character vector of stopwords. Stopwords are filtered out before calculating numerical statistics.
#' @param id_col Input data column name with the ids of the documents.
#' @param text_col Input data column name with the documents.
#' @param tf_weight Weighting scheme of term frequency. Choices are `raw_count`, `double_norm` or `log_norm` for raw count, double normalization at 0.5 and log normalization respectively.
#' @param idf_weight Weighting scheme of inverse document frequency. Choices are `idf` and `idf_smooth` for inverse document frequency and inverse document frequency smooth respectively.
#' @param min_chars Words with less characters than `min_chars` are filtered out before calculating numerical statistics.
#' @param norm Boolean value for document normalization.
#'
#' @return A data.table with three columns, namely `class` derived from given document ids, `term` and `tfIdf`.
#'
#' @export
#'
#' @import data.table
#' @import magrittr
#'
#' @examples
#' \dontrun{
#' library(data.table)
#' corpus <- occupations_bundle[, text := paste(preferredLabel, altLabels)]
#' corpus <- occupations_bundle[, text := cleansing_corpus(text)]
#' corpus <- corpus[ , .(conceptUri, text)]
#' setnames(corpus, c("id", "text"))
#' tf_idf(corpus)
#' }
tf_idf <- function(
  corpus,
  stopwords = NULL,
  id_col = "id",
  text_col = "text",
  tf_weight = "double_norm",
  idf_weight = "idf_smooth",
  min_chars = 2,
  norm = TRUE
) {

  # due to NSE notes in R CMD check
  NULL -> term -> tf -> term_count -> idf -> docFreq -> tfIdf

  corpus <- as.data.table(corpus)
  tokensList <- strsplit(corpus[, get(text_col)], " ")
  names(tokensList) <- corpus[, get(id_col)]

  tokensDT <- lapply(tokensList, as.data.table) %>%
    rbindlist(idcol = TRUE) %>%
    setnames(c("class", "term"))

  tokensDT <- tokensDT[!term %in% stopwords][nchar(term) >= min_chars]
  tfDT <- tokensDT[, list(term_count = .N), by = c("class", "term")]

  if(tf_weight == "double_norm") tfDT[, tf := 0.5 + 0.5 * term_count / max(term_count, na.rm = TRUE), by = "class"]
  if(tf_weight == "raw_count") tfDT[, tf := term_count]
  if(tf_weight == "log_norm") tfDT[, tf := log(1 + term_count)]

  idfDT <- tokensDT[!duplicated(tokensDT)][, list(docFreq = .N), by = "term"]
  if(idf_weight == "idf_smooth") idfDT[, idf :=  log(length(unique(tokensDT$class)) / (docFreq + 1)) + 1]
  if(idf_weight == "idf") idfDT[, idf :=  log(length(unique(tokensDT$class)) / docFreq)]

  res <- merge(tfDT, idfDT, on = "term")[, tfIdf := tf * idf][, list(class, term, tfIdf)]
  if(norm)
    res[, tfIdf := tfIdf / sum(tfIdf), by = "class"]

  res

}
