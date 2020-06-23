#' Detect Language
#'
#' @description
#' `identify_language()`` performs language detection by combining Compact Language Detector 2 and 3 from CRAN libraries \code{\link{cld2}} and \code{\link{cld3}}.
#' The function is vectorised and guesses the language of each string. Note that it is not designed to do well on very short text,
#' lists of proper names, part numbers, etc. CLD2 has the hightest F1 score and is an order of magnitude faster.
#'
#' @param text A string with text to classify or a connection to read from.
#' @param alg Specification of algorithm to be used:
#'
#' \itemize{
#'   \item cld2: Probabilistically (Naïve Bayesian classifier) detects over 80 languages in plain text.
#'   \item cld3: Neural network model for language identification.
#'   \item both: Combination of cld2 and cld3. A result is returned only when the two algorithms agree.
#' }
#'
#' @return A character vector with ISO-639-1 two-letter language codes.
#' @export
#'
#' @examples
#' txt <- c("English is a West Germanic language ", "In espaniol, le lingua castilian")
#' identify_language(txt)
#'
identify_language <- function(text, alg = "cld2"){
  if(alg == "cld2") return(cld2::detect_language(text))
  if(alg == "cld3") return(cld3::detect_language(text))
  if(alg == "both"){
    res_cld2 <- cld2::detect_language(text)
    res_cld3 <- cld3::detect_language(text)
    return(ifelse(res_cld2 == res_cld3, res_cld2, NA))
  }
  stop("Provide a valid option for alg argument")
}
