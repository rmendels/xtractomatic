
#' Extract environmental data in a 3-D bounding box using ERDDAP.
#'
#' \code{xtracto_3D} uses the ERD ERDDAP data web service to extact
#' environmental data in a given longitude, latitude and time bounding box
#' @export
#' @param dtype - number or string identifying the ERDDAP parameter to extract
#' @param xpos - 2-element array giving min and max longitude (in decimal
#'   degrees East, either 0-360 or -180 to 180)
#' @param ypos - 2-element array giving min and max latitude (in decimal
#'   degrees N; -90 to 90)
#' @param tpos - 2-element array giving min and max time (specify both minimum
#'   and maximum dates). For the last available time, use "last". Default NA.
#' @param verbose - logical for verbose download output, default FALSE
#' @return structure with data and dimensions:
#' \itemize{
#'   \item extract$data - the data array dimensions (lon,lat,time)
#'   \item extract$varname - the name of the parameter extracted
#'   \item extract$datasetname - ERDDAP dataset name
#'   \item extract$longitude - the longitudes on some scale as request
#'   \item extract$latitude - the latitudes always going south to north
#'   \item extract$time - the times of the extracts
#'   }
#' @examples
#' xpos <- c(-130., -125.)
#' ypos <- c(30., 35.)
#' tpos <- c('2015-01-16', '2015-02-16')
#' extract <- xtracto_3D('mhsstdmday', xpos, ypos, tpos = tpos)
#' \donttest{
#' xpos <- c(230, 231)
#' ypos <- c(40, 41)
#' tpos <- c('2006-05-05', '2006-05-06')
#' extract <- xtracto_3D('erdMBsstd8day', xpos, ypos, tpos = tpos, verbose=TRUE)
#' }

