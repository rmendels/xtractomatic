#' Download Data using an ERDDAP URL
#' @keywords internal
#' \code{getErddapURL} is an internal function makes the URL request to ERDDAP
#'
#' @param myURL A character string containing the full ERDDAP URL
#' @param destfile A character string with the name of the file to store the
#'   returned data, a netcdf file
#' @return downloadReturn returns 0 is successful, -1 otherwise
#'


getErddapURL <- function(myURL, destfile, verbose=FALSE) {
  numtries <- 10
  tryn <- 1
  requestStatus <- 0
  while (tryn < numtries & requestStatus != 200) {
     if (verbose) {
       myHTTP <- httr::GET(myURL, httr::verbose(), httr::progress(), httr::write_disk(destfile, overwrite = TRUE))
     } else {
       myHTTP <- httr::GET(myURL, httr::write_disk(destfile, overwrite = TRUE))
     }
     requestStatus <- httr::status_code(myHTTP)
     if (requestStatus == 200) {
#        binContent <- httr::content(myHTTP, "raw")
#        writeBin(binContent, destfile)
         downloadReturn <- 0
         break
     } else if ((requestStatus == 500) | (requestStatus == 404)) {
        print(paste0("Error trying to retrive file, status", requestStatus))
        print("Header Info of URL Request")
        httr::headers(myHTTP)
        downloadReturn <- -1
        break
     } else {
       print(paste0("Download Attempt: ", tryn))
       print(paste0("Error trying to retrive file, status", requestStatus))
       print("Header Info of URL Request")
       httr::headers(myHTTP)
       print("Will pause and try again")
       Sys.sleep(5)
       tryn <- tryn + 1
     }

   }  #while
   return(downloadReturn)
} #function
