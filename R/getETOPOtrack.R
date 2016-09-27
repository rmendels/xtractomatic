#' retrieve ETOPO Bathymetry Data along a track
#'
#' @keywords internal
#'  \code{getETOPOtrack}  is an internal Function retrieve ETOPO Bathymetry Data
#'   in a Bounding Box given by xpos, ypos
#'
#'  @param dataStruct - A structure describing the dataset from erddapStruct.rda
#'  @param xpos - A list of reals of the track longitudes
#'  @param ypos - A list of reals of the track latitude bounds
#'  @param xrad - A list of reals with distance around given longitude
#'    to make extract
#'  @param yrad - A list of reals with distance around given latitude
#'    to make extract
#'  @param verbose - Logical variable if true will produce verbose
#'     output from httr:GET
#'  @param urlbase - A character string giving the base URL of the ERDDAP server
#'  @return Named Data array with data, or else NaN

getETOPOtrack <- function(dataStruct, xpos, ypos, xrad, yrad, verbose, urlbase='http://coastwatch.pfeg.noaa.gov/erddap/griddap/'){
  returnCode <- 0
  xlim1 <- min(xpos)
  xlim2 <- max(xpos)
  ylim1 <- min(ypos)
  ylim2 <- max(ypos)
  out.dataframe <- as.data.frame(matrix(ncol=11, nrow=length(xpos)))
  dimnames(out.dataframe)[[2]] <- c('mean', 'stdev', 'n', 'satellite date', 'requested lon min', 'requested lon max', 'requested lat min', 'requested lat max', 'requested date', 'median', 'mad')
  oldLonIndex <- rep(NA_integer_, 2)
  oldLatIndex <- rep(NA_integer_, 2)
  oldTimeIndex <- rep(NA_integer_, 2)
  newLonIndex <- rep(NA_integer_, 2)
  newLatIndex <- rep(NA_integer_, 2)
  newTimeIndex <- rep(NA_integer_, 2)
  oldDataFrame <- as.data.frame(matrix(ncol=11, nrow=1))

  if (dataStruct$datasetname == "etopo360") {
    if ((xlim1 < 0) | (xlim2 > 360)) {
      print('xpos  (longtude) has elements out of range of the dataset')
      print('longtiude range in xpos')
      print(paste0(xlim1, ',',  xlim2))
      returnCode <- 1
    }
  } else {
    if ((xlim1 < -180) | (xlim2 > 180)) {
      print('xpos  (longtude) has elements out of range of the dataset')
      print('longtiude range in xpos')
      print(paste0(xlim1, ',', xlim2))
      returnCode <- 1
    }
  }
  if ((ylim1 < -90) | (ylim2 > 90)) {
    print('ypos  (latitude) has elements out of range of the dataset')
    print('latitude range in ypos')
    print(paste0(ylim1, ',',  ylim2))
    returnCode <- 1
  }

  if (returnCode == 0) {
    myURL<-paste(urlbase, dataStruct$datasetname, '.csv?latitude[0:1:last]', sep="")
    latitude <- utils::read.csv(myURL, skip=2, header=FALSE)
    latitude <- latitude[, 1]
    myURL <- paste(urlbase, dataStruct$datasetname, '.csv?longitude[0:1:last]', sep="")
    longitude <- utils::read.csv(myURL, skip=2, header=FALSE)
    longitude <- longitude[, 1]
    for (i in 1:length(xpos)) {
      # define bounding box
      xmax <- xpos[i] + (xrad[i]/2)
      xmin <- xpos[i] - (xrad[i]/2)
      if (dataStruct$latSouth) {
        ymax <- ypos[i] + (yrad[i]/2)
        ymin <- ypos[i] - (yrad[i]/2)
      } else {
        ymin <- ypos[i] + (yrad[i]/2)
        ymax <- ypos[i] - (yrad[i]/2)
      } #add rads
      # find closest time of available data
      #map request limits to nearest ERDDAP coordinates
      newLatIndex[1] <- which.min(abs(latitude - ymin))
      newLatIndex[2] <- which.min(abs(latitude - ymax))
      newLonIndex[1] <- which.min(abs(longitude - xmin))
      newLonIndex[2] <- which.min(abs(longitude - xmax))
      if (identical(newLatIndex, oldLatIndex) && identical(newLonIndex, oldLonIndex) && identical(newTimeIndex[1], oldTimeIndex[1])) {
        # the call will be the same as last time, so no need to repeat
        out.dataframe[i,] <- oldDataFrame
      } else {
        erddapLats <- rep(NA_real_,2)
        erddapLons <- rep(NA_real_,2)
        erddapTimes <- rep(NA_real_,2)
        erddapLats[1] <- latitude[newLatIndex[1]]
        erddapLats[2] <- latitude[newLatIndex[2]]
        erddapLons[1] <- longitude[newLonIndex[1]]
        erddapLons[2] <- longitude[newLonIndex[2]]
        myURL <- paste(urlbase, dataStruct$datasetname, '.nc?altitude',
                    '[(', erddapLats[1], '):1:(', erddapLats[2], ')]',
                    '[(', erddapLons[1], '):1:(', erddapLons[2], ')]', sep="")
        myHTTP <- getErddapURL(myURL, 'tmpExtract.nc', verbose)
        if (myHTTP == 0) {
          fileout <- 'tmpExtract.nc'
          datafileID <- ncdf4::nc_open(fileout)
          datalongitude <- ncdf4::ncvar_get(datafileID, varid="longitude")
          datalatitude <- ncdf4::ncvar_get(datafileID, varid="latitude")
          #          paramdata<-ncdf4::ncvar_get(datafileID,varid='altitude')
          paramdata <- as.vector(ncdf4::ncvar_get(datafileID))
          ncdf4::nc_close(datafileID)
          out.dataframe[i, 1] <- mean(paramdata, na.rm=T)
          out.dataframe[i, 2] <- stats::sd(paramdata, na.rm=T)
          out.dataframe[i, 3] <- length(stats::na.omit(paramdata))
          out.dataframe[i, 4] <- NaN
          out.dataframe[i, 5] <- xmin
          out.dataframe[i, 6] <- xmax
          out.dataframe[i, 7] <- ymin
          out.dataframe[i, 8] <- ymax
          out.dataframe[i, 9] <- NaN
          out.dataframe[i, 10] <- stats::median(paramdata, na.rm=T)
          out.dataframe[i, 11] <- stats::mad(paramdata, na.rm=T)
          # clean thing up
          # remove temporary file
           if (file.exists(fileout)) {
              tmp <- file.remove(fileout)
          }
          # remove variable from workspace
          remove('paramdata')
        } else {
          print("Error trying to retrive file, status")
          returnCode <- -1
        } #myHTTP
      }#identical
    }#length
  }#return code

  if(returnCode == -1){
    out.dataframe=NaN
  }
  returnList <- list()
  returnList$out.dataframe <- out.dataframe
  returnList$returnCode <- returnCode
#clean things up


  return(returnList)
}
