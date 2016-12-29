#' retrieve ETOPO Bathymetry Data in a Bounding Box
#'
#' @keywords internal
#'  \code{getETOPO} is an internal Function retrieve ETOPO Bathymetry Data in a
#'       Bounding Box given by xpos, ypos
#'
#'  @param dataStruct - A structure describing the dataset from erddapStruct.rda
#'  @param xpos1 - A list of reals size 2 of the longitude bounds
#'  @param ypos - A list of reals size 2 of the latitude bounds
#'  @param verbose - Logical variable if true will produce verbose
#'     output from httr:GET
#'  @param urlbase - A character string giving the base URL of the ERDDAP server
#'  @return Named Data array with data, or else NaN

getETOPO <- function(dataStruct, xpos1, ypos, verbose, urlbase='https://coastwatch.pfeg.noaa.gov/erddap/griddap/') {

returnCode <- 0
xlim1 <- min(xpos1)
xlim2 <- max(xpos1)
ylim1 <- min(ypos)
ylim2 <- max(ypos)
if (dataStruct$datasetname == "etopo360") {
   if ((xlim1 < 0) | (xlim2 > 360)) {
     print('xpos  (longtude) has elements out of range of the dataset')
     print('longtiude range in xpos')
     print(paste0(xlim1, ',', xlim2))
     returnCode <- 1
    }
} else {
   if ((xlim1 < -180) | (xlim2 > 180)) {
     print('xpos  (longtude) has elements out of range of the dataset')
     print('longtiude range in xpos')
     print(paste0(xlim1, ',',  xlim2))
     returnCode <- 1
   }
}
if ((ylim1 < -90) | (ylim2 > 90)) {
    print('ypos  (latitude) has elements out of range of the dataset')
    print('latitude range in ypos')
    print(paste0(ylim1, ',', ylim2))
    returnCode <- 1
}
if (returnCode == 0) {
  myURL <- paste(urlbase, dataStruct$datasetname, '.csv?latitude[0:1:last]', sep="")
  latitude <- utils::read.csv(myURL, skip=2, header=FALSE)
  latitude <- latitude[, 1]
  myURL <- paste(urlbase, dataStruct$datasetname, '.csv?longitude[0:1:last]', sep="")
  longitude <- utils::read.csv(myURL, skip=2, header=FALSE)
  longitude <- longitude[, 1]
  lat1 <- latitude[which.min(abs(latitude - ylim1))]
  lat2 <- latitude[which.min(abs(latitude - ylim2))]
  lon1 <- longitude[which.min(abs(longitude - xlim1))]
  lon2 <- longitude[which.min(abs(longitude - xlim2))]
  myURL <- paste(urlbase, dataStruct$datasetname, '.nc?altitude',
              '[(', lat1, '):1:(', lat2,')]',
              '[(', lon1, '):1:(', lon2, ')]', sep="")
  myHTTP <- getErddapURL(myURL, 'tmpExtract.nc', verbose)
  if (myHTTP == 0) {
    fileout <- 'tmpExtract.nc'
    datafileID <- ncdf4::nc_open(fileout)
    datalongitude <- ncdf4::ncvar_get(datafileID, varid="longitude")
    datalatitude <- ncdf4::ncvar_get(datafileID, varid="latitude")
    param <- ncdf4::ncvar_get(datafileID, varid='altitude')
    ncdf4::nc_close(datafileID)
    out.array <- list()
    out.array$data <- param
    out.array$latitude <- datalatitude
    out.array$longitude <- datalongitude
  } else {
      print("Error trying to retrive file, status")
      returnCode <- -1
  }
}
#clean things up
myDir <- getwd()
myFile <- paste0(myDir, '/', fileout)
  if (file.exists(myFile)) {
    file.remove(myFile)
  }

if(returnCode == -1){
  out.array <- NaN
}


    return(list(out.array=out.array, returnCode=returnCode))
}
