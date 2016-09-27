#' Build an ERDDAP URL
#'
#' @keywords internal
#' \code{buildURL}  is an internal function that builds the ERDDAP URL from the information provided
#'
#' @param dataStruct A structure describing the dataset from erddapStruct.rda
#' @param lonBounds A list or reals size two of the longitude bounds
#' @param latBounds A list of reals size 2 of the latitude bounds
#' @param timeBounds A list of strings size two of the time bounds
#' @param urlbase A character string giving the base URL of the ERDDAP server
#' @return The ERDDAP URL to call

buildURL <- function(dataStruct, lonBounds, latBounds, timeBounds, urlbase="http://coastwatch.pfeg.noaa.gov/erddap/griddap/") {
  lon1 <- lonBounds[1]
  lon2 <- lonBounds[2]
  lat1 <- latBounds[1]
  lat2 <- latBounds[2]
  time1 <- timeBounds[1]
  time2 <- timeBounds[2]
  hasAltitude <- dataStruct$hasAlt
  datasetname <- dataStruct$datasetname
  varname <- dataStruct$varname

  # text string for data retrieval call
  if (hasAltitude) {
    altitude <- dataStruct$minAltitude
    altitudeBound <- paste('[(', as.character(altitude), '):1:(', as.character(altitude), ')]', sep="")
    myURL <- paste(urlbase, datasetname, '.nc?', varname, '[(', time1, '):1:(', time2, ')]',
                altitudeBound,
                '[(', lat1, '):1:(', lat2, ')]',
                '[(', lon1, '):1:(', lon2, ')]', sep="")
  } else {
    myURL <- paste(urlbase, datasetname, '.nc?', varname, '[(', time1, '):1:(', time2, ')]',
                '[(', lat1, '):1:(', lat2, ')]',
                '[(', lon1, '):1:(', lon2, ')]', sep="")
  }

  return(myURL)

}
