#' Check Coordinate Dimensions
#'
#' @keywords internal
#' \code{checkBounds} is an internal function that checks that the requested
#' latitude, longitude, time bounds are within th dataset bounds
#'
#' @param dataStruct A structure describing the dataset from erddapStruct.rda
#' @param xposLim A list of reals size 2 that contains the longitude limits of
#'   the data request
#' @param yposLim A list of reals size 2 that contains the latitude limits of
#'   the data request
#' @param xposLim A list of strings  size 2 that contains the time limits of the
#'   data request
#' @return returnCode of 0 if all data is in bounds of the served data, -1
#'   otherwise
#'

checkBounds <- function(dataStruct, xposLim, yposLim, tposLim) {
# now that we are set up do bounds checking
  returnCode <- 0
  hasTime <- !is.na(dataStruct$minTime)

# check longitudes
   if ((xposLim[1] < dataStruct$minLongitude)  || (xposLim[2] > dataStruct$maxLongitude)) {
     print('xpos  (longtude) has elements out of range of the dataset')
     print('longtiude range in xpos')
     print(paste0(xposLim[1], ',',  xposLim[2]))
     print('longitude range in ERDDAP data')
     print(paste0(dataStruct$minLongitude, ',', dataStruct$maxLongitude))
     returnCode <- -1
   }

# check latitudes
  if ((yposLim[1] < dataStruct$minLatitude)  || (yposLim[2] > dataStruct$maxLatitude)) {
     print('ypos  (latitude) has elements out of range of the dataset')
     print('latitiude range in ypos')
     print(paste0(yposLim[1], ',', yposLim[2]))
     print('latitude range in ERDDAP data')
     print(paste0(dataStruct$minLatitude, ',', dataStruct$maxLatitude))
     returnCode <- -1
  }


# check time
  if (hasTime) {
    minTime <- as.Date(dataStruct$minTime, origin='1970-01-01', tz= "GMT")
    maxTime <- as.Date(dataStruct$maxTime, origin='1970-01-01', tz= "GMT")
    if ((tposLim[1] < minTime)  || (tposLim[2] > maxTime)) {
      print('tpos  (time) has elements out of range of the dataset')
      print('time range in tpos')
      print(paste0(tposLim[1], ',', tposLim[2]))
      print  ('time range in ERDDAP data')
      print(paste0(dataStruct$minTime, ',', dataStruct$maxTime))
      returnCode <- -1
    }

  }
 return(returnCode)
}
