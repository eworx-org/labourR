#' Classify occupations
#'
#' @description
#' This function takes advantage of the hierarchical structure of the ESCO-ISCO mapping and matches multilingual free-text with the
#' \href{https://ec.europa.eu/esco/portal/home}{ESCO} occupations vocabulary in order to map semi-structured vacancy data into the official
#' ESCO-ISCO classification.
#'
#' @param corpus A data.frame or a data.table that contains the id and the text variables.
#' @param id_col The name of the id variable.
#' @param text_col The name of the text variable.
#' @param lang The language that the text is in.
#' @param num_leaves The number of occupations/neighbors that are kept when matching.
#' @param isco_level The \href{https://ec.europa.eu/esco/portal/escopedia/Occupation}{ISCO} level of the suggested occupations.
#' Can be either 1, 2, 3, 4 for ISCO occupations, or NULL for ESCO occupations.
#' @param string_dist String distance used for fuzzy matching. The \link[stringdist]{amatch} function from the stringdist package is used.
#'
#' @details
#' First, the input text is cleansed and tokenized. The tokens are then matched with the ESCO occupations vocabulary, created from
#' the \link[=occupations_bundle]{preferred and alternative labels} of the occupations, and joined with the \link[=tf_idf]{tfidf}
#' weighted tokens of the ESCO occupations. After the terms are joined, the suggested ESCO occupations are retrieved using a weighted sum model.
#' If an ISCO level was specified, the K-Nearest Neighbors algorithm is used to determine the suggested occupation of the requested ISCO level,
#' classified by a plurality vote of its neighbors.
#'
#' Before the suggestions are returned, the preferred label of each suggested occupation is added to the result, using the
#' \code{\link{occupations_bundle}} and \code{\link{isco_occupations_bundle}} as look-up tables.
#'
#' @return Either a data.table with the id, the preferred label and the suggested ESCO occupation URIs (num_leaves predictions for each id),
#' or a data.table with the id, the preferred label and the suggested ISCO group of the inputted level (one for each id).
#' @export
#'
#' @references
#' M.P.J. van der Loo (2014). \href{https://journal.r-project.org/archive/2014-1/loo.pdf}{The stringdist package for approximate string matching}. R Journal 6(1) pp 111-122.
#'
#' Turrell, A., Speigner, B., Djumalieva, J., Copple, D., and Thurgood, J. (2018).
#' \href{https://www.bankofengland.co.uk/working-paper/2018/using-job-vacancies-to-understand-the-effects-of-labour-market-mismatch-on-uk-output}{
#' Using job vacancies to understand the effects of labour market mismatch on UK output and productivity}, Staff Working Paper 737, Bank of England.
#'
#' ESCO Service Platform - The ESCO Data Model \href{https://ec.europa.eu/esco/portal/document/en/87a9f66a-1830-4c93-94f0-5daa5e00507e}{documentation}
#'
#' @import data.table
#' @import magrittr
#' @importFrom stringdist amatch
#' @importFrom utils head
#'
#' @examples
#' corpus <- data.frame(
#'  id = 1:3,
#'  text = c("Data Scientist", "Junior Architect Engineer", "Cashier at McDonald's")
#' )
#' classify_occupation(corpus = corpus, isco_level = NULL, lang = "en", num_leaves = 5)
#'
classify_occupation <- function(corpus, id_col = "id", text_col = "text", lang = "en",
                                num_leaves = 10, isco_level = 3, string_dist = NULL) {

  # due to NSE notes in R CMD check
  NULL -> language -> term -> text -> tfIdf -> id -> iscoGroup -> weight_sum -> isco_nn -> conceptUri -> preferredLabel
  occupations_bundle <- occupations_bundle
  isco_occupations_bundle <- isco_occupations_bundle

  if(!any("data.frame" %in% class(corpus)))
    stop("Corpus must be either a data.frame or a data.table.")

  if(!all(c(id_col, text_col) %in% names(corpus)))
    stop(paste0("Corpus must contain the specified variables: ", id_col, " and ", text_col, "."))

  # Prepare corpus.
  corpus <- as.data.table(corpus)
  setnames(corpus, c(id_col, text_col), c("id", "text"))

  # Prepare the weighted tokens and the vocabulary.
  weightTokens <- tfidf_tokens[language == lang]
  if(nrow(weightTokens) == 0)
    stop(paste0(lang, " is not an acceptable language."))
  vocabulary <- unique(tfidf_tokens[language == lang][, list(term)])[order(term)]

  # Cleanse, tokenize free-text and remove stopwords.
  corpus[, text := cleansing_corpus(as.character(text))]
  freeTextTokensList <- lapply(strsplit(corpus$text, split = " "), function(x) x[!x %in% get_stopwords(lang)])
  names(freeTextTokensList) <- corpus$id

  freeTextTokensDT <- lapply(freeTextTokensList, as.data.table) %>%
    rbindlist(idcol = TRUE) %>%
    setnames(c("id", "term"))

  # Match free-text with the vocabulary.
  vocaIndexes <- match(freeTextTokensDT$term, vocabulary$term)
  if(!is.null(string_dist))
    vocaIndexes[is.na(vocaIndexes)] <- amatch(freeTextTokensDT$term[is.na(vocaIndexes)], vocabulary$term, maxDist = string_dist)

  matches <- data.table(id = freeTextTokensDT$id, term = vocabulary[vocaIndexes]$term)[!is.na(term)]

  # Join the free-text matches with the tfidf weighted tokens and keep the top num_leaves using a weighted sum model.
  predictions <- merge(
    matches,
    weightTokens,
    allow.cartesian = TRUE
  )[, list(weight_sum = sum(tfIdf)), by = c("id", "class")][order(id, -weight_sum)][, head(.SD, num_leaves), by = "id"]

  if(!is.null(isco_level) && !isco_level %in% 1:4)
    stop("The ISCO level parameter must be 1, 2, 3, 4 or NULL.")

  setnames(predictions, "class", "conceptUri")

  # The K-Nearest Neighbors algorithm and the suggested occupations are used to determine the most popular occupation of the requested ISCO level.
  if(!is.null(isco_level)) {
    predictions <- merge(predictions, occupations_bundle[, list(conceptUri, iscoGroup)], on = "conceptUri")
    predictions[, iscoGroup := substr(iscoGroup, 0, isco_level)]
    predictions <- predictions[, list(isco_nn = .N), by = c("id", "iscoGroup")
        ][order(id, -isco_nn)
          ][, head(.SD, 1), by = "id"]
    # Add new variable, the preferred label of the ISCO occupation.
    predictions <- merge(
      predictions,
      isco_occupations_bundle,
      on = "iscoGroup"
    )[order(id, -isco_nn)][, list(id, iscoGroup, preferredLabel)]
  } else {
    # Add new variable, the preferred label of the ESCO occupations.
    predictions <- merge(
      predictions,
      occupations_bundle[, list(conceptUri, preferredLabel)],
      on = "conceptUri"
    )[order(id, -weight_sum)][, list(id, conceptUri, preferredLabel)]
  }
  setnames(predictions, "id", id_col)

  predictions
}
