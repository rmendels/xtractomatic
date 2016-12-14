#' Extract dataset information for a given dtype name or number
#'
#' \code{getInfo} displays the dataset information for a given
#'  dtype or dtypename
#' @export
#' @param dtype - character string or integer (1-138) for given dataset
#' @return prints out dataset information
#' @examples
#' getInfo('atsstamday')
#' getInfo(7)
#' @section Details:
#' getInfo gives the dataset information for the given dataset. This includes:
#' dtypename,datasetname,longname,varname.  It will return the following
#' information about any dataset that matches the string:
#' \itemize{
#' \item dtypename
#' \item datasetname
#' \item longname
#' \item varname
#' \item hasAlt
#' \item latSouth
#' \item lon360
#' \item minLongitude
#' \item maxLongitude
#' \item longitudeSpacing
#' \item minLatitude
#' \item maxLatitude
#' \item latitudeSpacing
#' \item minAltitude
#' \item maxAltitude
#' \item minTime
#' \item maxTime
#' \item timeSpacing
#' \item infoUrl
#'  }



getInfo <- function(dtype) {

structLength <- nrow(erddapStruct)
#  check that we have a valid reuqest
   if (is.character(dtype)) {
     dtypePresent <- dtype %in% erddapStruct$dtypename
     if (!dtypePresent) {
       print(paste0('dataset name does not match: ', dtype))
       print('use "getinfo" to find relevant information ')
       stop('no matching dataset found')
     }
   } else {
     if ((dtype < 1) | (dtype > structLength)) {
       print(paste0('dataset number out of range: ', dtype))
       print(paste0('dtype must be between 1 and ', structLength))
       print('use "getInfo" to find relevant information ')
       stop('no matching dataset found')
     }
   }

   if (is.character(dtype)) {
     dataStruct <- subset(erddapStruct, erddapStruct$dtypename == dtype)
   }else{
     dataStruct <- erddapStruct[dtype, 1:19]
   }
   dataStruct <- getMaxTime(dataStruct)
   tempNames <- colnames(dataStruct)
   tempNames[18] <- "timeSpacing(days)"
   outFrame <- data.frame(matrix(NA, nrow = 19, ncol = 1), row.names = tempNames)
   for (j in 1:15) {
     outFrame[j, 1] <- dataStruct[1, j]
   }
   outFrame[16, 1] <- as.character(dataStruct[1, 16])
   outFrame[17, 1] <- as.character(dataStruct[1, 17])
   outFrame[18, 1] <- dataStruct[1, 18]
   outFrame[18, 1] <- as.numeric(outFrame[18, 1])/86400.
   outFrame[19, 1] <- dataStruct[1, 19]
   colnames(outFrame) <- c("")
   print(dataStruct$dtypename)
   print(outFrame)
   cat("\n")

#   cat(paste0(format(names(dataStruct)), ": ", dataStruct, collapse = "\n"), "\n", sep = "")
}
