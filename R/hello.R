#' My Hello
#'
#' @param x The name
#'
#' @return The output \code{\link{print}}
#' @export
#'
#' @examples
#' hello("aaaa")
#' \dontrun{
#' hello("CoRona")
#' }
hello <- function(x) {
  paste0("Hello, world!", x) %>%
    print
}

hello2 <- function(x) {
  paste0("Hello, world!", x) %>%
    print
}
