#' My Hello
#'
#' @param x The name
#'
#' @return The output \code{\link{print}} and of \code{\link{print}}
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

#' @section
#' hello2("aaaa")
#' \dontrun{
#' hello2("CoRona")
#' }

hello2 <- function(x) {
  paste0("Konnichi wa!", x) %>%
    print
}
