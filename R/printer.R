#' Silly pipe print
#'
#' @param x character vector to paste
#'
#' @return A character vector
#' @export
#'
#' @import magrittr
#' @import dplyr
#' @examples
printer <- function(x){
  paste0("x = ", x) %>%
    print
}
