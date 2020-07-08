#' Detect Language
#'
#' @description
#' This function performs language detection by using Compact Language Detector 2 from CRAN library \code{\link{cld2}}.
#' It is vectorised and guesses the language of each string. Note that it is not designed to do well on very short text,
#' lists of proper names, part numbers, etc. CLD2 has the highest F1 score and is an order of magnitude faster than CLD3.
#'
#' @param text A string with text to classify or a connection to read from.
#'
#' \itemize{
#'   \item cld2: Probabilistically (Naïve Bayesian classifier) detects over 80 languages in plain text.
#' }
#'
#' @return A character vector with ISO-639-1 two-letter language codes.
#' @export
#'
#' @examples
#' txt <- c("English is a West Germanic language ", "In espaniol, le lingua castilian")
#' identify_language(txt)
#'
identify_language <- function(text){
  cld2::detect_language(text)
}
