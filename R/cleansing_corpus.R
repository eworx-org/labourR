#' Title
#'
#' @param text character vector
#' @param rem_newline boolean
#' @param rem_nonalphanum boolean
#' @param rem_longwords boolean
#' @param rem_space boolean
#' @param tolower boolean
#'
#' @return A character vector
#' @export
#'
#' @examples
#' txt <- "It has roots in a piece of classical Latin literature from 45 BC"
#' cleansing_corpus(txt)
cleansing_corpus <- function(
  text,
  rem_newline = TRUE,
  rem_nonalphanum = TRUE,
  rem_longwords = TRUE,
  rem_space = TRUE,
  tolower = TRUE
){

  if(class(text) != "character")
    stop("text must be character vector")

  if(rem_newline)text <- gsub("[\r\n\t]", " ", text)
  if(rem_nonalphanum)text <- gsub("[^[:alnum:]]", " ", text) # removing non-alphanumeric
  if(rem_longwords)text <- gsub("\\w{35,}", " ", text) ## Removing words with more than 30 letters
  if(rem_space)text <- gsub("\\s+", " ", text)  # removing excess space
  if(tolower)text <- tolower(text)
  trimws(text)
}
