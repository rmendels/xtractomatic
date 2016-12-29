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



getfileCoords <- function(dataStruct, urlbase='https://coastwatch.pfeg.noaa.gov/erddap/griddap/') {

  #get dimension info
  hasAltitude <- dataStruct$hasAlt
  numtries <- 5

  myURL <- paste(urlbase,dataStruct$datasetname, '.csv?time[0:1:last]', sep = "")
  numtries <- 5
  tryn <- 0
  goodtry <- -1
  options(warn = 2)
  while ((tryn <= numtries) & (goodtry == -1)) {
    tryn <- tryn + 1
    isotime <- try( utils::read.csv(myURL, skip = 2, stringsAsFactors = FALSE, header = FALSE ), silent = TRUE)
    if (!class(isotime) == "try-error") {
      goodtry <- 1
      isotime <- isotime[, 1]
      udtime <- as.Date(isotime, origin = '1970-01-01', tz = "GMT")
    }
  }
  myURL <- paste(urlbase, dataStruct$datasetname, '.csv?latitude[0:1:last]', sep = "")
  tryn <- 0
  goodtry <- -1
  options(warn = 2)
  while ((tryn <= numtries) & (goodtry == -1)) {
    tryn <- tryn + 1
    latitude <- try(utils::read.csv(myURL, skip = 2, header = FALSE), silent = TRUE)
    if (!class(latitude) == "try-error") {
      goodtry <- 1
      latitude <- latitude[, 1]
    }
  }
  myURL <- paste(urlbase, dataStruct$datasetname, '.csv?longitude[0:1:last]', sep = "")
  tryn <- 0
  goodtry <- -1
  options(warn = 2)
  while ((tryn <= numtries) & (goodtry == -1)) {
    tryn <- tryn + 1
    longitude <- try(utils::read.csv(myURL, skip = 2, header = FALSE), silent = TRUE)
    if (!class(longitude) == "try-error") {
      goodtry <- 1
      longitude <- longitude[, 1]
    }
  }
  if (hasAltitude) {
    myURL <- paste(urlbase, dataStruct$datasetname, '.csv?altitude[0:1:last]', sep = "")
    tryn <- 0
    goodtry <- -1
    options(warn = 2)
    while ((tryn <= numtries) & (goodtry == -1)) {
      tryn <- tryn + 1
      altitude <- try(utils::read.csv(myURL, skip = 2, header = FALSE), silent = TRUE)
      if (!class(altitude) == "try-error") {
        goodtry <- 1
        altitude <- altitude[, 1]
      }
    }
  }


  if (hasAltitude) {
     returnlist <- list(isotime, udtime, latitude, longitude, altitude)
   } else{
    returnlist <- list(isotime, udtime, latitude, longitude)
   }
} #function getfileinfo
