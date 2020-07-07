#' Cleansing Corpus
#'
#' The function performs text cleansing by removing escape characters, non alphanumeric,
#' long-words, excess space, and turns all letters to lower case.
#'
#' @param text Character vector of free text to be cleansed.
#' @param escape_chars If TRUE, removes escape characters for `slash n`, `slash r` and `slash t`.
#' @param nonalphanum If TRUE, removes non-alphanumeric characters.
#' @param longwords If TRUE, removes words with more than 35 characters.
#' @param whitespace If TRUE, removes excess whitespace.
#' @param tolower If TRUE, turns letters to lower.
#'
#' @return A character vector of the cleansed text.
#' @export
#'
#' @examples
#' txt <- "It has roots in a piece of classical Latin literature from 45 BC"
#' cleansing_corpus(txt)
cleansing_corpus <- function(
  text,
  escape_chars = TRUE,
  nonalphanum = TRUE,
  longwords = TRUE,
  whitespace = TRUE,
  tolower = TRUE) {

  if(class(text) != "character")
    stop("text must be character vector")
  if(escape_chars)text <- gsub("[\r\n\t]", " ", text)
  if(nonalphanum)text <- gsub("[^[:alnum:]]", " ", text) # removing non-alphanumeric
  if(longwords)text <- gsub("\\w{35,}", " ", text) ## Removing words with more than 35 letters
  if(whitespace)text <- gsub("\\s+", " ", text)  # removing excess space
  if(tolower)text <- tolower(text)
  trimws(text)

}
