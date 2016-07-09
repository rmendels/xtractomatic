#' Extract dataset information based on a list of character strings
#'
#' \code{searchData} finds the all datasets that contain the supplied string
#' in the given dataset field
#' @export
#' @param searchList - A list of lists
#' each list will contain the field to search and the search string
#'
#' @return prints out any matching information
#' @examples
#' list1 <- list('varname', 'chl')
#' list2 <- list('datasetname', 'mday')
#' mylist <- list(list1, list2)
#' searchData(mylist)
#' @section Details:
#' searchData will search for the given string in any of the fields
#' dtypename,datasetname,longname,varname.  Over the list of
#' searchs provided, the search sequentially refines
#' the search result based on the next list in the list of lists.
#'
#' It will return the following
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





searchData <- function(searchList=list(list("varname", "chl"))) {
  dataStruct <- erddapStruct
  listLen <- length(searchList)
  myList<-c('dtypename', 'datasetname', 'longname', 'varname')
  for (i in 1:listLen) {
    tempList <- searchList[[i]]
    requestType <- tempList[1]
    requestString <- tempList[2]
    inList <- requestType %in% myList
    if (!inList) {
      print('requestType must be one of:')
      print('dtypename, datasetname, longname, varname')
      print(paste0('you requested :', requestType))
      return()
    }
    request <- paste("grep('", requestString, "',dataStruct$", requestType,")", sep="")
    myindex <- eval(parse(text=request))
    dataStruct <- dataStruct[myindex, 1:19]

  }
    ilen <- nrow(dataStruct)
    for (i in 1:ilen) {
     tempStruct <- dataStruct[i,]
     tempStruct <- getMaxTime(tempStruct)
     tempNames <- colnames(tempStruct)
     outFrame <- data.frame(matrix(NA, nrow=19, ncol=1), row.names=tempNames)
     for (j in 1:15) {
       outFrame[j,1] <- tempStruct[1, j]
     }
     outFrame[16, 1] <- as.character(tempStruct[1, 16])
     outFrame[17, 1] <- as.character(tempStruct[1, 17])
     outFrame[18, 1] <- as.numeric(tempStruct[1, 18])/86400.
     outFrame[19, 1] <- tempStruct[1, 19]
     colnames(outFrame) <- c("")
     print(tempStruct$dtypename)
     print(outFrame)
     cat("\n")
#     cat(paste0(format(names(dataStruct)), ": ", dataStruct, collapse = "\n"), "\n", sep = "")
   }
}
