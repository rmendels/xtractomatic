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

buildURL <- function(dataStruct, lonBounds, latBounds, timeBounds, urlbase="https://coastwatch.pfeg.noaa.gov/erddap/griddap/") {
  lon1 <- lonBounds[1]
  lon2 <- lonBounds[2]
  lat1 <- latBounds[1]
  lat2 <- latBounds[2]
  time1 <- timeBounds[1]
  time2 <- timeBounds[2]
  hasAltitude <- dataStruct$hasAlt
  datasetname <- dataStruct$datasetname
  varname <- dataStruct$varname

  myURL <- paste0(urlbase, datasetname, '.nc?', varname)
  query <- ""
  if (!is.na(dataStruct$minTime)) {
    time1 <- timeBounds[1]
    time2 <- timeBounds[2]
    timeArg <- paste0('[(', time1, '):1:(', time2, ')]')
    query <- paste0(query, timeArg)
  }
  if (hasAltitude) {
    altitude <- dataStruct$minAltitude
    altArg <- paste0('[(', as.character(altitude), '):1:(', as.character(altitude), ')]')
    query <- paste0(query, altArg)
  }
  latArg <- paste0('[(', lat1, '):1:(', lat2, ')]')
  query <- paste0(query, latArg)
  lonArg <- paste0('[(', lon1, '):1:(', lon2, ')]')
  query <- paste0(query, lonArg)
  myURL <- paste0(myURL, query)

  return(myURL)

}
