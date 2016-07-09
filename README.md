# xtractomatic
xtractomatic R package for accessing environmental data

`xtractomatic` is an <span style="color:blue">R</span> package developed to subset and extract satellite and other oceanographic related data from a remote server. The program can extract data for a moving point in time along a user-supplied set of longitude, latitude and time points; in a 3D bounding box; or within a polygon (through time).  The `xtractomatic` functions were originally developed for the marine biology tagging community, to match up environmental data available from satellites (sea-surface temperature, sea-surface chlorophyll, sea-surface height, sea-surface salinity, vector winds) to track data from various tagged animals or shiptracks (`xtracto`). The package has since been extended to include the routines that extract data a 3D bounding box (`xtracto_3D`) or within a polygon (`xtractogon`).  The `xtractomatic`  package accesses  data that are served through the <span style="color:blue">ERDDAP</span> (Environmental Research Division Data Access Program) server at the NOAA/SWFSC Environmental Research Division in Santa Cruz, California. The <span style="color:blue">ERDDAP</span> server can also be directly accessed at <http://coastwatch.pfeg.noaa.gov/erddap>. <span style="color:blue">ERDDAP</span> is a simple to use yet powerful web data service developed by Bob Simons.  


There are three main data extraction functions in the `xtractomatic` package: 

- `xtracto <- function(xpos, ypos, tpos, dtype, xlen, ylen, verbose=FALSE)`

- `xtracto_3D <- function(xpos, ypos, tpos, dtype, verbose=FALSE)`

- `xtractogon <- function(xpos, ypos, tpos, dtype, verbose=FALSE)`


There also are two information functions in the `xtractomatic` package: 

- `searchData <- function(searchList=list(list("varname","chl"))) ` 

- `getInfo <- function(dtype)`

`xtractomatic` uses the `httr`, `ncdf4` and `sp` packages , and these packages (and the packages imported by these packages) must be installed first or `xtractomatic` will fail to install.   

```{r install,eval=FALSE}
install.packages("httr", dependencies = TRUE)
install.packages("ncdf4") 
install.packages("sp")
```

The `xtractomatic` package at the moment can be installed from Github using the devtools package:

```{r install,eval=FALSE}
install.packages("devtools")
devtools::install_github("rmendels/xtractomatic")
```

The vignette provides a lot of examples of using `xtractomatic`, and it is not built by default by `devtools`.

To install and build the Vignette, do:

```{r install,eval=FALSE}
install.packages("devtools")
devtools::install_github("rmendels/xtractomatic", build_vignettes = TRUE)
```

The Vignette examples require the following packages and will not build if they are not installed:

- `ggplot2`
- `ggfortify` 
- `lubridate`
- `mapdata`
- `RColorBrewer`
- `reshape2`
- `xts`


Note however, that the Vignette generates graphics by doing a large number of downloads using `xtractomatic`, and the build may fail if the server is busy or your internet line is slow.
If you can not get the Vignette to build, a pdf version can be downloaded from http://coastwatch.pfeg.noaa.gov/xtracto or email me at roy.mendelssohn@noaa.gov.


# Required legalese

“The United States Department of Commerce (DOC) GitHub project code is provided
on an ‘as is’ basis and the user assumes responsibility for its use.
DOC has relinquished control of the information and no longer has responsibility
to protect the integrity, confidentiality, or availability of the information.
Any claims against the Department of Commerce stemming from the use of its
GitHub project will be governed by all applicable Federal law. Any reference to
specific commercial products, processes, or services by service mark, trademark,
manufacturer, or otherwise, does not constitute or imply their endorsement,
recommendation or favoring by the Department of Commerce. The Department of
Commerce seal and logo, or the seal and logo of a DOC bureau, shall not be used
in any manner to imply endorsement of any commercial product or activity by DOC
or the United States Government.”


