#' xtractomatic: Routines to simplify data extraction using ERD's ERDDAP web service.
#'
#' The xtractomatic package is a set of routines to simplify accessing data
#' using ERD's ERDDAP data web service.  The package contains three main
#' functions and two helper functions.
#'
#' @section Main Functions:
#' \itemize{
#' \item \code{xtracto} - Extracts an environmental variable along a track defined by
#'  its longtiude, latitude and time.
#' \item \code{xtracto_3D} - Extracts an environmental variable in a
#' 3D  (longitude,latitude, time) bounding box
#' \item \code{xtractogon} - Extracts an environmental variable in a spatial
#' polygon through time.
#'  }
#'
#' @section Helper Functions:
#'  \itemize{
#' \item \code{searchData} - Searches to see if given string is contained
#' in the datasetname, varname, or dtypename. See ?searchData.
#' \item \code{getInfo} - Returns information about a given environmental variable.
#' See ?getInfo.
#'  }
#'
#'  @section Details:
#' When the xtractomatic package is loaded  ("library(xtractomatic)") a data
#' structure called erddapStruct is automatically loaded into memory, and is
#' explicitly used in searchData and getInfo, as well implicitly in
#' the other functions. Not all ERDDAP variables are accessed in the routines,
#' and this structure defines information about the datasets, including:
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
#' Besides the terse help documents,  more  detail in using the
#' functions are given  in the included vignette "Usingxtractomatic". The datasets used
#' in the vignette are included in the "data" directory.
#'
#' @docType package
#' @name xtractomatic
NULL
