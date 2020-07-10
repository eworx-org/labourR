#' Get language code from file name
#'
#' Occupations' labels and structure are exposed at the ESCO web portal. This function retrieves languages
#' from the downloadable CSVs, see \href{https://ec.europa.eu/esco/portal/escopedia/ESCO_languages}{escopedia}.
#'
#' @param string Filepath with a language code as given by ESCO downloadable .CSVs.
#'
#' @return A character vector with two-letter language codes.
#' @export
#'
#' @examples
#' get_language_code("occupations_en.csv")
#'
get_language_code <- function(string){
  string <- gsub(".*_", "", string)
  gsub("\\..*", "", string)
}

#' Retrieve stopwords
#'
#' The functions retrieves stopwords from the \code{\link{stopwords}} package using the ISO-639-1 encoding.
#' For miscellaneous languages \code{\link{data_stopwords_misc}} are used.
#'
#' @param code A string with the language code of the stopwords.
#'
#' @return Character vector with the stopwords or NULL if the language code is unknown.
#' @export
#'
#' @importFrom stopwords stopwords stopwords_getlanguages
#'
#' @examples
#' get_stopwords("en")
get_stopwords <- function(code){

  if (code %in% stopwords_getlanguages("misc"))
    return(stopwords(code, source = "misc")[[1]])
  else if (code %in% stopwords_getlanguages("stopwords-iso"))
    return(stopwords(code, source = "stopwords-iso"))
  else if (code %in% stopwords_getlanguages("snowball"))
    return(stopwords(code, source = "snowball"))
  else
    warning(paste("no stopwords retrieved for", code))

  NULL

}

