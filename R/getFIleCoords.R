#'
#' Get Cooordinate  (Dimension) Data from ERDDAP Dataset
#'
#' @keywords internal
#' \code{getFileCoords} is an internal function that gets the coordinate
#' (dimension) variables of the requested dataset
#'
#' @param dataStruct A structure describing the dataset from erddapStruct.rda
#' @param urlbase A character string giving the base URL of the ERDDAP server
#' @return A list containing the values of the coordinate variables
#'



getfileCoords <- function(dataStruct, urlbase='http://coastwatch.pfeg.noaa.gov/erddap/griddap/') {

  #get dimension info
  hasAltitude <- dataStruct$hasAlt
  myURL <- paste(urlbase,dataStruct$datasetname, '.csv?time[0:1:last]', sep="")
  isotime <- utils::read.csv(myURL, skip=2, stringsAsFactors = FALSE, header=FALSE )
  isotime <- isotime[, 1]
  udtime <- as.Date(isotime, origin='1970-01-01', tz= "GMT")
  myURL <- paste(urlbase, dataStruct$datasetname, '.csv?latitude[0:1:last]', sep="")
  latitude <- utils::read.csv(myURL, skip=2, header=FALSE)
  latitude <- latitude[, 1]
  myURL <- paste(urlbase, dataStruct$datasetname, '.csv?longitude[0:1:last]', sep="")
  longitude <- utils::read.csv(myURL, skip=2, header=FALSE)
  longitude <- longitude[, 1]
  if (hasAltitude) {
    myURL <- paste(urlbase, dataStruct$datasetname, '.csv?altitude[0:1:last]', sep="")
    altitude <- utils::read.csv(myURL, skip=2, header=FALSE)
    altitude <- altitude[, 1]
  }


  if (hasAltitude) {
     returnlist <- list(isotime, udtime, latitude, longitude, altitude)
   } else{
    returnlist <- list(isotime, udtime, latitude, longitude)
   }
} #function getfileinfo
