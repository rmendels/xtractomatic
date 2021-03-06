#' Extract environmental data in a polygon using ERDDAP.
#'
#' \code{xtractogon} uses the ERD ERDDAP data web service to extact
#' environmental data inside a polygon defined by vectors of
#' latitudes and longitudes
#' @export
#' @param dtype - number or string identifying the ERDDAP parameter to extract
#' @param xpos - array giving longitudes (in decimal
#'   degrees East, either 0-360 or -180 to 180) of polygon
#' @param ypos -  array giving latitudes (in decimal
#'   degrees N; -90 to 90)of polygon
#' @param tpos - 2-element array giving min and max time (specify both minimum
#'   and maximum dates). For the last available time, use "last". Default NA.
#' @param verbose - logical for verbose download out, default FALSE
#' @return structure with data and dimensions
#' \itemize{
#'   \item extract$data - the masked data array dimensions (lon,lat,time)
#'   \item extract$varname - the name of the parameter extracted
#'   \item extract$datasetname - ERDDAP dataset name
#'   \item extract$longitude - the longitudes on some scale as request
#'   \item extract$latitude - the latitudes always going south to north
#'   \item extract$time - the times of the extracts
#'   }
#' @examples
#' tpos <- c("2014-09-01", "2014-10-01")
#' xpos <- mbnms$Longitude
#' ypos <- mbnms$Latitude
#' sanctchl <- xtractogon('erdVH3chlamday', xpos, ypos, tpos = tpos )
#' @section Details:
#'  xtractogon extracts the data from the smallest bounding box that contains
#'  the polygon, and then uses the function "point.in.polygon" from the "sp"
#'  package to mask out the areas outside of the polygon.





xtractogon <- function(dtype, xpos, ypos, tpos = NA,  verbose = FALSE)
{
  tpos1 <- tpos
  if (!is.na(tpos1[1])) {
    if (length(tpos1) == 1) {
      tpos1 <- rep(tpos1, 2)
    }
  }

  if (length(xpos) != length(ypos)) {
    print('xpos and ypos are not of the same length')
    stop('program stops')
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


#extend out tpos to be length 2 if not
poly <- data.frame(xpos, ypos)
colnames(poly) <- c('x', 'y')
xpos1 <- c(min(xpos), max(xpos))
ypos1 <- c(min(ypos), max(ypos))

# call xtracto to get data
   extract <- xtracto_3D(dtype, xpos1, ypos1, tpos = tpos1, verbose)
  if (length(dim(extract$data)) == 2) {
    extract$data <- array(extract$data, c(dim(extract$data), 1))
  }

# make sure polygon is closed; if not, close it.
	if ((poly[length(poly[,1]), 1] !=  poly[1, 1]) | (poly[length(poly[,2]), 2] != poly[1, 2])) {
		poly <- rbind(poly, c(poly[1,1], poly[1, 2]))
	}

x.vals <- matrix(rep(extract$longitude, length(extract$latitude)), ncol = length(extract$latitude))
y.vals <- sort(rep(extract$latitude, length(extract$longitude)))
y.vals <- matrix(y.vals, nrow = length(extract$latitude), ncol = length(extract$longitude))
# deal with polygon crossing 180
ew.sign <- sign(poly$x)
if (length(unique(ew.sign)) > 1) {
  poly$x[poly$x < 0] <- poly$x[poly$x < 0] + 360
  x.vals[x.vals < 0] <- x.vals[x.vals < 0] + 360
  print("Polygon data cross 180. Converted to E longitudes")
}

# create new array masked by polygon
#     in.poly <- matrix(point.in.polygon(x.vals, y.vals, poly$x, poly$y), ncol = length(dimnames(extract)[[1]]))
in.poly <- matrix(sp::point.in.polygon(x.vals, y.vals, poly$x, poly$y), ncol = length(extract$longitude))
in.poly[in.poly > 1] <- 1
in.poly[in.poly == 0] <- NA
dim(in.poly) <- dim(extract$data[, , 1])
extract.in.poly <- apply(extract$data, 3, "*", in.poly)
dim(extract.in.poly) <- dim(extract$data)
extract$data <- extract.in.poly

return(extract)
}

