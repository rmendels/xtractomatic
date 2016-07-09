#' Convert Longitudes to (-180,180)
#' @keywords internal
#' \code{make180} is an internal function that converts a vector of longitudes
#' from (0,360) to (-180,180)
#'
#' @param lon A vector of longitudes
#' @return A vector of longitudes all mapped to (-180,180)
#'



make180 <- function(lon) {

    ind <- which(lon > 180)
    lon[ind] <- lon[ind] - 360
   return(lon)
}
