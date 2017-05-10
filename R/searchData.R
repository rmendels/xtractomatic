#' Extract dataset information based on a list of character strings
#'
#' \code{searchData} finds the all datasets that contain the supplied string
#' in the given dataset field
#' @export
#' @param searchList - A list of lists
#' each list will contain the field to search and the search string
#'
#' @return dataframe with any matching information
#' @examples
#' list1 <- 'varname:chl'
#' list2 <- 'datasetname:mday'
#' mylist <- c(list1, list2)
#' searchResult <- searchData(mylist)
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
  #junk <- which(grepl('VH2',unlist(erddapStruct['dtypename',])))
  #pos = regexpr('pattern', x) # Returns position of 1st match in a string
  #pos = gregexpr('pattern', x) # Returns positions of every match in a string

  listLen <- length(searchList)
  dataStruct <- erddapStruct
  listLen <- length(searchList)
  myList <- c('dtypename', 'datasetname', 'longname', 'varname')
  for (i in 1:listLen) {
    tempList <- searchList[[i]]
    pos = regexpr(':', tempList)
    requestType <- substr(tempList, 1, pos - 1)
    requestString <- substr(tempList, pos + 1, nchar(tempList))
    inList <- requestType %in% myList
    if (!inList) {
      print('requestType must be one of:')
      print('dtypename, datasetname, longname, varname')
      print(paste0('you requested :', requestType))
      return()
    }
     myindex <- grep(requestString, dataStruct[requestType,])
     dataStruct <- dataStruct[, myindex]

  }
    ilen <- ncol(dataStruct)
    if (!(ilen > 0)) {
      stop('no match found for the combined search')
    }
    for (i in 1:ilen) {
     tempStruct <- dataStruct[, i]
     tempStruct <- getMaxTime(tempStruct)
     tempStruct$minTime <- as.character(tempStruct$minTime)
     tempStruct$maxTime <- as.character(tempStruct$maxTime)
     tempStruct$timeSpacing <- as.numeric(tempStruct$timeSpacing)/86400.
     dataStruct[[i]] <- tempStruct
     # dataStruct[, i] <- tempStruct
     # colnames(outFrame) <- c("")
     #print.data.frame(tempStruct)
     #View(tempStruct)
     #cat("\n")
#     cat(paste0(format(names(dataStruct)), ": ", dataStruct, collapse = "\n"), "\n", sep = "")
    }
    #View(dataStruct)
    return(dataStruct)
}
