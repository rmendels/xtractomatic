#' Extract dataset information for a given dtype name or number
#'
#' \code{getInfo} displays the dataset information for a given
#'  dtype or dtypename
#' @export
#' @param dtype - character string or integer (1-138) for given dataset
#' @return prints out dataset information
#' @examples
#' getInfo('atsstamday')
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


#  check that we have a valid reuqest
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
   dataStruct <- getMaxTime(dataStruct)
   tempNames <- colnames(dataStruct)
   tempNames[18] <- "timeSpacing(days)"
   outFrame <- dataStruct
   outFrame$minTime <- as.character(outFrame$minTime)
   outFrame$maxTime <- as.character(outFrame$maxTime)
   outFrame$timeSpacing <- as.numeric(outFrame$timeSpacing)/86400.
   #print(dataStruct$dtypename)
   utils::str(outFrame)
   #cat("\n")
   #View(outFrame)
   #DT::datatable(outFrame)

#   cat(paste0(format(names(dataStruct)), ": ", dataStruct, collapse = "\n"), "\n", sep = "")
}
