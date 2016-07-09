#' Convert Longitudes to (0,360)
#' @keywords internal
#' \code{make360} is an internal function that converts a vector of longitudes
#' from (-180,180) to (0,360)
#'
#' @param lon A vector of longitudes
#' @return A vector of longitudes all mapped to (0,360)
#'

make360 <- function(lon) {

    ind <- which(lon < 0)
    lon[ind] <- lon[ind] + 360

  return(lon)
}
