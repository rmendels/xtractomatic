#'
#' Get Coordinate  (Dimension) Data from ERDDAP Dataset
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
  hasTime <- !is.na(dataStruct$minTime)
  numtries <- 5

  isotime <- NA
  udtime <- NA
  if (hasTime) {
    myURL <- paste(urlbase,dataStruct$datasetname,
                   '.csvp?time[0:1:last]', sep = "")
    numtries <- 5
    tryn <- 0
    goodtry <- -1
    options(warn = 2)
    while ((tryn <= numtries) & (goodtry == -1)) {
      tryn <- tryn + 1
      # isotime <- try( utils::read.csv(myURL, skip = 2, stringsAsFactors = FALSE, header = FALSE ), silent = TRUE)
      r1 <- try( httr::GET(myURL), silent = TRUE)
      if (!class(r1) == "try-error") {
        goodtry <- 1
        # isotime <- isotime[, 1]
        isotime <- suppressMessages(readr::read_csv(r1$content)[[1]])
        udtime <- as.Date(isotime, origin = '1970-01-01', tz = "GMT")
      }
    }

  }

  altitude <- NA
  if (hasAltitude) {
    myURL <- paste(urlbase, dataStruct$datasetname,
                   '.csvp?altitude[0:1:last]', sep = "")
    tryn <- 0
    goodtry <- -1
    options(warn = 2)
    while ((tryn <= numtries) & (goodtry == -1)) {
      tryn <- tryn + 1
      # altitude <- try(utils::read.csv(myURL, skip = 2, header = FALSE), silent = TRUE)
      r1 <- try(httr::GET(myURL), silent = TRUE)
      if (!class(r1) == "try-error") {
        goodtry <- 1
        #altitude <- altitude[, 1]
        altitude <- suppressMessages(readr::read_csv(r1$content)[[1]])
      }
    }
  }

  latitude <- NA
  myURL <- paste(urlbase, dataStruct$datasetname,
                 '.csvp?latitude[0:1:last]', sep = "")
  tryn <- 0
  goodtry <- -1
  options(warn = 2)
  while ((tryn <= numtries) & (goodtry == -1)) {
    tryn <- tryn + 1
    # latitude <- try(utils::read.csv(myURL, skip = 2, header = FALSE), silent = TRUE)
    r1 <- try(httr::GET(myURL), silent = TRUE)
    if (!class(r1) == "try-error") {
      goodtry <- 1
     #  latitude <- latitude[, 1]
      latitude <- suppressMessages(readr::read_csv(r1$content)[[1]])
    }
  }

  longitude <- NA
  myURL <- paste(urlbase, dataStruct$datasetname,
                 '.csvp?longitude[0:1:last]', sep = "")
  tryn <- 0
  goodtry <- -1
  options(warn = 2)
  while ((tryn <= numtries) & (goodtry == -1)) {
    tryn <- tryn + 1
    # longitude <- try(utils::read.csv(myURL, skip = 2, header = FALSE), silent = TRUE)
    r1 <- try(httr::GET(myURL), silent = TRUE)
    if (!class(r1) == "try-error") {
      goodtry <- 1
      # longitude <- longitude[, 1]
      longitude <- suppressMessages(readr::read_csv(r1$content)[[1]])
    }
  }


  returnlist <- list("isotime" = isotime, "udtime" = udtime,
                     "altitude" = altitude, "latitude" = latitude,
                     "longitude" = longitude)

}
