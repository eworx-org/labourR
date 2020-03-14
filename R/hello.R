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
  print(paste0("Hello, world!", x))
}