xtracto_3D <- function(dtype, xpos, ypos, tpos = NA,  verbose=FALSE) {
  # default URL for NMFS/SWFSC/ERD  ERDDAP server
  urlbase <- 'https://coastwatch.pfeg.noaa.gov/erddap/griddap/'
  urlbase1 <- 'https://coastwatch.pfeg.noaa.gov/erddap/tabledap/allDatasets.csvp?'
  # assume time isn't need,  make length 2 for test.  Check later
    if (is.na(tpos[1])) {
    tpos <- c(NA, NA)
  }
  if ((length(xpos) != 2) | (length(ypos) != 2)  |  (length(tpos) != 2)) {
    stop('input vectors not all of length 2')
  }
  if (!is.character(dtype)) {
    stop('dtype must be a character string')
  }
  dtypePresent <- dtype %in% colnames(erddapStruct)
  if (!dtypePresent) {
    print(paste0('dataset name does not match: ', dtype))
    print('use "getinfo" to find relevant information ')
    stop('no matching dataset found')
  }
  dataStruct <- erddapStruct[[dtype]]
  #  check that the dataset is available
  myURL <- paste(urlbase1,'datasetID&datasetID="', dataStruct$datasetname, '"', sep = "")
  r1 = httr::GET(utils::URLencode(myURL))
  requestStatus <- httr::status_code(r1)
  if (!(requestStatus == 200)) {
    stop('requested dataset not available at present - try again later')
  }
  # abort if times are missing and dataset require times
  hasTime <- !is.na(dataStruct$minTime)
  if (hasTime && is.na(tpos[1])) {
    stop('time is not given,  dataset has time dimension')
  }
  # take care of case where times are given but dataset doesn't have times
  if (!hasTime) {
    tpos <- c(NA, NA)
  }
  hasAltitude <- dataStruct$hasAlt
   xpos1 <- xpos
  #put given longitudes on the dataset longitudes
  if (dataStruct$lon360) {
    xpos1 <- make360(xpos1)
  } else {
    xpos1 <- make180(xpos1)
  }


#dataStruct<-getMaxTime(dataStruct)
#get dimension info
dataCoordList <- getfileCoords(dataStruct)
if (!is.list(dataCoordList)) {
  stop("Error retrieving coordinate variable")
}
isotime <- dataCoordList[["isotime"]]
udtime <- dataCoordList[["udtime"]]
latitude <- dataCoordList[["latitude"]]
longitude <- dataCoordList[["longitude"]]
altitude <- dataCoordList[["altitude"]]

tposLim <- c(NA, NA)
if (hasTime) {
  lenTime <- length(isotime)
  dataStruct$maxTime <- isotime[lenTime]
  tpos1 <- tpos
  if (grepl("last", tpos1[1])) {
    tlen <- nchar(tpos1[1])
    arith <- substr(tpos1[1], 5, tlen)
    tempVar <- paste0(as.character(lenTime), arith)
    tIndex <- eval(parse(text = tempVar))
    tpos1[1] <- as.character(isotime[tIndex])
  }

  if (grepl("last", tpos1[2])) {
    tlen <- nchar(tpos1[2])
    arith <- substr(tpos1[2], 5, tlen)
    tempVar <- paste0(as.character(lenTime), arith)
    tIndex <- eval(parse(text = tempVar))
    tpos1[2] <- as.character(isotime[tIndex])
  }
  udtpos <- as.Date(tpos1, origin = '1970-01-01', tz = "GMT")
  tposLim <- c(min(udtpos), max(udtpos))
}
xposLim <- c(min(xpos1), max(xpos1))
yposLim <- c(min(ypos), max(ypos))

#check that coordinate bounds are contained in the dataset

result <- checkBounds(dataStruct, xposLim, yposLim, tposLim)
if (result != 0) {
  stop("Coordinates out of dataset bounds - see messages above")
}


# define spatial bounding box
lonBounds <- c(min(xpos1), max(xpos1))
if (dataStruct$latSouth) {
    latBounds <- c(min(ypos), max(ypos))
} else {
    latBounds <- c(max(ypos), min(ypos))
   }


#map request limits to nearest ERDDAP coordinates
erddapLats <- rep(NA_real_, 2)
erddapLons <- rep(NA_real_, 2)
erddapTimes <- rep(NA, 2)
#tempTimes <- (rep(NA, 2))
erddapLats[1] <- latitude[which.min(abs(latitude - latBounds[1]))]
erddapLats[2] <- latitude[which.min(abs(latitude - latBounds[2]))]
erddapLons[1] <- longitude[which.min(abs(longitude - lonBounds[1]))]
erddapLons[2] <- longitude[which.min(abs(longitude - lonBounds[2]))]
if (hasTime) {
  erddapTimes[1] <- as.character(isotime[which.min(abs(udtime - tposLim[1]))])
  erddapTimes[2] <- as.character(isotime[which.min(abs(udtime - tposLim[2]))])
  erddapTimes <- as.Date(erddapTimes, origin = '1970-01-01', tz = "GMT")
}

myURL <- buildURL(dataStruct, erddapLons, erddapLats, erddapTimes)
#Download the data from the website to the current R directory
#fileout <- "tmpExtract.nc"
ncDir <- tempdir()
fileout <- tempfile('tempData', tmpdir = ncDir, fileext = '.nc')
downloadReturn <- getErddapURL(myURL, fileout, verbose)
if (downloadReturn != 0) {
   print(myURL)
   stop("There was an error in the url call.  See message on screen and URL called")
}

varname <- dataStruct$varname
datafileID <- ncdf4::nc_open(fileout)
datalongitude <- ncdf4::ncvar_get(datafileID, varid = "longitude")
datalatitude <- ncdf4::ncvar_get(datafileID, varid = "latitude")
if (hasTime) {
  datatime <- ncdf4::ncvar_get(datafileID, varid = "time")
  datatime <- as.POSIXlt(datatime, origin = '1970-01-01', tz = "GMT")
  }

param <- ncdf4::ncvar_get(datafileID, varid = varname)
if (!hasTime || (erddapTimes[1] == erddapTimes[2])) {
  param <- array(param, c(dim(param), 1))
}

ncdf4::nc_close(datafileID)
#  put longitudes back on the requestors scale
#  reqeust is on (0,360), data is not
if (max(xpos) > 180.) {
   datalongitude <- make360(datalongitude)
}
#request is on (-180,180)
if (min(xpos) < 0.) {
  datalongitude <- make180(datalongitude)
}
if (length(datalatitude) > 1) {
   if (datalatitude[1] > datalatitude[2]) {
     datalatitude <- rev(datalatitude)
     latLen <- length(datalatitude)
     param <- param[, rev(seq_len(latLen)) ,]
   }
}
#out.array<-array(param,dim=c(length(longitudes),length(datalatitude),length(datatime)))
#rownames<-paste(longitudes,'E',sep="")
#colnames<-paste(datalatitude,'N',sep="")
#laynames<-as.character(datatime)
#dimnames(out.array)<-list(rownames,colnames,laynames)
extract <- list()
extract$data <- param
extract$varname <- dataStruct$varname
extract$datasetname <- dataStruct$datasetname
extract$latitude <- datalatitude
extract$longitude <- datalongitude
extract$time <- NA
if (hasTime) {
  extract$time <- datatime
}
extract$altitude <- NA
if (hasAltitude) {
  extract$altitude <- altitude
}
# names(extract)[1] <- varname

#clean things up
if (file.exists(fileout)) {
  file.remove(fileout)
}

return(extract)
}

