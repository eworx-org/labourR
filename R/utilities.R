#' Get language code from file name
#'
#' Occupations' labels and structure are exposed throught the ESCO web portal. This function retrieves languages
#' from the downloadable CSVs, see \href{https://ec.europa.eu/esco/portal/escopedia/ESCO_languages}{escopedia}.
#'
#' @param string Filepath with a language code as given by esco downloadable .CSVs.
#'
#' @return A character vector with two-letter language codes.
#'
#' @examples
#' \dontrun{
#' get_language_code("occupations_en.csv")
#' }
get_language_code <- function(string){
  string <- gsub(".*_", "", string)
  gsub("\\..*", "", string)
}
