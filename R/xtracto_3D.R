
#' Extract environmental data in a 3-D bounding box using ERDDAP.
#'
#' \code{xtracto_3D} uses the ERD ERDDAP data web service to extact
#' environmental data in a given longitude, latitude and time bounding box
#' @export
#' @param xpos - 2-element array giving min and max longitude (in decimal
#'   degrees East, either 0-360 or -180 to 180)
#' @param ypos - 2-element array giving min and max latitude (in decimal
#'   degrees N; -90 to 90)
#' @param tpos - 2-element array giving min and max time (specify both minimum
#'   and maximum dates). For the last available time, use "last".
#' @param dtype - number or string identfying the ERDDAP parameter to extract
#' @param verbose - logical for verbose download output, default FALSE
#' @return structure with data and dimensions:
#' \itemize{
#'   \item extract$data - the data array dimensioned (lon,lat,time)
#'   \item extract$varname - the name of the parameter extracted
#'   \item extract$datasetname - ERDDAP dataset name
#'   \item extract$longitude - the longitudes on some scale as request
#'   \item extract$latitude - the latitudes always going south to north
#'   \item extract$time - the times of the extracts
#'   }
#' @examples
#' xpos <- c(230, 232)
#' ypos <- c(40, 42)
#' tpos <- c('2006-05-05', '2006-05-06')
#' extract <- xtracto_3D(xpos, ypos, tpos, 150)
#' \donttest{
#' extract <- xtracto_3D(xpos, ypos, tpos, 150, verbose=TRUE)
#' extract <- xtracto_3D(xpos, ypos, tpos, 'erdMBsstd8day')
#' }

xtracto_3D <- function(xpos, ypos, tpos, dtype, verbose=FALSE) {

  # default URL for NMFS/SWFSC/ERD  ERDDAP server
  urlbase <- 'https://coastwatch.pfeg.noaa.gov/erddap/griddap/'
  urlbase1 <- 'https://coastwatch.pfeg.noaa.gov/erddap/tabledap/allDatasets.csv?'
  structLength <- nrow(erddapStruct)

  if ((length(xpos) != 2) | (length(ypos) != 2)  |  (length(tpos) != 2)) {
    stop('input vectors not all of length 2')
  }
  if (is.character(dtype)) {
    dtypePresent <- dtype %in% erddapStruct$dtypename
    if (!dtypePresent) {
      print('dataset name: ', dtype)
      stop('no matching dataset found')
    }
    dataStruct <- subset(erddapStruct, erddapStruct$dtypename == dtype)
  } else {
    if ((dtype < 1) | (dtype > structLength)) {
      print('dataset number out of range - must be between 1 and 107: ', dtype)
      stop('no matching dataset found')
    }
    dataStruct <- erddapStruct[dtype,]
  }
  xpos1 <- xpos
  #put given longitudes on the dataset longitudes
  if (dataStruct$lon360) {
    xpos1 <- make360(xpos1)
  } else {
    xpos1 <- make180(xpos1)
  }

# Bathymetry is a special case lets get it out of the way
if (dataStruct$datasetname == "etopo360" || dataStruct$datasetname == "etopo180") {
  result <- getETOPO(dataStruct, xpos1, ypos, verbose)
    if (result$returnCode == -1) {
       stop('error in getting ETOPO data - see error messages')
    } else {
      return(result$out.array)
     }
}

#dataStruct<-getMaxTime(dataStruct)
#get dimension info
dataCoordList <- getfileCoords(dataStruct)
if (!is.list(dataCoordList)) {
  stop("Error retrieving coordinate variable")
}
isotime <- dataCoordList[[1]]
udtime <- dataCoordList[[2]]
latitude <- dataCoordList[[3]]
longitude <- dataCoordList[[4]]
if (dataStruct$hasAlt) {
  altitude <- dataCoordList[[5]]
}
lenTime <-length(isotime)
dataStruct$maxTime <- isotime[lenTime]
tpos1 <- tpos
if (grepl("last", tpos1[1])) {
  tlen <- nchar(tpos1[1])
  arith <- substr(tpos1[1], 5, tlen)
  tempVar <- paste0(as.character(lenTime), arith)
  tIndex <- eval(parse(text=tempVar))
  tpos1[1] <- isotime[tIndex]
}

if (grepl("last", tpos1[2])) {
  tlen <- nchar(tpos1[2])
  arith <- substr(tpos1[2], 5, tlen)
  tempVar <- paste0(as.character(lenTime), arith)
  tIndex <- eval(parse(text=tempVar))
  tpos1[2] <- isotime[tIndex]
}


#convert time format
udtpos <- as.Date(tpos1, origin='1970-01-01', tz= "GMT")

xposLim <- c(min(xpos1), max(xpos1))
yposLim <- c(min(ypos), max(ypos))
tposLim <- c(min(udtpos), max(udtpos))

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
erddapTimes <- rep(NA_real_, 2)
erddapLats[1] <- latitude[which.min(abs(latitude - latBounds[1]))]
erddapLats[2] <- latitude[which.min(abs(latitude - latBounds[2]))]
erddapLons[1] <- longitude[which.min(abs(longitude- lonBounds[1]))]
erddapLons[2] <- longitude[which.min(abs(longitude - lonBounds[2]))]
erddapTimes[1] <- isotime[which.min(abs(udtime- tposLim[1]))]
erddapTimes[2] <- isotime[which.min(abs(udtime - tposLim[2]))]

myURL <- buildURL(dataStruct, erddapLons, erddapLats, erddapTimes)
#Download the data from the website to the current R directory
fileout <- "tmpExtract.nc"
downloadReturn <- getErddapURL(myURL, fileout, verbose)
if (downloadReturn != 0) {
   print(myURL)
   stop("There was an error in the url call.  See message on screen and URL called")
}

varname <- dataStruct$varname
datafileID <- ncdf4::nc_open(fileout)
datalongitude <- ncdf4::ncvar_get(datafileID, varid="longitude")
datalatitude <- ncdf4::ncvar_get(datafileID, varid="latitude")
datatime <- ncdf4::ncvar_get(datafileID, varid="time")
datatime <- as.Date(as.POSIXlt(datatime, origin='1970-01-01', tz= "GMT"))

param <- ncdf4::ncvar_get(datafileID, varid=varname)

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
extract$time <- as.character(datatime)
if (dataStruct$hasAlt) {
  extract$altitude <- altitude
}


#clean things up
if (file.exists(fileout)) {
  file.remove(fileout)
}

return(extract)
}

